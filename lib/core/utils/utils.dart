import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/core/core.dart';

Offset toPolar(Offset center, int index, int total, double radius) {
  final theta = index * total.stepsInAngle;
  final dx = radius * math.cos(theta);
  final dy = radius * math.sin(theta);
  return Offset(dx, dy) + center;
}