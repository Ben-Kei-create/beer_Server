class QuizQuestion {
  final String question;
  final List<String> choices;
  final int correctAnswerIndex;
  final String trivia;
  final String difficulty;

  QuizQuestion({
    required this.question,
    required this.choices,
    required this.correctAnswerIndex,
    required this.trivia,
    required this.difficulty,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'] as String,
      choices: List<String>.from(json['choices'] as List),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      trivia: json['trivia'] as String,
      difficulty: json['difficulty'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'choices': choices,
      'correctAnswerIndex': correctAnswerIndex,
      'trivia': trivia,
      'difficulty': difficulty,
    };
  }
}
