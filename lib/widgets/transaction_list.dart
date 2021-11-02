import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_tile.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  List<String> makeSimpleStrings(int i) {
    String title = transactions[i].title;
    String date = DateFormat.yMMMd().format(transactions[i].date);
    String amount = '\$ ${transactions[i].amount.toStringAsFixed(2)}';
    List<String> temp = [title, date, amount];
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "You dont have any transactions yet. Any transactions you add, will show up here :)",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 150,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                print(makeSimpleStrings(index));

                //This is the card that needs to be changed.
                return Column(
                  children: [
                    TransactionTile(
                        makeSimpleStrings(index)[0],
                        makeSimpleStrings(index)[1],
                        makeSimpleStrings(index)[2]),
                  ],
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
