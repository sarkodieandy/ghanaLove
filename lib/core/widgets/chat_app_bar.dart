import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
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
        onPressed: onBackPressed,
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
          onPressed: () => _handleVoiceCall(context),
        ),
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.black),
          tooltip: 'Video Call',
          onPressed: () => _handleVideoCall(context),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) => _handleMenuSelection(context, value),
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
            const PopupMenuItem(
              value: 'search',
              child: Row(
                children: [
                  Icon(Icons.search, size: 20),
                  SizedBox(width: 12),
                  Text('Search Messages'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'mute',
              child: Row(
                children: [
                  Icon(Icons.notifications_off, size: 20),
                  SizedBox(width: 12),
                  Text('Mute Notifications'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.report, size: 20, color: Colors.orange),
                  SizedBox(width: 12),
                  Text('Report', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'block',
              child: Row(
                children: [
                  Icon(Icons.block, size: 20, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Block', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleVoiceCall(BuildContext context) {
    // Show voice call dialog or navigate to call screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Call'),
        content: const Text('Start a voice call with Ama?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement voice call functionality
              _showFeatureNotImplemented(context, 'Voice Call');
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _handleVideoCall(BuildContext context) {
    // Show video call dialog or navigate to call screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Call'),
        content: const Text('Start a video call with Ama?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement video call functionality
              _showFeatureNotImplemented(context, 'Video Call');
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'profile':
        onProfileTap();
        break;
      case 'search':
        _showSearchDialog(context);
        break;
      case 'mute':
        _handleMuteNotifications(context);
        break;
      case 'report':
        _handleReport(context);
        break;
      case 'block':
        _handleBlock(context);
        break;
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Messages'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search in conversation...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (query) {
            // TODO: Implement search functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleMuteNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mute Notifications'),
        content: const Text('How long would you like to mute notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented(context, 'Mute for 1 hour');
            },
            child: const Text('1 Hour'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented(context, 'Mute for 8 hours');
            },
            child: const Text('8 Hours'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented(context, 'Mute until unmuted');
            },
            child: const Text('Until I turn it back on'),
          ),
        ],
      ),
    );
  }

  void _handleReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: const Text(
          'Are you sure you want to report this user? '
          'This action will help us maintain a safe community.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented(context, 'Report User');
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _handleBlock(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text(
          'Are you sure you want to block this user? '
          'You won\'t be able to send or receive messages from them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented(context, 'Block User');
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

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
