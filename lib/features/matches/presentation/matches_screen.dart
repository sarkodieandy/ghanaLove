import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/match_card.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _likes = [];

  final List<Map<String, dynamic>> _matches = [
    {
      'id': '1',
      'name': 'Ama',
      'age': 25,
      'location': 'Accra',
      'bio': 'Loves music and dancing',
      'photo': 'assets/images/profile.png',
      'lastActive': '2 hours ago',
    },
    {
      'id': '2',
      'name': 'Kwame',
      'age': 28,
      'location': 'Kumasi',
      'bio': 'Software developer',
      'photo': 'assets/images/home2.png',
      'lastActive': '1 day ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goBackToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBackToHome,
        ),
        title: Text('Matches', style: Theme.of(context).textTheme.displaySmall),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Likes'),
            Tab(text: 'Matches'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildLikesTab(), _buildMatchesTab()],
      ),
    );
  }

  Widget _buildLikesTab() {
    if (_likes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              AppStrings.upgradeToSeeLikes,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Go Premium',
              onPressed: () {
                Navigator.pushNamed(context, '/premium');
              },
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: _likes.length,
      itemBuilder: (context, index) {
        return MatchCard(
          name: _likes[index]['name'],
          age: _likes[index]['age'],
          photo: _likes[index]['photo'],
          onTap: () {},
        );
      },
    );
  }

  Widget _buildMatchesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _matches.length,
      itemBuilder: (context, index) {
        final match = _matches[index];
        final userId = match['id'];

        return MatchCard(
          name: match['name'],
          age: match['age'],
          photo: match['photo'],
          bio: match['bio'],
          lastActive: match['lastActive'],
          showActionButtons: true,
          onChatPressed: () {
            Navigator.pushNamed(context, '/chat/$userId');
          },
          onProfilePressed: () {
            Navigator.pushNamed(context, '/profile/$userId');
          },
        );
      },
    );
  }
}
