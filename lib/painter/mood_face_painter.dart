import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/mood_type.dart';

class MoodFacePainter extends CustomPainter {
  final MoodType mood;
  final Color color;

  MoodFacePainter({required this.mood, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;

    _drawFaceBackground(canvas, center, radius);
    _drawFaceOutline(canvas, center, radius);
    _drawEyes(canvas, center, radius);
    _drawMouth(canvas, center, radius);
    _drawEyebrows(canvas, center, radius);
  }

  void _drawFaceBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  void _drawFaceOutline(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, radius, paint);
  }

  void _drawEyes(Canvas canvas, Offset center, double radius) {
    final eyeRadius = radius * 0.12;
    final eyeY = center.dy - radius * 0.15;
    final leftEyeX = center.dx - radius * 0.35;
    final rightEyeX = center.dx + radius * 0.35;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(leftEyeX, eyeY), eyeRadius, paint);
    canvas.drawCircle(Offset(rightEyeX, eyeY), eyeRadius, paint);
  }

  void _drawMouth(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final mouthY = center.dy + radius * 0.35;
    final mouthWidth = radius * 0.5;

    switch (mood) {
      case MoodType.happy:
        final path = Path()
          ..moveTo(center.dx - mouthWidth, mouthY - radius * 0.1)
          ..quadraticBezierTo(
            center.dx,
            mouthY + radius * 0.25,
            center.dx + mouthWidth,
            mouthY - radius * 0.1,
          );
        canvas.drawPath(path, paint);
        break;

      case MoodType.neutral:
        canvas.drawLine(
          Offset(center.dx - mouthWidth, mouthY),
          Offset(center.dx + mouthWidth, mouthY),
          paint,
        );
        break;

      case MoodType.sad:
        final path = Path()
          ..moveTo(center.dx - mouthWidth, mouthY + radius * 0.1)
          ..quadraticBezierTo(
            center.dx,
            mouthY - radius * 0.2,
            center.dx + mouthWidth,
            mouthY + radius * 0.1,
          );
        canvas.drawPath(path, paint);
        break;
    }
  }

  void _drawEyebrows(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final browY = center.dy - radius * 0.4;
    final browLength = radius * 0.25;
    final leftBrowX = center.dx - radius * 0.35;
    final rightBrowX = center.dx + radius * 0.35;

    switch (mood) {
      case MoodType.happy:
        canvas.drawLine(
          Offset(leftBrowX - browLength * 0.3, browY - browLength * 0.2),
          Offset(leftBrowX + browLength * 0.3, browY),
          paint,
        );
        canvas.drawLine(
          Offset(rightBrowX - browLength * 0.3, browY),
          Offset(rightBrowX + browLength * 0.3, browY - browLength * 0.2),
          paint,
        );
        break;

      case MoodType.neutral:
        canvas.drawLine(
          Offset(leftBrowX - browLength, browY),
          Offset(leftBrowX + browLength, browY),
          paint,
        );
        canvas.drawLine(
          Offset(rightBrowX - browLength, browY),
          Offset(rightBrowX + browLength, browY),
          paint,
        );
        break;

      case MoodType.sad:
        canvas.drawLine(
          Offset(leftBrowX - browLength * 0.2, browY),
          Offset(leftBrowX + browLength * 0.4, browY + browLength * 0.15),
          paint,
        );
        canvas.drawLine(
          Offset(rightBrowX - browLength * 0.4, browY + browLength * 0.15),
          Offset(rightBrowX + browLength * 0.2, browY),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood || oldDelegate.color != color;
  }
}