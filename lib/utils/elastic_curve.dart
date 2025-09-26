import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomElasticOutCurve extends Curve {
  /// Creates an elastic-out curve with a reduced bounce.
  ///
  /// Rather than creating a new instance, consider using [Curves.elasticOut].
  const CustomElasticOutCurve([this.period = 0.4, this.bounceFactor = 0.5]);

  /// The duration of the oscillation.
  final double period;

  /// The factor to reduce the bounce amplitude (default: 0.7).
  final double bounceFactor;

  @override
  double transformInternal(double t) {
    final double s = period / 4.0;
    // Reduce the bounce by multiplying the amplitude by bounceFactor
    return bounceFactor * math.pow(2.0, -10 * t) * math.sin((t - s) * (math.pi * 2.0) / period) + 1.0;
  }

  @override
  String toString() {
    return '${objectRuntimeType(this, 'CustomElasticOutCurve')}($period, $bounceFactor)';
  }
}
