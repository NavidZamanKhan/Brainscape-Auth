/// Represents a single quiz question with its options and correct answer.
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
