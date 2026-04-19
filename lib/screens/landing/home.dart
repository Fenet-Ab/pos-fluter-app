import 'package:flutter/material.dart';
import '../../shared/widgets/custom_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF), // Subtle tint as seen in image
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Skip action
                  },
                  child: Text(
                    'Skip',
                    style: AppTextStyles.body(
                      color: AppColors.textPrimary,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/landing.png',
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              Text(
                'Fast & Offline Ready',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Keep your business running. Process transactions in seconds, even without an internet connection.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body().copyWith(
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Next',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  // Next action
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
