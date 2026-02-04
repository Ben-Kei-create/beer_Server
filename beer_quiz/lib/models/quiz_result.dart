class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final List<String> triviaList;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.triviaList,
  });

  double get scorePercentage =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  String get message {
    if (scorePercentage >= 80) {
      return 'ビール博士！素晴らしい！';
    } else if (scorePercentage >= 60) {
      return 'よくできました！';
    } else if (scorePercentage >= 40) {
      return 'まずまずですね。';
    } else {
      return 'もっと勉強しましょう！';
    }
  }

  String get title {
    if (correctAnswers >= 8) {
      return '伝説のビアマスター（乾杯の神）';
    } else if (correctAnswers >= 4) {
      return '中堅ビアラバー（通の入り口）';
    } else {
      return 'ビール初心者（まずは一杯！）';
    }
  }
}
