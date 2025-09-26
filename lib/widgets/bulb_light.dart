import 'package:flutter/material.dart';

class BulbLight extends StatelessWidget {
  final double width;
  final double height;
  final Color glowColor;
  final double glowRadius;

  const BulbLight({
    super.key,
    this.width = 40,
    this.height = 40,
    this.glowColor = Colors.white,
    this.glowRadius = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          // Outer glow
          BoxShadow(
            color: glowColor.withOpacity(0.4),
            blurRadius: glowRadius,
            spreadRadius: glowRadius / 2,
          ),
          // Inner glow (optional for brighter center)
          BoxShadow(
            color: glowColor.withOpacity(0.4),
            blurRadius: glowRadius / 4,
            spreadRadius: glowRadius / 6,
          ),
        ],
      ),
    );
  }
}
