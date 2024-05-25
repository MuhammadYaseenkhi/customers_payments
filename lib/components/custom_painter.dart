import 'package:flutter/material.dart';

class ConnectingLinesPainter extends CustomPainter {
  final List<double> lineYPositions;

  ConnectingLinesPainter(this.lineYPositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    for (var yPosition in lineYPositions) {
      canvas.drawLine(
        Offset(0, yPosition),
        Offset(10, yPosition),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}