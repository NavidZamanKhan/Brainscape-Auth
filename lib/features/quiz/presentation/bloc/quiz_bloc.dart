import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

/// Central BLoC for the quiz feature.
///
/// Handles starting, answering, navigating, completing, and restarting
/// the quiz. All scoring logic lives here — the UI is purely presentational.
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _repository;

  /// Tracks which question indices have already been scored
  /// to prevent double-counting.
  final Set<int> _scoredQuestions = {};

  QuizBloc(this._repository) : super(const QuizState()) {
    on<QuizStarted>(_onQuizStarted);
    on<AnswerSelected>(_onAnswerSelected);
    on<NextQuestionPressed>(_onNextQuestionPressed);
    on<QuizRestarted>(_onQuizRestarted);
  }

  void _onQuizStarted(QuizStarted event, Emitter<QuizState> emit) {
    _scoredQuestions.clear();
    final questions = _repository.getQuestions();
    emit(QuizState(
      questions: questions,
      status: QuizStatus.inProgress,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    // Prevent changing answer after selection.
    if (state.hasAnswered) return;

    int newScore = state.score;
    if (!_scoredQuestions.contains(state.currentQuestionIndex)) {
      _scoredQuestions.add(state.currentQuestionIndex);
      final q = state.currentQuestion;
      if (q != null && event.selectedIndex == q.correctAnswerIndex) {
        newScore++;
      }
    }

    emit(state.copyWith(
      selectedAnswerIndex: () => event.selectedIndex,
      score: newScore,
      hasAnswered: true,
    ));
  }

  void _onNextQuestionPressed(
      NextQuestionPressed event, Emitter<QuizState> emit) {
    if (!state.hasAnswered) return;

    if (state.isLastQuestion) {
      emit(state.copyWith(status: QuizStatus.completed));
      return;
    }

    // Guard against index out-of-range.
    final nextIndex = state.currentQuestionIndex + 1;
    if (nextIndex >= state.questions.length) return;

    emit(state.copyWith(
      currentQuestionIndex: nextIndex,
      selectedAnswerIndex: () => null,
      hasAnswered: false,
    ));
  }

  void _onQuizRestarted(QuizRestarted event, Emitter<QuizState> emit) {
    _scoredQuestions.clear();
    emit(const QuizState(status: QuizStatus.initial));
  }
}
