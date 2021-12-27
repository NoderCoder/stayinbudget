import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/budget/chart.dart';
import 'package:flutter_complete_guide/widgets/navbar.dart';
import 'package:flutter_complete_guide/budget/new_transaction.dart';
import 'package:flutter_complete_guide/budget/transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  static String id = "MyHomePage";

  // String titleInput;
  // String amountInput;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //this list is the list that stores all the transactions. Will need to seprate this logic from main file
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime userSelectedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: userSelectedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(), //Using different contexxt to show the drawer
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          child: const Icon(
                            Icons.accessibility_new_outlined,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            print("Notifaction button pressed");
                          },
                          icon: Icon(Icons.notifications)),
                    ],
                  ),
                ),
                //this column is for the top messge
                Column(
                  children: [
                    Text(
                      "\$ 250 left for 10 days",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                          fontSize: 14),
                    ),
                    Text(
                      "\$ 12,400.00",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 48, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        }),
                  ],
                ),
                if (_showChart == true) Chart(_recentTransactions),
                TransactionList(_userTransactions, deleteTransaction),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
