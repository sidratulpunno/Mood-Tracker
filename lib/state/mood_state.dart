import 'package:flutter/foundation.dart';
import '../models/mood_entry.dart';
import '../models/mood_type.dart';

class MoodState extends ChangeNotifier {
  final List<MoodEntry> _entries = [];

  List<MoodEntry> get entries => List.unmodifiable(_entries);

  List<MoodEntry> get lastSevenEntries {
    final sorted = List<MoodEntry>.from(_entries)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(7).toList();
  }

  void addMood(MoodType mood) {
    _entries.add(MoodEntry(date: DateTime.now(), mood: mood));
    notifyListeners();
  }
}