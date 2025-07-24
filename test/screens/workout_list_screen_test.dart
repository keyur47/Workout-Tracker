import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/screens/workout_list_screen.dart';

void main() {
  testWidgets('WorkoutListScreen shows floating action button and app bar', (WidgetTester tester) async {
    // Inject controller
    Get.put(WorkoutController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: WorkoutListScreen(),
      ),
    );

    // Check app bar title
    expect(find.text('Workout Histroy'), findsOneWidget);

    // Check FAB presence
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
