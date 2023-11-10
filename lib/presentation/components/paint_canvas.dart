import 'dart:ui';

import 'package:flutter/material.dart';

class PaintCanvas extends CustomPainter {
  PaintCanvas({required this.points, required this.color});

  final List<Map<Color, List<Offset>>> points;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    for (var linePoints in points) {
      paint.color = linePoints.keys.first;

      canvas.drawPoints(
          PointMode.polygon, linePoints.values.toList()[0], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
