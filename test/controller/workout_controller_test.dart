import 'package:flutter_test/flutter_test.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/models/workout_model.dart';

void main() {
  group('WorkoutController', () {
    late WorkoutController controller;

    setUp(() {
      controller = WorkoutController();
    });

    test('Add set should increase set list count', () {
      expect(controller.sets.length, 0);
      controller.addSet();
      expect(controller.sets.length, 1);
    });

    test('Add workout updates workouts list', () async {
      final workout = Workout(
        sets: [WorkoutSet(exercise: 'Bench press', weight: 100, reps: 5)],
        createdAt: DateTime.now(),
      );
      await controller.addWorkout(workout);
      await controller.loadWorkouts();

      expect(controller.workouts.any((w) => w.sets[0].exercise == 'Bench press'), true);
    });
  });
}
