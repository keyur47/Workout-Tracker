import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:workout/models/workout_model.dart';

/// SECTION: SQLite Local Database Handler for Workout App
class WorkoutDB {
  /// Singleton instance of the database
  static Database? _db;

  /// Initializes and returns the database instance
  ///
  /// - Creates a `workouts` table if it doesn't exist.
  /// - The table includes `id`, `createdAt`, and `sets` fields.
  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'workouts.db');

    // Open or create the database and define the table schema
    return _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE workouts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            createdAt TEXT,
            sets TEXT
          )
        ''');
      },
    );
  }

  /// Inserts a workout into the database
  ///
  /// - Takes a `Workout` object and stores it in the `workouts` table.
  static Future<void> insertWorkout(Workout w) async {
    await _db!.insert('workouts', w.toMap());
  }

  /// Retrieves all workouts from the database
  ///
  /// - Returns a list of `Workout` objects mapped from the DB.
  static Future<List<Workout>> getAll() async {
    final res = await _db!.query('workouts');
    return res.map((e) => Workout.fromMap(e)).toList();
  }

  /// Deletes a specific workout by its ID
  ///
  /// - Accepts the workout `id` to be removed from the DB.
  static Future<void> deleteWorkout(int id) async {
    await _db!.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }

  /// Updates an existing workout in the database
  ///
  /// - Matches the workout by `id` and updates its values.
  static Future<void> updateWorkout(Workout w) async {
    await _db!.update(
      'workouts',
      w.toMap(),
      where: 'id = ?',
      whereArgs: [w.id],
    );
  }
}
