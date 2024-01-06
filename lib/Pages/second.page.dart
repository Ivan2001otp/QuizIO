import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/Pages/first.page.dart';
import 'package:quiz_app/Services/NetworkService/dio.service.dart';
import 'package:quiz_app/main.dart';

class SecondPage extends ConsumerStatefulWidget {
  final String category;
  final String difficultyLevel;
  final String questionNos;

  SecondPage({
    required this.category,
    required this.difficultyLevel,
    required this.questionNos,
  });

  @override
  ConsumerState createState() => _SecondPageState(
        category: this.category,
        difficultyLevel: this.difficultyLevel,
        questionNos: this.questionNos,
      );
}

class _SecondPageState extends ConsumerState {
  final String category;
  final String difficultyLevel;
  final String questionNos;

  _SecondPageState({
    required this.category,
    required this.difficultyLevel,
    required this.questionNos,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            ref.read(categoryViolationObserver.notifier).state = true;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FirstPage(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text('Second Page'),
      ),
      body: FutureBuilder(
        future: DioService().request(category, questionNos, difficultyLevel),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (dataSnapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (context, data, ref) {
                return Text(dataSnapshot.data.toString());
              },
            );
          }
          return Text('Nothing');
        },
      ),
    );
  }
}
