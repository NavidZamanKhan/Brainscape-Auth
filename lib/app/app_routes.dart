import 'package:flutter/material.dart';

import '../features/auth/presentation/auth_gate.dart';
import '../features/quiz/presentation/screens/quiz_screen.dart';
import '../features/quiz/presentation/screens/result_screen.dart';
import '../features/quiz/presentation/screens/welcome_screen.dart';

/// Named route configuration with custom page transitions.
class AppRoutes {
  AppRoutes._();

  static const String root = '/';
  static const String quizWelcome = '/quiz-welcome';
  static const String quiz = '/quiz';
  static const String result = '/result';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case quiz:
        return _buildRoute(const QuizScreen(), settings);
      case result:
        return _buildRoute(const ResultScreen(), settings);
      case quizWelcome:
        return _buildRoute(const WelcomeScreen(), settings);
      case root:
      default:
        return _buildRoute(const AuthGate(), settings);
    }
  }


  static PageRouteBuilder _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
