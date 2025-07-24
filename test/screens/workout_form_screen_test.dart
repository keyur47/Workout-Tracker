import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/screens/workout_screen.dart';

void main() {
  testWidgets('WorkoutFormScreen adds and displays a set', (WidgetTester tester) async {
    Get.put(WorkoutController());

    await tester.pumpWidget(GetMaterialApp(home: WorkoutFormScreen()));

    // Tap "Add Set" button
    await tester.tap(find.text('Add Set'));
    await tester.pump();

    // Check dropdown appears
    expect(find.byType(DropdownButton<String>), findsOneWidget);
  });
}
