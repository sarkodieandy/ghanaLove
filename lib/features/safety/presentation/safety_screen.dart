import 'package:flutter/material.dart';
import 'package:ghconnect/core/constants/app_strings.dart';
import 'package:ghconnect/core/widgets/custom_button.dart';
import '../../../core/widgets/safety_tips.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety & Verification',
          style: theme.textTheme.displaySmall,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // standard back
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.verificationOptions,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone Verification'),
                    subtitle: const Text('Verified'),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    onTap: () {
                      // Handle phone verification
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.mobile_friendly),
                    title: const Text('Mobile Money Verification'),
                    subtitle: const Text('Not verified'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle MoMo verification
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('ID Verification'),
                    subtitle: const Text('Not verified'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle ID verification
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(AppStrings.safetyTips, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            const SafetyTip(
              title: 'Meet in Public',
              description: 'Always meet in a public place for the first time.',
            ),
            const SafetyTip(
              title: 'Tell a Friend',
              description: 'Let someone know where you\'re going and who with.',
            ),
            const SafetyTip(
              title: 'Stay Sober',
              description:
                  'Avoid excessive alcohol consumption on first dates.',
            ),
            const SafetyTip(
              title: 'Trust Your Instincts',
              description: 'If something feels wrong, leave immediately.',
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: AppStrings.verifyNow,
              onPressed: () {
                // Navigate to verification screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
