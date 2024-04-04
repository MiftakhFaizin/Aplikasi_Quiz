import 'dart:async';
import 'package:flutter/material.dart';
import 'question.dart';
import 'result.dart';

class FrameworkQuiz extends StatefulWidget {
  @override
  _FrameworkQuizState createState() => _FrameworkQuizState();
}

class _FrameworkQuizState extends State<FrameworkQuiz> {
  int _questionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeInSeconds = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kuis Framework',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF0ECE5)),
        ),
        backgroundColor: Color(0xFF161A30),
        leading: BackButton(color: Color(0xFFF0ECE5)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0ECE5),
              Color(0xFFB6BBC4),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Waktu tersisa: $_timeInSeconds detik. Nilai anda: $_score',
                    style: TextStyle(fontSize: 18, color: Color(0xFF31304D)),
                  ),
                ),
                Quiz(
                  questionIndex: _questionIndex,
                  questions: _questions,
                  answerQuestion: _answerQuestion,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Logo Framework apakah dibawah ini?',
      'questionImage': 'assets/flutter.jpeg',
      'answers': [
        {'text': 'Flutter', 'score': 20},
        {'text': 'Tailwind', 'score': 0},
        {'text': 'Angular', 'score': 0},
        {'text': 'Laravel', 'score': 0},
        {'text': 'ReactJS', 'score': 0},
      ],
    },
    {
      'questionText': 'Logo Framework apakah dibawah ini?',
      'questionImage': 'assets/laravel.jpeg',
      'answers': [
        {'text': 'Django', 'score': 0},
        {'text': 'Flask', 'score': 0},
        {'text': 'ReactJS', 'score': 0},
        {'text': 'Laravel', 'score': 20},
        {'text': 'CodeIgniter', 'score': 0},
      ],
    },
    {
      'questionText': 'Logo Framework apakah dibawah ini?',
      'questionImage': 'assets/react.jpeg',
      'answers': [
        {'text': 'ExpressJS', 'score': 0},
        {'text': 'Laravel', 'score': 0},
        {'text': 'ReactJS', 'score': 20},
        {'text': 'NestJS', 'score': 0},
        {'text': 'Flutter', 'score': 0},
      ],
    },
    {
      'questionText': 'Logo Framework apakah dibawah ini?',
      'questionImage': 'assets/bootstrap.jpeg',
      'answers': [
        {'text': 'Flutter', 'score': 0},
        {'text': 'CodeIgniter', 'score': 0},
        {'text': 'NestJS', 'score': 0},
        {'text': 'laravel', 'score': 0},
        {'text': 'Bootstrap', 'score': 20},
      ]
    },
    {
      'questionText': 'Logo Framework apakah dibawah ini?',
      'questionImage': 'assets/tailwind.png',
      'answers': [
        {'text': 'Tailwind', 'score': 20},
        {'text': 'CodeIgniter', 'score': 0},
        {'text': 'Spring', 'score': 0},
        {'text': 'Bootstrap', 'score': 20},
        {'text': 'Laravel', 'score': 0},
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeInSeconds > 0) {
          _timeInSeconds--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _nextQuestion() {
    _timer?.cancel();
    _timeInSeconds = 10;
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
      _startTimer();
    } else {
      _showResult();
    }
  }

  void _showResult() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Result(_score, _resetQuiz),
      ),
    );
  }

  void _answerQuestion(int score) {
    _score += score;
    _nextQuestion();
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
    _startTimer();
  }
}