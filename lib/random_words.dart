import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
  // Set class represents an unordered collection of unique elements.
  // By using a Set instead of a List, duplicates are automatically prevented.
  // This means that each WordPair object added to _savedWordPairs will only be stored once,
  // regardless of how many times it is added.
  final _savedWordPairs = Set<WordPair>();

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


  // The _buildRow function is responsible for creating a ListTile widget with a title that displays a WordPair
  // in PascalCase format.
  // The WordPair is passed as a parameter to the function. The ListTile widget is then returned by the function.
  // The ListTile widget is commonly used in Flutter to display a single row in a list or a grid.
  Widget _buildRow(WordPair pair) {
    // _buildRow represents each ListTile
    // look at text data and see if it's in _savedWordPairs
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(
      fontSize: 18,)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, color: alreadySaved ? Colors.red : null),
      onTap: () { // onTap event -> user taps the Icon
        setState(() {
          // remove if already saved to _savedWordPairs
          if(alreadySaved) {
            _savedWordPairs.remove(pair);
          } else { // else we add the pair to _savedWordPairs
            _savedWordPairs.add(pair);
          }
        });
      }
      );
  }

  // navigate to different route on the stack
  // use Navigator to add new route on top of stack
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          // list of saved word pairs
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Remove the word pair from the list
                  setState(() {
                    _savedWordPairs.remove(pair);
                  });
                  // Pop the current screen to force a rebuild of the previous screen
                  Navigator.of(context).pop();
                  // Push the screen again with the updated list
                  _pushSaved();
                },
              ),
            );
          });

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
            ),
            body: ListView(children: divided),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('WordPair Generator'),
          //
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: _pushSaved,
            )
          ],
       ), body: _buildList());
  }
}
