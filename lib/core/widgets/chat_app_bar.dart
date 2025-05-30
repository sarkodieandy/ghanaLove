import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
// Ensure GoRouter is imported for navigation

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed; // The back navigation callback
  final VoidCallback onProfileTap;
  final String chatId;

  const ChatAppBar({
    super.key,
    required this.onBackPressed,
    required this.onProfileTap,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        onPressed:
            onBackPressed, // Ensure this calls the correct back navigation
      ),
      title: InkWell(
        onTap: onProfileTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Hero(
                tag: 'profile-$chatId',
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: const AssetImage(
                    'assets/images/profile.png',
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle image loading error
                  },
                  child: const AssetImage('assets/images/profile.png') == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ama',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.onlineGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Online',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.onlineGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.phone, color: Colors.black),
          tooltip: 'Voice Call',
          onPressed: () {
            // Voice Call functionality (you can implement this)
            _showFeatureNotImplemented(context, 'Voice Call');
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.black),
          tooltip: 'Video Call',
          onPressed: () {
            // Video Call functionality (you can implement this)
            _showFeatureNotImplemented(context, 'Video Call');
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) {
            // Implement the actions for menu items (e.g., View Profile)
            if (value == 'profile') {
              onProfileTap();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 12),
                  Text('View Profile'),
                ],
              ),
            ),
            // Add more menu items as needed
          ],
        ),
      ],
    );
  }

  // This method is used to show a message for unimplemented features
  void _showFeatureNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature will be implemented soon!'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
