import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brainscape/core/constants/app_colors.dart';
import 'package:brainscape/features/auth/providers/auth_provider.dart';
import 'package:brainscape/features/quiz/presentation/widgets/animated_background.dart';
import 'package:brainscape/features/quiz/presentation/widgets/animated_blob.dart';
import 'package:brainscape/features/quiz/presentation/widgets/glass_card.dart';
import 'package:brainscape/features/quiz/presentation/widgets/gradient_button.dart';

/// The main dashboard screen shown to authenticated users.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    final user = authState.value; // Get the user from stream
    final email = user?.email ?? 'User';

    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.electricBlue, AppColors.cyan],
          ).createShader(bounds),
          child: const Text(
            'Brainscape',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.redError, size: 20),
              tooltip: 'Log Out',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.backgroundAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.cardBorder),
                    ),
                    title: const Text('Log Out', style: TextStyle(color: Colors.white)),
                    content: const Text(
                      'Are you sure you want to sign out of your account?',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel', style: TextStyle(color: AppColors.mutedText)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Log Out', style: TextStyle(color: AppColors.redError)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await ref.read(authControllerProvider.notifier).signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Glowing background blobs
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

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Welcome Glass Card
                        GlassCard(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                          child: Column(
                            children: [
                              // User Avatar Visual
                              Container(
                                width: 88,
                                height: 88,
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
                                      color: AppColors.deepPurple.withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 44,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Welcome back!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                                ),
                                child: Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.electricBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Ready to test your knowledge on Computer Science & Flutter?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.mutedText,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                child: GradientButton(
                                  text: 'Start Quiz',
                                  icon: Icons.play_arrow_rounded,
                                  onTap: () {
                                    // Navigate to the quiz flow welcome screen
                                    Navigator.of(context).pushNamed('/quiz-welcome');
                                  },
                                ),
                              ),
                            ],
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
