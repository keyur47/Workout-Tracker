import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/models/workout_model.dart';
import 'package:workout/utils/string_utils.dart';

/// SCREEN 2: Workout Form Screen
/// - Used to create or edit a workout
/// - Allows the user to add/remove/edit exercise sets
class WorkoutFormScreen extends StatefulWidget {
  final Workout? workout; // If passed, screen acts as "edit"; otherwise it's "create"

  const WorkoutFormScreen({super.key, this.workout});

  @override
  State<WorkoutFormScreen> createState() => _WorkoutFormScreenState();
}

class _WorkoutFormScreenState extends State<WorkoutFormScreen> {
  final controller = Get.find<WorkoutController>();

  /// Initialize form with sets from the workout (if editing)
  @override
  void initState() {
    super.initState();
    controller.sets.value = widget.workout?.sets
        .map((s) => WorkoutSet(
        exercise: s.exercise, weight: s.weight, reps: s.reps))
        .toList() ??
        [];
  }

  /// Saves the workout to the database after validation
  void saveWorkout() {
    // Check if any sets exist
    if (controller.sets.isEmpty) {
      Fluttertoast.showToast(msg: AppString.pleaseAddAtLeastOneSet);
      return;
    }

    // Validate that all fields are filled correctly
    for (var s in controller.sets) {
      if (s.exercise.isEmpty || s.weight <= 0 || s.reps <= 0) {
        Fluttertoast.showToast(
            msg: AppString.PleaseFillInAllFieldsForEachSetProperly);
        return;
      }
    }

    // Create or update the workout instance
    final newWorkout = Workout(
      id: widget.workout?.id,
      sets: controller.sets,
      createdAt: widget.workout?.createdAt ?? DateTime.now(),
    );

    // Insert or update in the DB
    if (widget.workout == null) {
      controller.addWorkout(newWorkout);
    } else {
      controller.updateWorkout(newWorkout);
    }

    Fluttertoast.showToast(msg: AppString.workoutSaved);
    Get.back();
  }

  /// Deletes the current workout from the database
  void deleteWorkout() {
    if (widget.workout?.id != null) {
      controller.deleteWorkout(widget.workout!.id!);
      Fluttertoast.showToast(msg: AppString.workoutDeleted);
      Get.back();
    }
  }

  /// Builds a card UI for each set, allowing input for exercise, weight, and reps
  Widget buildSetCard(int index) {
    final set = controller.sets[index];
    final weightController = TextEditingController(text: set.weight.toString());
    final repsController = TextEditingController(text: set.reps.toString());

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            /// Exercise selector and delete icon
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: set.exercise,
                    items: controller.exercises
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => set.exercise = val!),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    controller.sets.removeAt(index);

                    // If no sets remain, delete workout
                    if (controller.sets.isEmpty) {
                      if (widget.workout?.id != null) {
                        await controller.deleteWorkout(widget.workout!.id!);
                        Fluttertoast.showToast(
                            msg: AppString.workoutDeletedBecauseNoSetsRemain);
                        Get.back();
                      }
                    } else {
                      // Otherwise, just update workout
                      if (widget.workout?.id != null) {
                        final updatedWorkout = Workout(
                          id: widget.workout!.id,
                          sets: controller.sets,
                          createdAt: widget.workout!.createdAt,
                        );
                        await controller.updateWorkout(updatedWorkout);
                        Fluttertoast.showToast(
                            msg: AppString.setDeletedAndWorkoutUpdated);
                      }
                    }
                  },
                )
              ],
            ),

            /// Weight and Reps input fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: AppString.weightKG,
                      hintText: '0.0',
                    ),
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    controller: weightController,
                    onChanged: (val) =>
                    set.weight = double.tryParse(val) ?? set.weight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: AppString.reps,
                      hintText: '0.0',
                    ),
                    keyboardType: TextInputType.number,
                    controller: repsController,
                    onChanged: (val) =>
                    set.reps = double.tryParse(val) ?? set.reps,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// UI layout with floating buttons and list of sets
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        /// Action buttons: Add Set & Save Workout
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: controller.addSet,
              icon: const Icon(Icons.add),
              label: const Text(AppString.addSet),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: saveWorkout,
              child: const Text(AppString.saveWorkout),
            ),
          ],
        ),

        /// App bar title depends on whether it's a new or existing workout
        appBar: AppBar(
          title: Text(widget.workout == null
              ? AppString.newWorkout
              : AppString.editWorkout),
        ),

        /// Main body shows either a message or a list of set cards
        body: Column(
          children: [
            Expanded(
              child: controller.sets.isEmpty
                  ? const Center(child: Text(AppString.noSetsAddedYet))
                  : ListView.builder(
                itemCount: controller.sets.length,
                itemBuilder: (_, i) => buildSetCard(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
