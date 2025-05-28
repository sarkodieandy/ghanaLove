import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VisibilitySettingsScreen extends StatefulWidget {
  const VisibilitySettingsScreen({super.key});

  @override
  State<VisibilitySettingsScreen> createState() =>
      _VisibilitySettingsScreenState();
}

class _VisibilitySettingsScreenState extends State<VisibilitySettingsScreen> {
  String _selectedVisibility = 'Public';

  final List<String> _visibilityOptions = ['Public', 'Only Matches', 'Private'];

  void _saveVisibility() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Visibility set to $_selectedVisibility'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    context.pop(); // Navigate back to settings
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Visibility'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who can see your profile?',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._visibilityOptions.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedVisibility,
                onChanged: (value) {
                  setState(() => _selectedVisibility = value!);
                },
                activeColor: color.primary,
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Settings'),
                onPressed: _saveVisibility,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: color.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
