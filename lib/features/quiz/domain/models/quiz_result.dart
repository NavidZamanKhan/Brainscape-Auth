/// Immutable snapshot of a completed quiz result.
class QuizResult {
  final int score;
  final int total;

  const QuizResult({required this.score, required this.total});

  int get wrong => total - score;
  int get accuracyPercent => total == 0 ? 0 : (score / total * 100).round();
  double get fraction => total == 0 ? 0.0 : score / total;
}
