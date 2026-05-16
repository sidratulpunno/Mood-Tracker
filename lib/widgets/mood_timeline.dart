import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/mood_state.dart';
import 'timeline_entry.dart';

class MoodTimeline extends StatelessWidget {
  const MoodTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Your Week',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Consumer<MoodState>(
          builder: (context, state, child) {
            final entries = state.lastSevenEntries;
            if (entries.isEmpty) {
              return _buildEmptyState();
            }
            return _buildTimeline(entries);
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_emotions_outlined,
              size: 40,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'No moods logged yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap a mood above to start tracking',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(List entries) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return TimelineEntry(
            entry: entries[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}