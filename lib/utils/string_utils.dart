class AppString {
  /// App Title
  static const String appName = 'Workout Tracker';

  // --- Input Labels ---
  static const String weightKG = 'Weight (kg)';           // Label for weight input
  static const String reps = 'Reps';                      // Label for reps input

  // --- Workout Terminology ---
  static const String workout = 'Workout';                // Generic workout label
  static const String set = 'Set';                        // Generic set label
  static const String setADD = 'Set Add';                 // Message when a set is added
  static const String addSet = 'Add Set';                 // Button label to add a set

  // --- Exercise Names ---
  static const String benchPress = 'Bench press';
  static const String squat = 'Squat';
  static const String deadlift = 'Deadlift';
  static const String shoulderPress = 'Shoulder press';
  static const String barbellRow = 'Barbell row';

  // --- Buttons / Actions ---
  static const String saveWorkout = 'Save Workout';       // Save button text
  static const String editWorkout = 'Edit Workout';       // AppBar title for editing
  static const String newWorkout = 'New Workout';         // AppBar title for new workout

  // --- UI Feedback / Status Messages ---
  static const String noSetsAddedYet = 'No sets added yet.'; // Empty state message
  static const String workoutSaved = 'Workout Saved';         // Confirmation on save
  static const String workoutDeleted = 'Workout Deleted';     // Confirmation on delete
  static const String workoutHistroy = 'Workout Histroy';     // AppBar title for list screen

  static const String setDeletedAndWorkoutUpdated =
      'Set deleted and workout updated';                       // After removing a set
  static const String workoutDeletedBecauseNoSetsRemain =
      'Workout deleted because no sets remain';               // Auto-deletion of empty workout

  // --- Validation & Error Messages ---
  static const String pleaseAddAtLeastOneSet =
      'Please add at least one set.';                         // Save validation
  static const String PleaseFillInAllFieldsForEachSetProperly =
      'Please fill in all fields for each set properly.';     // Input validation
}
