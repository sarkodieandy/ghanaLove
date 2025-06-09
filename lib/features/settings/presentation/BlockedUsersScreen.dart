import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  final List<Map<String, dynamic>> _blockedUsers = [
    {'name': 'Ama Serwaa', 'avatar': 'https://i.pravatar.cc/150?img=1'},
    {'name': 'Kwame Nkrumah', 'avatar': 'https://i.pravatar.cc/150?img=2'},
    {'name': 'Nana Aba', 'avatar': 'https://i.pravatar.cc/150?img=3'},
  ];

  void _unblockUser(int index) {
    final user = _blockedUsers[index];
    setState(() => _blockedUsers.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${user['name']} has been unblocked')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back normally
        ),
      ),
      body: _blockedUsers.isEmpty
          ? Center(
              child: Text(
                'You have not blocked any users.',
                style: theme.textTheme.bodyLarge,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _blockedUsers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final user = _blockedUsers[index];
                return ListTile(
                  tileColor: color.surfaceContainerHighest.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['avatar']),
                    radius: 24,
                  ),
                  title: Text(user['name'], style: theme.textTheme.titleMedium),
                  trailing: TextButton.icon(
                    onPressed: () => _unblockUser(index),
                    icon: const Icon(Icons.block_flipped, color: Colors.red),
                    label: const Text(
                      'Unblock',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
