class Question {
  String question;
  String answer;

  Question({
    this.question,
    this.answer,
  });

  @override
  String toString() {
    return "question : $question\nanswer : $answer";
  }

  Map<String, dynamic> toJson() => {
        'question': this.question,
        'answer': this.answer,
      };
}
