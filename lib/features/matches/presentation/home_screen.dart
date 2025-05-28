import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/widgets/profile_card.dart';

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
        context.go('/events');
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
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          AppStrings.discover,
          style: theme.textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              NotificationService.showSimpleNotification(
                title: '💘 New Match!',
                body: 'You and Akua liked each other!',
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
          selectedItemColor: Theme.of(
            context,
          ).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(
            context,
          ).bottomNavigationBarTheme.unselectedItemColor,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _onTabTapped(index);
          },
          items: List.generate(5, (index) {
            const icons = [
              Icons.home,
              Icons.favorite,
              Icons.chat,
              Icons.event,
              Icons.person,
            ];
            const labels = ['Home', 'Matches', 'Chat', 'Events', 'Profile'];

            return BottomNavigationBarItem(
              label: labels[index],
              icon: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(
                  begin: 1.0,
                  end: _currentIndex == index ? 1.2 : 1.0,
                ),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Icon(icons[index]),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
