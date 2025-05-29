import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ghconnect/core/constants/app_strings.dart';
import 'package:ghconnect/core/services/notification_service.dart';
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
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/matches');
        break;
      case 2:
        context.go('/chat/1');
        break;
      case 3:
        context.go('/nearby'); // 👈 Replaced '/events' with '/nearby'
        break;
      case 4:
        context.go('/profile/1');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          AppStrings.discover,
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: theme.colorScheme.onPrimary,
            ),
            onPressed: () {
              NotificationService.showSimpleNotification(
                title: '💘 New Match!',
                body: 'You and Akua liked each other!',
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt, color: theme.colorScheme.onPrimary),
            onPressed: () {
              // TODO: Show filters
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
                  backgroundColor: theme.colorScheme.surface,
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
                  backgroundColor: theme.colorScheme.surface,
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
                  backgroundColor: theme.colorScheme.surface,
                  child: const Icon(Icons.favorite, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              theme.bottomNavigationBarTheme.unselectedItemColor,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Matches',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Nearby',
            ), // 👈 Changed label
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
