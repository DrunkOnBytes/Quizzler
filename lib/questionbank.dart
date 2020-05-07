import 'question.dart';

class QuestionBank{

  List<Question> _qa = [
    Question(quest: 'You can lead a cow down stairs but not up stairs.', ans: false),
    Question(quest: 'Approximately one quarter of human bones are in the feet.',ans: true),
    Question(quest: 'A slug\'s blood is green.', ans: true)
  ];

  String getQues(int a){
    return _qa[a].quest;
  }

  bool getAns(int a){
    return _qa[a].ans;
  }
}