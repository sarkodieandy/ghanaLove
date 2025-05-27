import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support', style: theme.textTheme.titleLarge),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHelpCard(
              context,
              icon: Icons.help_outline,
              title: 'FAQs',
              subtitle: 'Find answers to common questions',
              onTap: () {
                // Navigate to FAQ screen
              },
            ),
            const SizedBox(height: 12),
            _buildHelpCard(
              context,
              icon: Icons.chat_bubble_outline,
              title: 'Contact Support',
              subtitle: 'Chat or email us for help',
              onTap: () {
                // Open contact form or support chat
              },
            ),
            const SizedBox(height: 12),
            _buildHelpCard(
              context,
              icon: Icons.report_problem_outlined,
              title: 'Report a Problem',
              subtitle: 'Let us know about an issue',
              onTap: () {
                // Navigate to report form
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Need immediate help?',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Email us at support@ghanalove.app or call +233 20 000 0000.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Icon(icon, size: 32, color: Colors.deepPurple),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
