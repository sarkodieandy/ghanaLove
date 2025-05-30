import 'package:flutter/material.dart';
import '../../features/nearby/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;

  const UserCard({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.black : Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: AssetImage(user.imageUrl),
          radius: 24,
        ),
        title: Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "${user.age} • ${user.location}",
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
        trailing: const Icon(Icons.location_on, color: Colors.pinkAccent),
      ),
    );
  }
}
