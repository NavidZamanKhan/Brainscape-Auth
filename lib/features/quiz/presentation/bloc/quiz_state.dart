import '../../domain/models/quiz_question.dart';

/// Lifecycle status of the quiz.
enum QuizStatus {
  initial,
  inProgress,
  completed,
}

/// Immutable state consumed by the UI via [QuizBloc].
class QuizState {
  final List<QuizQuestion> questions;
  final int currentQuestionIndex;
  final int? selectedAnswerIndex;
  final int score;
  final bool hasAnswered;
  final QuizStatus status;

  const QuizState({
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.selectedAnswerIndex,
    this.score = 0,
    this.hasAnswered = false,
    this.status = QuizStatus.initial,
  });

  bool get isCompleted => status == QuizStatus.completed;
  bool get isLastQuestion =>
      questions.isNotEmpty &&
      currentQuestionIndex >= questions.length - 1;
  int get totalQuestions => questions.length;

  double get progress =>
      questions.isEmpty ? 0.0 : (currentQuestionIndex + 1) / questions.length;

  QuizQuestion? get currentQuestion =>
      questions.isNotEmpty && currentQuestionIndex < questions.length
          ? questions[currentQuestionIndex]
          : null;

  QuizState copyWith({
    List<QuizQuestion>? questions,
    int? currentQuestionIndex,
    int? Function()? selectedAnswerIndex,
    int? score,
    bool? hasAnswered,
    QuizStatus? status,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex != null
          ? selectedAnswerIndex()
          : this.selectedAnswerIndex,
      score: score ?? this.score,
      hasAnswered: hasAnswered ?? this.hasAnswered,
      status: status ?? this.status,
    );
  }
}
