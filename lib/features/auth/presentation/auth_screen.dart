import 'package:flutter/material.dart';
import 'package:brainscape/core/constants/app_colors.dart';
import 'package:brainscape/features/quiz/presentation/widgets/animated_background.dart';
import 'package:brainscape/features/quiz/presentation/widgets/animated_blob.dart';
import 'package:brainscape/features/quiz/presentation/widgets/glass_card.dart';
import 'login_form.dart';
import 'signup_form.dart';

/// Parent authentication screen containing [LoginForm] and [SignupForm].
/// Handles switching between the two forms with smooth transitions.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Decorative blobs (matching WelcomeScreen style)
            AnimatedBlob(
              size: size.width * (isDesktop ? 0.35 : 0.7),
              color: AppColors.deepPurple,
              offset: Offset(-size.width * 0.1, -size.height * 0.05),
            ),
            AnimatedBlob(
              size: size.width * (isDesktop ? 0.28 : 0.55),
              color: AppColors.electricBlue,
              offset: Offset(size.width * 0.6, size.height * 0.6),
              duration: const Duration(seconds: 8),
            ),
            AnimatedBlob(
              size: size.width * (isDesktop ? 0.18 : 0.35),
              color: AppColors.cyan,
              offset: Offset(size.width * 0.7, size.height * 0.15),
              duration: const Duration(seconds: 5),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // App Logo Header
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              AppColors.electricBlue,
                              AppColors.deepPurple,
                              AppColors.cyan,
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            'Brainscape',
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -1.0,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            _isLogin
                                ? 'Log in to challenge your mind'
                                : 'Create an account to start playing',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.mutedText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Switch with AnimatedSwitcher for smooth form transitions
                        GlassCard(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 24,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 0.08),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: _isLogin
                                ? LoginForm(
                                    key: const ValueKey('login_form'),
                                    onToggleMode: _toggleMode,
                                  )
                                : SignupForm(
                                    key: const ValueKey('signup_form'),
                                    onToggleMode: _toggleMode,
                                  ),
                          ),
                        ),
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
  }
}
