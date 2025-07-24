🏋️ Workout Tracker App

   A simple and effective Flutter app for tracking workout sets, exercises, and progress, using GetX, Sqflite, and Fluttertoast.

📁 Folder Structure

lib/
│
├── controller/              # GetX controllers (state logic)
│   └── workout_controller.dart
│
├── database/                # Local database logic using sqflite
│   └── workout_model.dart
│
├── models/                  # Data models for Workout and WorkoutSet
│   └── workout_model.dart
│
├── screens/                 # UI screens
│   ├── workout_list_screen.dart
│   └── workout_screen.dart
│
├── widget/                  # Reusable widgets/constants
│   └── text.dart
│
└── main.dart                # App entry point

📐 Architecture & State Management
   This app follows a modular, maintainable MVC/MVVM-like structure:

✅ GetX
   Used for state management, dependency injection, and navigation.

Ensures reactivity (RxList) and separation of concerns (logic in controller, UI in screens).

✅ SQFLite
   Used for local persistent storage of workouts.

Workout data is stored as JSON in SQLite.

✅ Fluttertoast
   Provides simple non-intrusive user feedback for events like save, delete, error messages.

🧩 Packages Used
   Package	Purpose
   get	State management, navigation
   sqflite	Local data storage (SQLite)
   path_provider	Helps determine correct DB path
   fluttertoast	Toast notifications

✅ Features
   Add/edit/delete workouts

   Manage multiple sets per workout

   Choose from default exercise types

   Persistent storage using SQLite

   Reactive UI with real-time updates via Obx

🧪 Testing Strategy
   Tests include:

✅ Unit Tests: Validating DB insert/update/load

✅ Widget Tests: Validating UI behavior on input

✅ Integration Tests: Navigating between screens and saving data end-to-end

Located in the test/ and integration_test/ directories (see repo).

🚀 Getting Started
1. Clone Repo
   git clone https://github.com/keyur47/workout_tracker.git
   cd workout_tracker
2. Install Dependencies
   flutter pub get
3. Run the App
   flutter run
4. Run Tests
   flutter test
   flutter drive --driver=integration_test/integration_test_driver.dart --target=integration_test/app_test.dart

👨‍💻 Author
[Keyur Gajipara] - [keyurgajipara1234@gmail.com]