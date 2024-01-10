class Quiz {
  Quiz({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    required this.correct_answer,
    required this.explanation,
    required this.tip,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  final int? id;
  final String? question;
  final String? description;
  final Answer? answers;
  final String? multipleCorrectAnswers;
  final CorrectAnswers? correctAnswers;
  final String? correct_answer;
  final dynamic? explanation;
  final String? tip;
  final List<Tag> tags;
  final String? category;
  final String? difficulty;

  factory Quiz.fromJson(Map<dynamic, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      description: json['description'] == null ? null : json['description'],
      answers:
          json['answers'] == null ? null : Answer.fromJson(json['answers']),
      multipleCorrectAnswers: json['multiple_correct_answers'] == null
          ? null
          : json['multiple_correct_answers'],
      correctAnswers: json['correct_answers'] == null
          ? null
          : CorrectAnswers.fromJson(json['correct_answers']),
      correct_answer: json['correct_answer'],
      explanation: json['explanation'],
      tip: json['tip'],
      tags: json['tags'] == null
          ? []
          : List<Tag>.from(
              json['tags']!.map(
                (item) => Tag.fromJson(item),
              ),
            ),
      category: json['category'],
      difficulty: json['difficulty'],
    );
  }
}

class Tag {
  Tag({required this.name});
  final String? name;

  factory Tag.fromJson(Map<dynamic, dynamic> map) {
    return Tag(name: map['name']);
  }
}

class CorrectAnswers {
  CorrectAnswers({
    required this.answerACorrect,
    required this.answerBCorrect,
    required this.answerCCorrect,
    required this.answerDCorrect,
    required this.answerECorrect,
    required this.answerFCorrect,
  });

  final String? answerACorrect;
  final String? answerBCorrect;
  final String? answerCCorrect;
  final String? answerDCorrect;
  final String? answerECorrect;
  final String? answerFCorrect;

  factory CorrectAnswers.fromJson(Map<dynamic, dynamic> map) {
    return CorrectAnswers(
      answerACorrect: map['answer_a_correct'],
      answerBCorrect: map['answer_b_correct'],
      answerCCorrect: map['answer_c_correct'],
      answerDCorrect: map['answer_d_correct'],
      answerECorrect: map['answer_e_correct'],
      answerFCorrect: map['answer_f_correct'],
    );
  }
}

class Answer {
  Answer({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerE,
    required this.answerF,
  });

  final String? answerA;
  final String? answerB;
  final String? answerC;
  final String? answerD;
  final String? answerE;
  final String? answerF;

  factory Answer.fromJson(Map<dynamic, dynamic> map) {
    return Answer(
      answerA: map['answer_a'],
      answerB: map['answer_b'],
      answerC: map['answer_c'],
      answerD: map['answer_d'],
      answerE: map['answer_e'],
      answerF: map['answer_f'],
    );
  }
}
