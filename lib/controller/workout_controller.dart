import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:workout/database/workout_model.dart';
import 'package:workout/models/workout_model.dart';
import 'package:workout/utils/string_utils.dart';

/// SECTION: Controller using GetX for state management
class WorkoutController extends GetxController {
  /// Observable list to store all workouts
  RxList<Workout> workouts = <Workout>[].obs;

  /// Predefined list of common exercises (observable)
  RxList<String> exercises = [
    AppString.benchPress,
    AppString.squat,
    AppString.deadlift,
    AppString.shoulderPress,
    AppString.barbellRow,
  ].obs;

  /// Observable list to store sets for a workout session
  RxList<WorkoutSet> sets = <WorkoutSet>[].obs;

  /// Adds a new set with default values and shows a toast notification
  void addSet() {
    sets.add(WorkoutSet(exercise: exercises[0], weight: 0, reps: 0));
    Fluttertoast.showToast(msg: AppString.setADD);
  }

  /// Lifecycle method called when the controller is initialized
  /// Used here to load all workouts from the database
  @override
  void onInit() {
    loadWorkouts();
    super.onInit();
  }

  /// Loads all workout records from the local database and updates the observable list
  Future<void> loadWorkouts() async {
    workouts.value = await WorkoutDB.getAll();
  }

  /// Inserts a new workout record into the database
  /// Then refreshes the observable workout list
  // void addWorkout(Workout w) async {
  //   await WorkoutDB.insertWorkout(w);
  //   loadWorkouts();
  // }
  Future<void> addWorkout(Workout w) async {
    await WorkoutDB.insertWorkout(w);
    loadWorkouts();
  }

  /// Updates an existing workout in the database
  /// Then reloads the workouts to reflect the changes
  Future<void> updateWorkout(Workout w) async {
    await WorkoutDB.updateWorkout(w);
    loadWorkouts();
  }

  /// Deletes a workout entry by ID from the database
  /// Then refreshes the observable list
  Future<void> deleteWorkout(int id) async {
    await WorkoutDB.deleteWorkout(id);
    loadWorkouts();
  }
}
