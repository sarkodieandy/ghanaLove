import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdinkraIcon extends StatelessWidget {
  final String symbol;
  final double size;
  final Color? color;

  const AdinkraIcon({
    super.key,
    required this.symbol,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/$symbol.svg',
      width: size,
      height: size,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }
}
