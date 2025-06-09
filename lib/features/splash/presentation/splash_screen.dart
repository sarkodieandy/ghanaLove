import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF686865),
      body: Stack(
        children: [
          // Background image with subtle zoom effect
          Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
              )
              .scale(
                begin: const Offset(1.1, 1.1),
                end: const Offset(1.0, 1.0),
                duration: const Duration(milliseconds: 1500),
              )
              .blurXY(
                begin: 5,
                end: 0,
                duration: const Duration(milliseconds: 1000),
              ),

          // App logo with bounce and shimmer-like effect
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/1.png', width: 150, height: 150)
                    .animate()
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.0, 1.0),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    )
                    .then(delay: const Duration(milliseconds: 300))
                    .shake(hz: 4, offset: const Offset(0.1, 0))
                    .then(delay: const Duration(milliseconds: 200)),

                const SizedBox(height: 30),

                Text(
                      'GhanaLove',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 500))
                    .then(delay: const Duration(milliseconds: 500))
                    .slideY(begin: 0.5, end: 0.0),

                const SizedBox(height: 10),

                Text(
                      'Find Your Perfect Match',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 800))
                    .scaleXY(begin: 0.8, end: 1.0),
              ],
            ),
          ),

          // Loading indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Animate(
              effects: [
                FadeEffect(duration: 1000.ms),
                RotateEffect(duration: 1000.ms, curve: Curves.linear),
              ],
              onPlay: (controller) => controller.repeat(reverse: true),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
