import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String name;
  final int age;
  final String photo;
  final String? bio;
  final String? lastActive;
  final bool showActionButtons;
  final VoidCallback? onTap;
  final VoidCallback? onChatPressed;
  final VoidCallback? onProfilePressed;

  const MatchCard({
    super.key,
    required this.name,
    required this.age,
    required this.photo,
    this.bio,
    this.lastActive,
    this.showActionButtons = false,
    this.onTap,
    this.onChatPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                photo,
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name, $age',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (bio != null && bio!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      bio!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (lastActive != null && lastActive!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Last active: $lastActive',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                  if (showActionButtons) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.chat_bubble_outline),
                          label: const Text('Chat'),
                          onPressed: onChatPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.person),
                          label: const Text('Profile'),
                          onPressed: onProfilePressed,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return showActionButtons
        ? Padding(padding: const EdgeInsets.only(bottom: 16), child: card)
        : card;
  }
}
