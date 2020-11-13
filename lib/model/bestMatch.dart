import 'question.dart';

class BestMatchQuestion extends Question {
  List<String> idealPersonAnswers;
  BestMatchQuestion({String question, String answer, this.idealPersonAnswers})
      : super(question: question, answer: answer);

  @override
  String toString() {
    return "Question : $question\n\tAnswer : $answer\n\tIdeal Person Answers : ${idealPersonAnswers.join(", ")}";
  }

  Map<String, dynamic> toJson() => {
        'question': this.question,
        'myAnswer': this.answer,
        'idealPersonAnswer': this.idealPersonAnswers,
      };
}
