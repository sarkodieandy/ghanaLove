import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ghconnect/core/constants/app_strings.dart';
import 'package:ghconnect/core/services/notification_service.dart';
import 'package:ghconnect/core/widgets/custom_button.dart';
import 'package:ghconnect/core/widgets/profile_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _profiles = [
    {
      'name': 'Ama',
      'age': 25,
      'location': 'Accra',
      'bio':
          'Loves music and dancing. Looking for someone to explore Ghana with.',
      'photo': 'assets/images/home1.png',
    },
    {
      'name': 'Akua',
      'age': 28,
      'location': 'Kumasi',
      'bio': 'Software developer who enjoys hiking and trying new foods.',
      'photo': 'assets/images/home2.png',
    },
    {
      'name': 'Esi',
      'age': 23,
      'location': 'Cape Coast',
      'bio': 'University student studying medicine. Love to read and travel.',
      'photo': 'assets/images/home3.png',
    },
  ];

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/matches');
        break;
      case 2:
        context.go('/chat/1'); // Example chat ID
        break;
      case 3:
        context.go('/events');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.discover,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {
              NotificationService.showSimpleNotification(
                title: '💘 New Match!',
                body: 'You and Akua liked each other!',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // Show filters
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: _profiles.length,
            onPageChanged: (index) => setState(() {}),
            itemBuilder: (context, index) {
              final profile = _profiles[index];
              return ProfileCard(
                name: profile['name'],
                age: profile['age'],
                location: profile['location'],
                bio: profile['bio'],
                photo: profile['photo'],
                onSwipeLeft: () {},
                onSwipeRight: () {},
                onSwipeUp: () {},
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'pass',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.close, color: Colors.red),
                ),
                FloatingActionButton(
                  heroTag: 'super_like',
                  onPressed: () {
                    NotificationService.showSimpleNotification(
                      title: '⭐ Super Like!',
                      body: 'You super liked Esi!',
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.star, color: Colors.blue),
                ),
                FloatingActionButton(
                  heroTag: 'like',
                  onPressed: () {
                    NotificationService.showSimpleNotification(
                      title: '💗 Like Sent',
                      body: 'You liked Ama\'s profile!',
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.favorite, color: Colors.green),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.workspace_premium, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppStrings.premiumBanner,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  CustomButton(
                    text: 'Upgrade',
                    onPressed: () {
                      context.go('/premium');
                    },
                    isPrimary: false,
                    width: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Matches'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
