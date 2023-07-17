import 'package:flutter/material.dart';
import 'package:quizz_app/question.dart';
import 'package:quizz_app/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const QuizzApp());
}

class QuizzApp extends StatelessWidget {
  const QuizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizzPage(),
        ),
      ),
    );
  }
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Icon> scoreKeeper = [];

  Question q1 =
      Question('You can lead a cow down stairs but not up stairs.', false);
  Question q2 = Question(
      'Approximately one quarter of human bones are in the feet.', true);
  Question q3 = Question('A slug\'s blood is green.', true);

  List<Question> questionList = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
  ];
  //questionList.add(q1);

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionList[current].question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper.add(
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                  bool correct = quizBrain.questionList[current].answer;
                  if (correct == true) {
                    print('Correct');
                  } else {
                    print('Not Correct !');
                  }
                  current++;
                  print(scoreKeeper.length);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  scoreKeeper.add(
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  );
                  bool correct = quizBrain.questionList[current].answer;
                  if (correct == false) {
                    print('Correct');
                  } else {
                    print('Not Correct !');
                  }
                  current++;
                  print(scoreKeeper.length);
                });
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
