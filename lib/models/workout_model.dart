import 'dart:convert';

/// SECTION: Models

/// Represents a single exercise set with an exercise name, weight, and reps
class WorkoutSet {
  String exercise;
  double weight;
  double reps;

  /// Constructor to initialize a workout set
  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.reps,
  });

  /// Converts a WorkoutSet instance to a map for storage or serialization
  Map<String, dynamic> toMap() => {
    'exercise': exercise,
    'weight': weight,
    'reps': reps,
  };

  /// Factory constructor to create a WorkoutSet from a map
  /// (typically from database or JSON)
  factory WorkoutSet.fromMap(Map<String, dynamic> map) => WorkoutSet(
    exercise: map['exercise'],
    weight: map['weight'],
    reps: map['reps'],
  );
}

/// Represents a full workout consisting of multiple sets and a creation date
class Workout {
  int? id; // Unique identifier (nullable for new workouts not yet stored)
  List<WorkoutSet> sets; // List of sets performed in the workout
  DateTime createdAt; // Timestamp of when the workout was created

  /// Constructor to create a workout instance
  Workout({
    this.id,
    required this.sets,
    required this.createdAt,
  });

  /// Converts the Workout object into a map for database storage
  ///
  /// - `createdAt` is serialized as ISO8601 string.
  /// - `sets` are encoded as a JSON string.
  Map<String, dynamic> toMap() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'sets': jsonEncode(sets.map((s) => s.toMap()).toList()),
  };

  /// Factory constructor to create a Workout instance from a database map
  ///
  /// - Parses `createdAt` from ISO8601 string.
  /// - Decodes `sets` from a JSON string to a list of WorkoutSet objects.
  factory Workout.fromMap(Map<String, dynamic> map) => Workout(
    id: map['id'],
    createdAt: DateTime.parse(map['createdAt']),
    sets: List<Map<String, dynamic>>.from(jsonDecode(map['sets']))
        .map((s) => WorkoutSet.fromMap(s))
        .toList(),
  );
}
