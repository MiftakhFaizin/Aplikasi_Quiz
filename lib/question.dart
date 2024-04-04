import 'package:flutter/material.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function(int) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Question(
            questionText: questions[questionIndex]['questionText'].toString(),
            questionImage: questions[questionIndex]['questionImage'].toString(),
          ),
          SizedBox(height: 5),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Answer(
                    () => answerQuestion(answer['score'] as int),
                answer['text'].toString(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;
  final String questionImage;

  Question({
    required this.questionText,
    required this.questionImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            questionText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF31304D),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 15),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 350,
            minHeight: 150,
            maxHeight: 350,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              questionImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}