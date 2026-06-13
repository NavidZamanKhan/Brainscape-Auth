/// Events dispatched by the UI to the [QuizBloc].
sealed class QuizEvent {
  const QuizEvent();
}

/// Dispatched when the user starts (or restarts) the quiz.
class QuizStarted extends QuizEvent {
  const QuizStarted();
}

/// Dispatched when the user selects an answer option.
class AnswerSelected extends QuizEvent {
  final int selectedIndex;
  const AnswerSelected(this.selectedIndex);
}

/// Dispatched when the user taps Next or Finish.
class NextQuestionPressed extends QuizEvent {
  const NextQuestionPressed();
}

/// Dispatched when the user restarts the quiz from the result screen.
class QuizRestarted extends QuizEvent {
  const QuizRestarted();
}
