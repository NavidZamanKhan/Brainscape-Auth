import '../domain/models/quiz_question.dart';

/// All 20 quiz questions – CS fundamentals & Flutter.
const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: 'What is the main purpose of an algorithm?',
    options: [
      'To store data permanently',
      'To provide step-by-step instructions to solve a problem',
      'To design user interfaces only',
      'To connect a computer to the internet',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'Which data structure follows the LIFO principle?',
    options: [
      'Queue',
      'Stack',
      'Array',
      'Tree',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What does O(n) usually represent in time complexity?',
    options: [
      'Constant time',
      'Logarithmic time',
      'Linear time',
      'Exponential time',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question:
        'Which programming concept allows the same function name to behave differently based on input?',
    options: [
      'Encapsulation',
      'Inheritance',
      'Polymorphism',
      'Abstraction',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question: 'In object-oriented programming, what is encapsulation?',
    options: [
      'Hiding internal data and exposing controlled access',
      'Running code faster',
      'Copying one class into another',
      'Deleting unused variables',
    ],
    correctAnswerIndex: 0,
  ),
  QuizQuestion(
    question:
        'Which of the following is commonly used to manage asynchronous operations?',
    options: [
      'Loop',
      'Future',
      'Variable',
      'Constructor',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What is the purpose of version control systems like Git?',
    options: [
      'To design mobile screens',
      'To track changes in code over time',
      'To increase internet speed',
      'To compile programming languages',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question:
        'Which command is commonly used to save staged changes in Git?',
    options: [
      'git push',
      'git clone',
      'git commit',
      'git pull',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question: 'What does API stand for?',
    options: [
      'Application Programming Interface',
      'Advanced Program Installation',
      'Automated Programming Input',
      'Application Process Integration',
    ],
    correctAnswerIndex: 0,
  ),
  QuizQuestion(
    question: 'What is the main role of a database in an application?',
    options: [
      'To display animations',
      'To store and manage data',
      'To increase screen brightness',
      'To write source code automatically',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What is Flutter mainly used for?',
    options: [
      'Building cross-platform applications',
      'Managing computer hardware',
      'Creating operating systems',
      'Designing only websites',
    ],
    correctAnswerIndex: 0,
  ),
  QuizQuestion(
    question:
        'Which programming language is primarily used with Flutter?',
    options: [
      'Java',
      'Kotlin',
      'Dart',
      'Swift',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question:
        'In Flutter, everything in the UI is mainly built using what?',
    options: [
      'Activities',
      'Components',
      'Widgets',
      'Fragments',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    question:
        'Which widget is commonly used for creating a vertical list of scrollable items?',
    options: [
      'Container',
      'ListView',
      'Row',
      'Stack',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question:
        'What is the difference between StatelessWidget and StatefulWidget?',
    options: [
      'StatelessWidget can change data, StatefulWidget cannot',
      'StatefulWidget can update its UI when state changes',
      'StatelessWidget is only used for animations',
      'StatefulWidget is used only for database operations',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question:
        'Which Flutter widget is best for arranging children horizontally?',
    options: [
      'Column',
      'Row',
      'Stack',
      'Scaffold',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question: 'What does setState() do in Flutter?',
    options: [
      'Deletes the current screen',
      'Updates the UI after changing state',
      'Stops the app',
      'Creates a new project',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question:
        'Which widget provides the basic visual structure for a Flutter screen?',
    options: [
      'Scaffold',
      'Padding',
      'Text',
      'Icon',
    ],
    correctAnswerIndex: 0,
  ),
  QuizQuestion(
    question: 'What is the purpose of pubspec.yaml in a Flutter project?',
    options: [
      'To write app logic',
      'To manage dependencies, assets, and project settings',
      'To store user passwords',
      'To create widgets automatically',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    question:
        'Which widget can be used to animate changes in size, color, padding, or decoration automatically?',
    options: [
      'AnimatedContainer',
      'TextField',
      'Placeholder',
      'SizedBox',
    ],
    correctAnswerIndex: 0,
  ),
];
