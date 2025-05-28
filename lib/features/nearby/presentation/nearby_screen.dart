
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/user_card.dart';
import '../models/user_model.dart';

class NearbyScreen extends StatelessWidget {
  final List<UserModel> _nearbyUsers = [
    UserModel(name: "Ama", age: 24, location: "Accra", imageUrl: "assets/images/ama.png"),
    UserModel(name: "Kwame", age: 28, location: "Kumasi", imageUrl: "assets/images/kwame.png"),
    UserModel(name: "Akosua", age: 22, location: "Takoradi", imageUrl: "assets/images/akosua.png"),
  ];

  NearbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("See Who's Nearby"),
        backgroundColor: AppColors.primaryRed,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _nearbyUsers.length,
        itemBuilder: (context, index) {
          final user = _nearbyUsers[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: UserCard(user: user),
          );
        },
      ),
    );
  }
}
