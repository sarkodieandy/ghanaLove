import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/stats_card.dart';

class User_settings_Screen extends StatelessWidget {
  final String userId;

  const User_settings_Screen({
    super.key,
    required this.userId,
    required String location,
    required int age,
    required String name,
    required String bio,
    required String photo,
  });

  @override
  Widget build(BuildContext context) {
    // Simulate fetching user details by ID
    final userName = userId == '1' ? 'Kwame' : 'Ama';
    final userAge = userId == '1' ? 28 : 25;
    final userLocation = userId == '1' ? 'Accra' : 'Kumasi';
    final userBio = userId == '1'
        ? 'Software developer who enjoys hiking and trying new foods.'
        : 'Fashion designer who loves music and traveling.';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    Navigator.pushNamed(context, '/profile/create'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/profile_bg.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            'assets/images/profile.png',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$userName, $userAge',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          userLocation,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(userBio),
                  const SizedBox(height: 16),
                  Text(
                    'Cultural Info',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Akan')),
                      Chip(label: Text('Christian')),
                      Chip(label: Text('Serious Relationship')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const StatsCard(views: 124, likes: 42, matches: 8),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Edit Profile',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/profile/create'),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium),
                    title: const Text('Go Premium'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, '/premium'),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Logout',
                    isPrimary: false,
                    onPressed: () {
                      // TODO: Add logout logic
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
