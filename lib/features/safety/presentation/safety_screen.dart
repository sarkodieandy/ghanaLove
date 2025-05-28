import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/safety_tips.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety & Verification',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.verificationOptions,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
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
                      // Phone verification
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.mobile_friendly),
                    title: const Text('Mobile Money Verification'),
                    subtitle: const Text('Not verified'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Mobile money verification
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.badge),
                    title: const Text('ID Verification'),
                    subtitle: const Text('Not verified'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // ID verification
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.safetyTips,
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
                // Verify now
              },
            ),
          ],
        ),
      ),
    );
  }
}
