import 'package:quiz_app/Model/choice.bucket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/Pages/second.page.dart';
import 'package:quiz_app/Services/Database/hive.database.dart';

class FirstPage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _FirstPageState();
}

const List<String> categoryList = [
  'Select Category',
  'Linux',
  'DevOps',
  'Networking',
  'Cloud',
  'Docker',
  'Kubernetes',
  'Programming (PHP, JS, Pythong and etc.)',
  'And lots more'
];

const List<String> difficultyLevel = ['Easy', 'Medium', 'Hard'];

const List<int> no_of_questions = [5, 10, 15, 20];

final categoryViolationObserver = StateProvider<bool>((ref) => true);
final difficultyViolationObserver = StateProvider<bool>((ref) => false);
final limitedQsViolationObserver = StateProvider<bool>((ref) => false);

class _FirstPageState extends ConsumerState {
  String pickedCategory = "";
  String pickedDifficulty = difficultyLevel.first;
  String pickedLimitQs = no_of_questions.first.toString();

  void isCategoryConditionViolate(String category) {
    print(category);

    if (category.isEmpty || category == categoryList.first) {
      ref.read(categoryViolationObserver.notifier).state = true;
    }
    ref.read(categoryViolationObserver.notifier).state = false;
  }

  void isDiffConditionViolate(String diff) {
    print(diff);
    if (diff.isEmpty) {
      ref.read(difficultyViolationObserver.notifier).state = true;
    }
    ref.read(difficultyViolationObserver.notifier).state = false;
  }

  void isLimitQsConditionViolate(String val) {
    print(val);
    if (val.isEmpty) {
      ref.read(limitedQsViolationObserver.notifier).state = true;
    }
    ref.read(limitedQsViolationObserver.notifier).state = false;
  }

  @override
  void dispose() {
    CacheRepository.instance.box.then((boxProvider) {
      // boxProvider.clear();
      // boxProvider.close();
    });
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'first page',
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 24),
          height: null,
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: Column(
            children: [
              DropdownMenu<String>(
                menuStyle: MenuStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                initialSelection: categoryList.first,
                // hintText: 'Pick category',
                onSelected: (String? selectedValue) {
                  pickedCategory = selectedValue ?? categoryList.first;
                  isCategoryConditionViolate(pickedCategory);
                  setState(() {});
                },
                dropdownMenuEntries:
                    categoryList.map<DropdownMenuEntry<String>>((String item) {
                  return DropdownMenuEntry(value: item, label: item);
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width * 86 / 100,
                initialSelection: difficultyLevel.first,
                menuStyle: MenuStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onSelected: (String? selectedValue) {
                  pickedCategory = selectedValue ?? difficultyLevel.first;
                  isDiffConditionViolate(pickedCategory);
                  setState(() {});
                },
                dropdownMenuEntries: difficultyLevel
                    .map<DropdownMenuEntry<String>>((String item) {
                  return DropdownMenuEntry(value: item, label: item);
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownMenu<String>(
                width: MediaQuery.of(context).size.width * 86 / 100,
                menuStyle: MenuStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                initialSelection: no_of_questions.first.toString(),
                onSelected: (String? value) {
                  this.pickedLimitQs = value ?? '';
                  isLimitQsConditionViolate(this.pickedLimitQs);
                  setState(() {});
                },
                dropdownMenuEntries: no_of_questions
                    .map<DropdownMenuEntry<String>>((int number) {
                  return DropdownMenuEntry(
                      value: number.toString(), label: '${number}-Questions');
                }).toList(),
              ),
              SizedBox(
                height: 80,
              ),
              if (ref.watch(categoryViolationObserver.notifier).state != true)
                // ref.watch(difficultyViolationObserver.notifier).state !=
                //     true &&
                // ref.watch(limitedQsViolationObserver.notifier).state != true)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    print('pressed!');

                    if (pickedCategory != categoryList.first) {
                      var instance = ChoiceBucket(true, false, pickedCategory,
                          pickedDifficulty, "", pickedLimitQs);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(
                            category: pickedCategory,
                            difficultyLevel: pickedDifficulty,
                            questionNos: pickedLimitQs,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select proper choices.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Go-to-Quiz'),
                ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    var instance = ChoiceBucket(false, true, '', '', '', '');
                    print(instance);
                  },
                  child: Text('Go Random'))
            ],
          ),
        ),
      ),
    );
  }
}
