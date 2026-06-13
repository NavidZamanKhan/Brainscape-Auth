import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_blob.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';

/// Animated welcome / start screen.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _cardScale;
  late final Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _titleOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animCtrl,
          curve: const Interval(0.0, 0.45, curve: Curves.easeOut)),
    );
    _titleSlide =
        Tween(begin: const Offset(0, -0.25), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animCtrl,
          curve: const Interval(0.0, 0.45, curve: Curves.easeOut)),
    );
    _cardScale = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
          parent: _animCtrl,
          curve: const Interval(0.2, 0.65, curve: Curves.easeOutBack)),
    );
    _buttonOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animCtrl,
          curve: const Interval(0.55, 1.0, curve: Curves.easeOut)),
    );

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _startQuiz() {
    context.read<QuizBloc>().add(const QuizStarted());
    Navigator.of(context).pushReplacementNamed('/quiz');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Decorative blobs
            AnimatedBlob(
              size: size.width * 0.7,
              color: AppColors.deepPurple,
              offset: Offset(-size.width * 0.2, -size.height * 0.08),
            ),
            AnimatedBlob(
              size: size.width * 0.55,
              color: AppColors.electricBlue,
              offset: Offset(size.width * 0.5, size.height * 0.55),
              duration: const Duration(seconds: 8),
            ),
            AnimatedBlob(
              size: size.width * 0.35,
              color: AppColors.cyan,
              offset: Offset(size.width * 0.6, size.height * 0.15),
              duration: const Duration(seconds: 5),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: AnimatedBuilder(
                    animation: _animCtrl,
                    builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          SlideTransition(
                            position: _titleSlide,
                            child: FadeTransition(
                              opacity: _titleOpacity,
                              child: Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        AppColors.electricBlue,
                                        AppColors.deepPurple,
                                        AppColors.cyan,
                                      ],
                                    ).createShader(bounds),
                                    child: const Text(
                                      AppStrings.appName,
                                      style: TextStyle(
                                        fontSize: 44,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -1,
                                        height: 1.1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    AppStrings.tagline,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.mutedText,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Central hero card
                          ScaleTransition(
                            scale: _cardScale,
                            child: GlassCard(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 36, horizontal: 24),
                              child: Column(
                                children: [
                                  // Abstract brain visual
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.deepPurple,
                                          AppColors.electricBlue,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.deepPurple
                                              .withValues(alpha: 0.4),
                                          blurRadius: 24,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.psychology_rounded,
                                      size: 52,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  const Text(
                                    AppStrings.readyPrompt,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.whiteText,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '20 ${AppStrings.questionSubtitle}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.mutedText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Start button
                          FadeTransition(
                            opacity: _buttonOpacity,
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GradientButton(
                                  text: AppStrings.startQuiz,
                                  icon: Icons.arrow_forward_rounded,
                                  onTap: _startQuiz,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
