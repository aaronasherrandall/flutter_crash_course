import 'package:flutter/material.dart';
import './random_words.dart';

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
