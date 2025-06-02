import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/stats_card.dart';

class UserSettingsScreen extends StatelessWidget {
  final String userId;
  final String location;
  final int age;
  final String name;
  final String bio;
  final String photo;

  const UserSettingsScreen({
    super.key,
    required this.userId,
    required this.location,
    required this.age,
    required this.name,
    required this.bio,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, '/create-profile'),
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
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(photo),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$name, $age',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        Text(
                          location,
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
                  Text(bio),
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
                        Navigator.pushNamed(context, '/create-profile'),
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
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
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
