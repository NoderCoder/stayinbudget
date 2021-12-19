import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'models/transaction.dart';

// void main() {
//   runApp(MyApp());
// }

//===================Hive test

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const favoritesBox = 'favorite_books';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(favoritesBox);
  runApp(MyHiveApp());
}

const List<String> books = [
  // book name, index
  'Harry Potter', // 0
  'To Kill a Mockingbird', // 1
  'The Hunger Games', // 2
  'The Giver', // 3
  'Brave New World', // 4
  'Unwind', // 5
  'World War Z', // 6
  'The Lord of the Rings', // etc...
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

class MyHiveApp extends StatefulWidget {
  @override
  _MyHiveAppState createState() => _MyHiveAppState();
}

class _MyHiveAppState extends State<MyHiveApp> {
  Box<String> favouriateBooksBox;

  onFavoritePressed(int bookIndex) {
    if (favouriateBooksBox.containsKey(bookIndex)) {
      favouriateBooksBox.delete(bookIndex);
      return;
    }
    favouriateBooksBox.put(bookIndex, books[bookIndex]);
  }

  Widget getIcon(int bookIndex) {
    if (favouriateBooksBox.containsKey(bookIndex)) {
      return Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
    return Icon(Icons.favorite_border);
  }

  @override
  void initState() {
    favouriateBooksBox = Hive.box(
        favoritesBox); //Hive.Box fetches the box and loads it in the memory
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Test"),
      ),
      body: ValueListenableBuilder(
        valueListenable: favouriateBooksBox.listenable(),
        builder: (context, Box<String> box, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(books[index]),
                trailing: IconButton(
                  onPressed: () => onFavoritePressed(index),
                  icon: getIcon(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFf7f5fd),
          primaryColorDark: Color(0xFF180448),
          primaryColorLight: Color(0xFF440fc0),
          cardColor: Colors.white,
          accentColor: Color(0xFFffc946),
          colorScheme: ColorScheme.light(),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF180448),
                ),
              ),
          fontFamily: "OpenSans",
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 32,
                fontWeight: FontWeight.bold),
          )),
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      child: const Icon(
                        Icons.accessibility_new_outlined,
                        size: 32,
                        color: Colors.white,
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
              Chart(_recentTransactions),

              TransactionList(_userTransactions, deleteTransaction),
            ],
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
