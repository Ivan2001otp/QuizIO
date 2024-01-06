import 'package:flutter/material.dart';
import 'package:quiz_app/Model/choice.bucket.dart';
import 'package:quiz_app/Pages/first.page.dart';
import 'package:quiz_app/Pages/second.page.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: FirstPage(),
        // home: SecondPage(
        //     category: "Linux", difficultyLevel: '', questionNos: '5'),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
//api key - hrtG3piTvZLbwHnQsBH4Uu7oxDDXGpKLZ6OkUCDj

/*
class QuizIOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: FirstPage(),
    );
  }
}*/
