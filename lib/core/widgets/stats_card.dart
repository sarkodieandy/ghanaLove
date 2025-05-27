import 'package:flutter/material.dart';
import 'package:ghconnect/core/constants/app_colors.dart';

class StatsCard extends StatelessWidget {
  final int views;
  final int likes;
  final int matches;
  final bool showIcons;

  const StatsCard({
    super.key,
    required this.views,
    required this.likes,
    required this.matches,
    this.showIcons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primaryRed, width: 1.5),
      ),
      color: AppColors.primaryBlack, // Optional: pink-on-black card style
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              icon: showIcons ? Icons.remove_red_eye : null,
              value: views,
              label: 'Views',
            ),
            _buildStatItem(
              icon: showIcons ? Icons.favorite : null,
              value: likes,
              label: 'Likes',
            ),
            _buildStatItem(
              icon: showIcons ? Icons.people : null,
              value: matches,
              label: 'Matches',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    IconData? icon,
    required int value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: AppColors.primaryRed, size: 28),
        if (icon != null) const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white, // ✅ white text
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.white, // ✅ white text
          ),
        ),
      ],
    );
  }
}
