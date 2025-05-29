import 'package:flutter/material.dart';

class PlanItem extends StatelessWidget {
  final String duration;
  final String price;
  final String perMonth;
  final bool isPopular;
  final Animation<double> animation;

  const PlanItem({
    super.key,
    required this.duration,
    required this.price,
    required this.perMonth,
    required this.isPopular,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final backgroundColor = isPopular
        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
        : (isDark ? Colors.black : Colors.white);
    final borderColor = isPopular
        ? Theme.of(context).colorScheme.primary
        : (isDark ? Colors.white24 : Colors.black12);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
            border: Border.all(color: borderColor, width: isPopular ? 1.5 : 1),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          duration,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                        ),
                        if (isPopular) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Popular',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      perMonth,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: subTextColor),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
