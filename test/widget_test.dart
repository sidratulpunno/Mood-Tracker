import 'package:flutter_test/flutter_test.dart';

import 'package:mood_tracker/main.dart';

void main() {
  testWidgets('Mood tracker smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MoodTrackerApp());
    await tester.pumpAndSettle();

    expect(find.text('Mood Tracker'), findsOneWidget);
    expect(find.text('How are you feeling?'), findsOneWidget);
    expect(find.text('Your Week'), findsOneWidget);
  });
}