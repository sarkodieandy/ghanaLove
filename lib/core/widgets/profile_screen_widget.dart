import 'package:flutter/material.dart';

import '../../features/chat/presentation/chat_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final int age;
  final String location;
  final String bio;
  final String photo;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    required this.photo,
    required String userId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          '$name\'s Profile',
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                photo,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$name, $age',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              location,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              bio,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // ✅ Navigate to ChatScreen using Navigator
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      userName: name,
                      chatId: '', // You can provide real chatId if needed
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: const Text('Chat Now'),
            ),
          ],
        ),
      ),
    );
  }
}
