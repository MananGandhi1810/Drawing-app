import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/line_model.dart';

class PaintCanvas extends CustomPainter {
  PaintCanvas({required this.lines, required this.color});

  final List<LineModel> lines;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    for (var line in lines) {
      paint.color = line.color;
      paint.strokeWidth = line.strokeWidth;
      canvas.drawPoints(PointMode.polygon, line.points, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
