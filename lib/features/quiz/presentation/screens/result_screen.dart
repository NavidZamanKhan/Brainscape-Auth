import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/score_utils.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_blob.dart';
import '../widgets/celebration_painter.dart';
import '../widgets/gradient_button.dart';
import '../widgets/score_circle.dart';
import '../widgets/stat_card.dart';

/// Result / success screen displayed after quiz completion.
class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _entranceCtrl,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    _slideUp = Tween(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _entranceCtrl,
          curve: const Interval(0.1, 0.7, curve: Curves.easeOutCubic)),
    );
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  void _restart(BuildContext context) {
    context.read<QuizBloc>().add(const QuizRestarted());
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final score = state.score;
        final total = state.totalQuestions;
        final wrong = total - score;
        final pct = ScoreUtils.accuracyPercent(score, total);
        final title = ScoreUtils.resultTitle(score, total);
        final icon = ScoreUtils.resultIcon(score, total);

        return Scaffold(
          body: AnimatedBackground(
            child: Stack(
              children: [
                AnimatedBlob(
                  size: size.width * 0.7,
                  color: AppColors.deepPurple,
                  offset:
                      Offset(-size.width * 0.15, -size.height * 0.05),
                  duration: const Duration(seconds: 7),
                ),
                AnimatedBlob(
                  size: size.width * 0.5,
                  color: AppColors.cyan,
                  offset: Offset(size.width * 0.5, size.height * 0.6),
                ),

                // Confetti
                if (pct >= 50) const CelebrationPainter(),

                SafeArea(
                  child: SlideTransition(
                    position: _slideUp,
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),

                            // Result title
                            Icon(icon,
                                size: 44,
                                color: AppColors.electricBlue),
                            const SizedBox(height: 10),
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(
                                colors: [
                                  AppColors.electricBlue,
                                  AppColors.cyan,
                                ],
                              ).createShader(bounds),
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              AppStrings.quizCompleted,
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.mutedText,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Score circle
                            ScoreCircle(score: score, total: total),

                            const SizedBox(height: 32),

                            // Stats row
                            Row(
                              children: [
                                Expanded(
                                  child: StatCard(
                                    label: AppStrings.correct,
                                    value: '$score',
                                    icon:
                                        Icons.check_circle_rounded,
                                    color: AppColors.greenSuccess,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: StatCard(
                                    label: AppStrings.wrong,
                                    value: '$wrong',
                                    icon: Icons.cancel_rounded,
                                    color: AppColors.redError,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: StatCard(
                                    label: AppStrings.accuracy,
                                    value: '$pct%',
                                    icon:
                                        Icons.analytics_rounded,
                                    color: AppColors.electricBlue,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 36),

                            // Restart button
                            GradientButton(
                              text: AppStrings.restartQuiz,
                              icon: Icons.replay_rounded,
                              onTap: () => _restart(context),
                            ),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
