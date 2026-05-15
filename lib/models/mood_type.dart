import 'package:flutter/material.dart';

enum MoodType {
  happy,
  neutral,
  sad,
}

extension MoodTypeExtension on MoodType {
  Color get color {
    switch (this) {
      case MoodType.happy:
        return const Color(0xFFFFB74D);
      case MoodType.neutral:
        return const Color(0xFF90A4AE);
      case MoodType.sad:
        return const Color(0xFF7986CB);
    }
  }

  String get label {
    switch (this) {
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Okay';
      case MoodType.sad:
        return 'Sad';
    }
  }
}