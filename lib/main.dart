import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'questionbank.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int totalQues = 15;
  int fScore=0;
  List<Widget> score = [];
  QuestionBank qb = QuestionBank();
  int quesNo = 0;

  void checkScore(bool trueButton){
      if (qb.getAns(quesNo)==trueButton) {
        score.add(Icon(Icons.check, color: Colors.green,));
        fScore++;
      }
      else
        score.add(Icon(Icons.close, color: Colors.red,));
      quesNo=(quesNo+1)%3;
  }

  void restart(){
    totalQues = 15;
    fScore=0;
    quesNo = 0;
    score = [];
  }

  void endQuiz(){
    Alert(
      context: context,
      type: AlertType.info,
      title: "END GAME",
      desc: "Final Score $fScore",
      buttons: [
        DialogButton(
          child: Text(
            "TRY AGAIN ?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              restart();
            });
            Navigator.pop(context);
            },
          width: 120,
        )
      ],
    ).show();
  }

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
                qb.getQues(quesNo),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (totalQues>0){
                    checkScore(true);
                    totalQues--;
                    if (totalQues==0)
                      endQuiz();
                  }
                  else
                    endQuiz();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (totalQues>0){
                    checkScore(false);
                    totalQues--;
                    if (totalQues==0)
                      endQuiz();
                  }
                  else
                    endQuiz();
                });
              },
            ),
          ),
        ),
        Row(children: score,),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
