import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final EdgeInsets? padding;
  final double? width;
  final double borderRadius;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.padding,
    this.width = 160,
    this.borderRadius = 12.0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isPrimary ? Colors.pink : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: isPrimary
            ? null
            : Border.all(color: Colors.pink.withOpacity(0.8), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withOpacity(0.1),
          onTap: isLoading ? null : onPressed,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: isLoading ? 0.98 : 1.0,
            child: Padding(
              padding:
                  padding ??
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: isLoading
                    ? const SizedBox(
                        key: ValueKey('loader'),
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                          strokeCap: StrokeCap.round,
                        ),
                      )
                    : FittedBox(
                        key: const ValueKey('button-content'),
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (icon != null) ...[
                              Icon(
                                icon,
                                size: 18,
                                color: isPrimary ? Colors.white : Colors.pink,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Flexible(
                              child: Text(
                                text,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: isPrimary
                                          ? Colors.white
                                          : Colors.pink,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}
