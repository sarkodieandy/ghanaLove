import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final int age;
  final String location;
  final String bio;
  final String photo;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeUp;

  const ProfileCard({
    super.key,
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    required this.photo,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSwipeUp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond;
        if (velocity.dx > 300) {
          onSwipeRight();
        } else if (velocity.dx < -300) {
          onSwipeLeft();
        } else if (velocity.dy < -300) {
          onSwipeUp();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Image.asset(
                  photo,
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$name, $age',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(bio, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
