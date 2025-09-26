import 'package:flutter/material.dart';
import '../utils/elastic_curve.dart';

/// A reusable tab selector widget with animated indicator.
/// 
/// [labels] is a list of tab names.
/// [selectedIndex] is the currently selected tab.
/// [onTabSelected] is called with the new index when a tab is tapped.
/// [backgroundColor], [indicatorColor], [selectedTextColor], [unselectedTextColor], [duration], and [curve]
/// allow customization of the appearance and animation.
class AnimatedTabSelector extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color backgroundColor;
  final Color indicatorColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double height;
  final double borderRadius;
  final Duration duration;
  final Curve curve;

  const AnimatedTabSelector({
    Key? key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabSelected,
    this.backgroundColor = const Color(0xff252525),
    this.indicatorColor = Colors.white,
    this.selectedTextColor = const Color(0xFF1d1d1d),
    this.unselectedTextColor = Colors.white,
    this.height = 44,
    this.borderRadius = 8,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = const CustomElasticOutCurve(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tabWidth = (MediaQuery.of(context).size.width - 32) / labels.length;

    Alignment _alignmentForIndex(int index) {
      if (labels.length == 1) return Alignment.center;
      if (labels.length == 2) {
        return index == 0 ? Alignment.centerLeft : Alignment.centerRight;
      }
      // For 3 or more tabs, interpolate between -1.0 and 1.0
      double x = -1.0 + 2.0 * (index / (labels.length - 1));
      return Alignment(x, 0);
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated indicator
          AnimatedAlign(
            alignment: _alignmentForIndex(selectedIndex),
            duration: duration,
            curve: curve,
            child: Container(
              width: tabWidth - 8,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(labels.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (selectedIndex != index) {
                      onTabSelected(index);
                    }
                  },
                  child: Container(
                    height: height,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: isSelected ? selectedTextColor : unselectedTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      child: Text(labels[index]),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
