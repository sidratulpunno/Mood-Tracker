import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import 'mood_face_widget.dart';

class TimelineEntry extends StatefulWidget {
  final MoodEntry entry;
  final VoidCallback onTap;

  const TimelineEntry({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  State<TimelineEntry> createState() => _TimelineEntryState();
}

class _TimelineEntryState extends State<TimelineEntry> {
  bool _isAnimating = false;

  void _handleTap() {
    setState(() => _isAnimating = true);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.entry.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.entry.color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: MoodFaceWidget(
                mood: widget.entry.mood,
                color: widget.entry.color,
                size: 56,
                animate: _isAnimating,
                onAnimationComplete: () {
                  setState(() => _isAnimating = false);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.entry.dateLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.entry.timeLabel,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}