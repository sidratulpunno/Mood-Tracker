import 'package:flutter/material.dart';
import 'mood_type.dart';

class MoodEntry {
  final DateTime date;
  final MoodType mood;

  MoodEntry({required this.date, required this.mood});

  Color get color => mood.color;

  String get dateLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(date.year, date.month, date.day);
    final diff = today.difference(entryDate).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return '${date.day}/${date.month}';
  }

  String get timeLabel {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}