import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(quiz());
class quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Quiz App',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(90.0),
            child: Container(
              child: const Text('Welcome to Quiz Application! '
                  'Test your knowledge and find out!', textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Start Quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int questionIndex = 0;
  List<Map<String, dynamic>> questions = [
    {
      'question': "        Who is the author of the Harry Potter book series?",
      'choices': ['J.K. Rowling', 'Stephen King', 'J.R.R. Tolkien', 'Charles Dickens'],
      'answer': 'J.K. Rowling',
    },
    {
      'question': "       What is the largest planet in our solar system?",
      'choices': ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      'answer': 'Jupiter',
    },
    {
      'question': "         Which of the following countries is not a member of the European Union?",
      'choices': ['Germany', 'Norway', 'Italy', 'Greece'],
      'answer': 'Norway',
    },
    {
      'question': "         What is the capital of Turkey?",
      'choices': ['Ankara', 'Adana', 'Istanbul', 'Konya'],
      'answer': 'Ankara',
    },
    {
      'question': "         Which of the following countries is not located in Africa?",
      'choices': ['Kenya', 'Brazil', 'Egypt', 'Nigeria'],
      'answer': 'Brazil',
    },
  ];

  void checkAnswer(String choice) {
    if (choice == questions[questionIndex]['answer']) {
      score+=score+25;
    }
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(score),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Question ${questionIndex + 1}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              questions[questionIndex]['question'],
              style: const TextStyle(fontSize: 25,color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: List.generate(
                4,
                    (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: Text(questions[questionIndex]['choices'][index],style: TextStyle(fontSize: 25)),
                      onPressed: () {
                        checkAnswer(questions[questionIndex]['choices'][index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;

  ResultsPage(this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Quiz Results',style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            if (score >= 50)
              const Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                ),
              ),
            if (score < 50 && score >= 25)
              const Text(
                'Well Done! You could be better, try again.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                ),
              ),
            if (score < 25)
              const Text(
                'Bad Score! You can improve yourself! try again later',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                ),
              ),
          ],
        ),
      ),
    );
  }
}