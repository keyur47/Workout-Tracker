import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout/controller/workout_controller.dart';
import 'package:workout/database/workout_model.dart';
import 'package:workout/utils/string_utils.dart';

import 'screens/workout_list_screen.dart';

/// ENTRY POINT: Initializes the app
Future<void> main() async {
  // Ensures Flutter bindings are initialized before using platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the local SQLite database
  await WorkoutDB.initDb();

  // Inject WorkoutController into the GetX dependency system
  Get.put(WorkoutController());

  // Launch the application
  runApp(MyApp());
}

/// SECTION: Main App Widget
/// Sets up global routing, app title, and initial screen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppString.appName,         // App name shown in device/app switcher
      home: WorkoutListScreen(),        // Initial screen of the app
    );
  }
}
