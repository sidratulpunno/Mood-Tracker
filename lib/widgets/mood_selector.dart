import 'package:flutter/material.dart';
import '../models/mood_type.dart';
import 'mood_face_widget.dart';

class MoodSelector extends StatelessWidget {
  final Function(MoodType) onMoodSelected;

  const MoodSelector({super.key, required this.onMoodSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'How are you feeling?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MoodButton(
              mood: MoodType.happy,
              onTap: () => onMoodSelected(MoodType.happy),
            ),
            const SizedBox(width: 20),
            _MoodButton(
              mood: MoodType.neutral,
              onTap: () => onMoodSelected(MoodType.neutral),
            ),
            const SizedBox(width: 20),
            _MoodButton(
              mood: MoodType.sad,
              onTap: () => onMoodSelected(MoodType.sad),
            ),
          ],
        ),
      ],
    );
  }
}

class _MoodButton extends StatefulWidget {
  final MoodType mood;
  final VoidCallback onTap;

  const _MoodButton({
    required this.mood,
    required this.onTap,
  });

  @override
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.mood.color;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: color.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: MoodFaceWidget(
                      mood: widget.mood,
                      color: color,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.mood.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}