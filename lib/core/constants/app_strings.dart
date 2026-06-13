/// Centralized string constants used throughout the Brainscape app.
class AppStrings {
  AppStrings._();

  // ── App identity ──
  static const String appName = 'Brainscape';
  static const String tagline = 'Challenge your mind. Sharpen your logic.';

  // ── Welcome screen ──
  static const String readyPrompt = 'Ready to test your knowledge?';
  static const String questionSubtitle = 'questions · CS & Flutter';
  static const String startQuiz = 'Start Quiz';

  // ── Quiz screen ──
  static String questionOf(int current, int total) =>
      'Question $current of $total';
  static const String next = 'Next';
  static const String finish = 'Finish';

  // ── Result screen ──
  static const String quizCompleted = 'Quiz Completed';
  static const String restartQuiz = 'Restart Quiz';
  static const String correct = 'Correct';
  static const String wrong = 'Wrong';
  static const String accuracy = 'Accuracy';

  // ── Result titles ──
  static const String outstanding = 'Outstanding!';
  static const String excellentWork = 'Excellent Work!';
  static const String goodEffort = 'Good Effort!';
  static const String keepPracticing = 'Keep Practicing!';
}
