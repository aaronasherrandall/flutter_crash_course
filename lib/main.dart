import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// entry point
// define core / root widget MyApp
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // add named 'key' parameter to the constructor
  const MyApp({Key? key}) : super(key: key);

  // override build method; StatelessWidget class already has a build method
  @override // not required ->
  Widget build(BuildContext context) {
    // final is used to declare a variable that can only be set once
    // and cannot be reassigned after it has been assigned a value
    // final wordPair = WordPair.random();
    // every build method has a context as a signature
    return MaterialApp(
      // Define the default brightness and colors.
      theme: ThemeData(
        // New way to set the primary color using colorScheme
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              primary: Colors.purple, // This creates a swatch of purple shades.
            )
            .copyWith(
              secondary: Colors
                  .amber, // // Optional: You can define a secondary color as well.
            ),
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.purple[200], // Set the color directly for the AppBar.
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 25, // Set the predefined font size here.
          ),
          // Other properties of AppBarTheme can be set here as needed.
        ),
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

// this is where our build will go
class RandomWordState extends State<RandomWords> {
  // instance variable of the class RandomWordState
  // _randomWordPairs is a list of WordPair objects.
  // Arrays are called Lists in Dart
  final _randomWordPairs = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        // word paid -> divider -> wordpair -> divider
        // let's return a divider on every odd occurence
        if(item.isOdd) return Divider();

        // calculate # of word pairs in list view - divider widget
        final index = item ~/ 2;

        // generate new word pairs as we scroll down
        if(index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        // return list tile for each iteration
        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('WordPair Generator')),
        body: _buildList());
  }
}

  // The _buildRow function is responsible for creating a ListTile widget with a title that displays a WordPair in PascalCase format.
  // The WordPair is passed as a parameter to the function. The ListTile widget is then returned by the function.
  //The ListTile widget is commonly used in Flutter to display a single row in a list or a grid.
  Widget _buildRow(WordPair pair) {
    return ListTile(title: Text(pair.asPascalCase, style: TextStyle(
      fontSize: 18,
    )));
  }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("WordPair Generator")), body: _buildList());
//   }
// }
