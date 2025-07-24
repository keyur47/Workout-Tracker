import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:workout/main.dart';

void main() {

  testWidgets('Add, edit, and delete a workout', (tester) async {
    await tester.pumpWidget(MyApp());

    // Tap FAB to open form
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Add a set
    await tester.tap(find.text('Add Set'));
    await tester.pump();

    // Enter weight and reps
    await tester.enterText(find.byType(TextField).at(0), '100');
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.pump();

    // Save workout
    await tester.tap(find.text('Save Workout'));
    await tester.pumpAndSettle();

    // Tap saved workout to edit
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Delete set
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    // Should auto delete if no sets remain
    expect(find.byType(ListTile), findsNothing);
  });
}
