import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_strings.dart';
import '../features/quiz/data/quiz_repository.dart';
import '../features/quiz/presentation/bloc/quiz_bloc.dart';
import 'app_routes.dart';
import 'app_theme.dart';

/// Root widget – configures theme, BLoC, and routing.
class BrainscapeApp extends StatelessWidget {
  const BrainscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(const QuizRepository()),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
