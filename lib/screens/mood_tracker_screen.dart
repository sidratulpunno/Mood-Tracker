import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_type.dart';
import '../state/mood_state.dart';
import '../widgets/mood_selector.dart';
import '../widgets/mood_timeline.dart';

class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoodState(),
      child: const _MoodTrackerContent(),
    );
  }
}

class _MoodTrackerContent extends StatelessWidget {
  const _MoodTrackerContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE8EEF4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildHeader(),
              const SizedBox(height: 50),
              Consumer<MoodState>(
                builder: (context, state, child) {
                  return MoodSelector(
                    onMoodSelected: (mood) {
                      state.addMood(mood);
                      _showMoodSnackBar(context, mood);
                    },
                  );
                },
              ),
              const SizedBox(height: 60),
              const MoodTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Mood Tracker',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track your daily emotions',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  void _showMoodSnackBar(BuildContext context, MoodType mood) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Mood logged!'),
        backgroundColor: mood.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}