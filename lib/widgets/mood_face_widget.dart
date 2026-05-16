import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import '../painter/mood_face_painter.dart';

class MoodFaceWidget extends StatefulWidget {
  final MoodType mood;
  final Color color;
  final double size;
  final bool animate;
  final VoidCallback? onAnimationComplete;

  const MoodFaceWidget({
    super.key,
    required this.mood,
    required this.color,
    this.size = 80,
    this.animate = false,
    this.onAnimationComplete,
  });

  @override
  State<MoodFaceWidget> createState() => _MoodFaceWidgetState();
}

class _MoodFaceWidgetState extends State<MoodFaceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.1), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 25),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(MoodFaceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.animate ? _scaleAnimation.value : 1.0,
          child: Transform.rotate(
            angle: widget.animate ? _rotationAnimation.value : 0,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: MoodFacePainter(mood: widget.mood, color: widget.color),
            ),
          ),
        );
      },
    );
  }
}