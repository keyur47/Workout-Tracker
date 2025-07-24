import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/screens/workout_screen.dart';
import 'package:workout/utils/string_utils.dart';

/// SCREEN 1: Displays a list of saved workouts with options to view, edit, or delete.
class WorkoutListScreen extends StatelessWidget {
  /// Reference to the WorkoutController using GetX dependency injection
  final controller = Get.find<WorkoutController>();

  WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App bar showing the workout history title
      appBar: AppBar(title: Text(AppString.workoutHistroy)),

      /// Reactive body that updates automatically when `controller.workouts` changes
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.workouts.length,
          itemBuilder: (context, index) {
            final w = controller.workouts[index];

            /// ListTile representing a single workout entry
            return ListTile(
              /// Title shows workout ID and formatted creation date
              title: Text(
                "${AppString.workout} ${w.id} - ${w.createdAt.toLocal().toString().split(' ').first}",
              ),

              /// Subtitle shows total sets and distinct exercise names
              subtitle: Text(
                "${w.sets.length} ${AppString.set} - ${w.sets.map((s) => s.exercise).toSet().join(", ")}",
              ),

              /// On tap, navigates to the workout edit screen with current workout
              onTap: () => Get.to(() => WorkoutFormScreen(workout: w)),

              /// Delete button with red icon
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),

                /// Deletes the selected workout and shows a toast notification
                onPressed: () {
                  controller.deleteWorkout(w.id!);
                  Fluttertoast.showToast(msg: AppString.workoutDeleted);
                },
              ),
            );
          },
        );
      }),

      /// Floating Action Button to add a new workout
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => WorkoutFormScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
