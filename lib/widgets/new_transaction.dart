import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateFormat now = DateFormat.yMd();
  String dateStrignFormatter(DateTime) {
    return now.format(DateTime);
  }

  String userSelectedTime;
  String displayTime;
  DateTime userselectedDate = DateTime.now();

  onSubmitted() {
    final submittedTitleValue = titleController.text;
    final submittedAmountValue = double.parse(amountController.text);

    if (submittedAmountValue <= 0 || submittedTitleValue.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(" Hmm. Somethings missing"),
          content: Text("Transaction Title or Amount missing :( "),
        ),
        barrierDismissible: true,
      );
      return;
    }

    widget.addTx(
      submittedTitleValue,
      submittedAmountValue,
      userselectedDate,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.utc(2020),
            lastDate: DateTime.now())
        .then((userPickedDate) {
      if (userPickedDate != null) {
        setState(() {
          userselectedDate = userPickedDate;
          userSelectedTime = now.format(userPickedDate);
        });
      } else
        return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String todayTime = dateStrignFormatter(DateTime.now());
    displayTime = "$todayTime (Today)";
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.name,
              onSubmitted: (_) => onSubmitted(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmitted(),
              // onChanged: (val) => amountInput = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Date : "),
                    Text(userSelectedTime == null
                        ? todayTime
                        : userSelectedTime),
                  ],
                ),
                TextButton.icon(
                    onPressed: _showDatePicker,
                    icon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    label: Text(
                      "Change",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    )),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            FlatButton(
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Add Transaction'),
                  )),
              textColor: Theme.of(context).scaffoldBackgroundColor,
              onPressed: onSubmitted,
            ),
          ],
        ),
      ),
    );
  }
}
