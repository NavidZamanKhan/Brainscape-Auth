import '../domain/models/quiz_question.dart';
import 'quiz_data.dart';

/// Repository that provides quiz questions to the BLoC layer.
///
/// This abstraction makes it easy to swap the data source
/// (e.g. load from an API or local database) without changing
/// the BLoC or UI code.
class QuizRepository {
  const QuizRepository();

  /// Returns the full list of quiz questions.
  List<QuizQuestion> getQuestions() => List.unmodifiable(quizQuestions);
}
