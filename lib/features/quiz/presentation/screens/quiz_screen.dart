import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_blob.dart';
import '../widgets/animated_progress_bar.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/option_tile.dart';

/// Main quiz screen with animated question transitions.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  late AnimationController _questionAnimCtrl;
  late Animation<Offset> _slideIn;
  late Animation<double> _fadeIn;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _initQuestionAnim();
    _questionAnimCtrl.forward();
  }

  void _initQuestionAnim() {
    _questionAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideIn = Tween(begin: const Offset(0.15, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _questionAnimCtrl, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _questionAnimCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _questionAnimCtrl.dispose();
    super.dispose();
  }

  void _onSelectOption(int index) {
    context.read<QuizBloc>().add(AnswerSelected(index));
  }

  void _onNext() {
    final state = context.read<QuizBloc>().state;
    if (!state.hasAnswered || _navigating) return;

    if (state.isLastQuestion) {
      _navigating = true;
      context.read<QuizBloc>().add(const NextQuestionPressed());
      // Navigation handled by BlocListener below.
      return;
    }

    // Animate out → dispatch → animate in.
    _questionAnimCtrl.reverse().then((_) {
      if (!mounted) return;
      context.read<QuizBloc>().add(const NextQuestionPressed());
      _questionAnimCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<QuizBloc, QuizState>(
      listenWhen: (prev, curr) => !prev.isCompleted && curr.isCompleted,
      listener: (context, state) {
        Navigator.of(context).pushReplacementNamed('/result');
      },
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          final q = state.currentQuestion;
          if (q == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final progress = state.progress;
          final isLast = state.isLastQuestion;

          return Scaffold(
            body: AnimatedBackground(
              child: Stack(
                children: [
                  AnimatedBlob(
                    size: size.width * 0.6,
                    color: AppColors.deepPurple,
                    offset:
                        Offset(size.width * 0.45, -size.height * 0.05),
                    duration: const Duration(seconds: 7),
                  ),
                  AnimatedBlob(
                    size: size.width * 0.45,
                    color: AppColors.electricBlue,
                    offset:
                        Offset(-size.width * 0.15, size.height * 0.65),
                    duration: const Duration(seconds: 9),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        // ── Header ──
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24, 16, 24, 0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: AppColors.deepPurple
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.deepPurple
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Text(
                                  AppStrings.questionOf(
                                    state.currentQuestionIndex + 1,
                                    state.totalQuestions,
                                  ),
                                  style: const TextStyle(
                                    color: AppColors.whiteText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                  color: AppColors.greenSuccess
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.greenSuccess
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        size: 16,
                                        color: AppColors.greenSuccess),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${state.score}',
                                      style: const TextStyle(
                                        color: AppColors.greenSuccess,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── Progress ──
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24, 16, 24, 8),
                          child:
                              AnimatedProgressBar(progress: progress),
                        ),

                        // ── Question & Options ──
                        Expanded(
                          child: SlideTransition(
                            position: _slideIn,
                            child: FadeTransition(
                              opacity: _fadeIn,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 8, 20, 20),
                                child: Column(
                                  key: ValueKey<int>(
                                      state.currentQuestionIndex),
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Question card
                                    GlassCard(
                                      padding:
                                          const EdgeInsets.all(24),
                                      margin: EdgeInsets.zero,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient:
                                                  const LinearGradient(
                                                colors: [
                                                  AppColors.deepPurple,
                                                  AppColors.electricBlue,
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .deepPurple
                                                      .withValues(
                                                          alpha: 0.3),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${state.currentQuestionIndex + 1}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              q.question,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight:
                                                    FontWeight.w600,
                                                color:
                                                    AppColors.whiteText,
                                                height: 1.45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Options
                                    ...List.generate(
                                        q.options.length, (i) {
                                      final isSelected =
                                          state.selectedAnswerIndex ==
                                              i;
                                      final isCorrect =
                                          i == q.correctAnswerIndex;
                                      return OptionTile(
                                        key: ValueKey(
                                            'opt_${state.currentQuestionIndex}_$i'),
                                        text: q.options[i],
                                        index: i,
                                        isSelected: isSelected,
                                        isCorrect: isCorrect,
                                        isRevealed:
                                            state.hasAnswered,
                                        isDisabled:
                                            state.hasAnswered,
                                        onTap: () =>
                                            _onSelectOption(i),
                                        staggerIndex: i,
                                      );
                                    }),

                                    const SizedBox(height: 12),

                                    // Next / Finish button
                                    GradientButton(
                                      text: isLast
                                          ? AppStrings.finish
                                          : AppStrings.next,
                                      icon: isLast
                                          ? Icons
                                              .emoji_events_rounded
                                          : Icons
                                              .arrow_forward_rounded,
                                      onTap: state.hasAnswered
                                          ? _onNext
                                          : null,
                                      enabled: state.hasAnswered,
                                    ),

                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
