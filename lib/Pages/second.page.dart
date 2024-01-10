import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/Model/quiz.model.dart';
import 'package:quiz_app/Pages/first.page.dart';
import 'package:quiz_app/Services/NetworkService/dio.service.dart';
import 'package:quiz_app/Util/helper.util.dart';
import 'package:quiz_app/main.dart';
import 'package:provider/provider.dart' as native_provider;

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

int index = 0;

class _SecondPageState extends ConsumerState {
  final String category;
  final String difficultyLevel;
  final String questionNos;

  _SecondPageState({
    required this.category,
    required this.difficultyLevel,
    required this.questionNos,
  });

  Widget optionWidgetBuilder(
      String optionValue, double widthValue, String booleanValue) {
    return InkWell(
      onTap: () {
        print("clicked $optionValue");

        if (booleanValue == 'true') {
          print('correct');
          showMessage('Hurray , Correct Answer', context);
        } else {
          print('in-correct');
          showMessage('Oops, Incorrect Answer', context);
        }
      },
      child: SizedBox(
        width: widthValue,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: widthValue * 0.04),
          color: Colors.grey.shade400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              optionValue,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            ref.read(categoryViolationObserver.notifier).state = true;

            Navigator.pop(
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
            if (dataSnapshot.hasData)
              return Consumer(
                builder: (context, data, ref) {
                  if (/*dataSnapshot.data == null ||*/
                      dataSnapshot.data.toString() == 'No Response') {
                    return AlertDialog(
                      content: Text('Poor internet Connection !'),
                      title: Text('Network Error'),
                      surfaceTintColor: const Color.fromARGB(255, 45, 45, 45)
                          .withOpacity(0.6),
                      icon: Icon(
                        Icons
                            .signal_cellular_connected_no_internet_0_bar_outlined,
                        color: Colors.red,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            //invoke the futureBuilder again\
                            print('retry');
                          },
                          child: Text('Retry'),
                        )
                      ],
                    );
                  }

                  List<dynamic> mapElements = dataSnapshot.data;
                  //returns a list of map elements
                  List<Quiz> quizList = List<Quiz>.from(
                    mapElements.map(
                      (mapJsonItem) => Quiz.fromJson(mapJsonItem),
                    ),
                  );
                  print('The response length is  ${quizList.length}\n');

                  return Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            quizList[index].category ?? 'Category',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: width_,
                            child: Card(
                              color: Colors.red,
                              margin: EdgeInsets.symmetric(
                                  horizontal: width_ * 0.04),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  quizList[index].question!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          if (quizList[index].answers!.answerA != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerA ?? 'option-A',
                              width_,
                              quizList[index].correctAnswers!.answerACorrect!,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (quizList[index].answers!.answerB != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerB ?? 'option-B',
                              width_,
                              quizList[index].correctAnswers!.answerBCorrect!,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (quizList[index].answers!.answerC != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerC ?? 'option-C',
                              width_,
                              quizList[index].correctAnswers!.answerCCorrect!,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (quizList[index].answers!.answerD != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerD ?? 'option-D',
                              width_,
                              quizList[index].correctAnswers!.answerDCorrect!,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (quizList[index].answers!.answerE != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerE ?? 'option-E',
                              width_,
                              quizList[index].correctAnswers!.answerECorrect!,
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (quizList[index].answers!.answerF != null)
                            optionWidgetBuilder(
                              quizList[index].answers!.answerF ?? 'option-F',
                              width_,
                              quizList[index].correctAnswers!.answerFCorrect!,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            //left button
                            onPressed: () {
                              if (index > 0) {
                                setState(() {
                                  index--;
                                });
                              } else {
                                showMessage(
                                    'You are in first question', context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: BorderSide(
                                    color: Colors.greenAccent, width: 1.5),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_left_rounded,
                              color: Colors.black,
                              size: 64,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                index = (index + 1) % quizList.length;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: BorderSide(
                                    color: Colors.yellow, width: 1.5),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_right_rounded,
                              color: Colors.black,
                              size: 64,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            else if (dataSnapshot.hasError)
              return SizedBox(
                child: Text('Something went wrong bro!'),
              );
          }
          return Text('Nothing');
        },
      ),
    );
  }

  void showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
