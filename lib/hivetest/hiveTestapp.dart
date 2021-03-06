import 'package:flutter/material.dart';
//===================Hive test
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   await Hive.initFlutter();
//   await Hive.openBox<String>(favoritesBox);
//   runApp(MyHiveApp());
// }

const favoritesBox = 'favorite_books';

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

  List<String> favouritedList() {
    List<String> tempBookList = [];
    for (int bookKey = 0; bookKey < books.length; bookKey++) {
      if (favouriateBooksBox.containsKey(bookKey)) {
        tempBookList.add(favouriateBooksBox.get(bookKey));
      }
    }
    return tempBookList;
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hive Test"),
          leading: IconButton(
            icon: Icon(Icons.account_balance),
            onPressed: () => print(favouritedList()),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: favouriateBooksBox.listenable(),
          builder: (context, Box<String> box, _) {
            return ListView.builder(
              itemCount: books.length,
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
      ),
    );
  }
}
