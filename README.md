# 🏎️ Rollout Restart - Flutter Racing Sim

This is a **simple racing simulation app** built using **Flutter**. The app runs **two races in parallel**, each between a set of drivers, and visually displays progress along with **top performers** for each race.

### 🚀 What it Does
- Runs **Race 1** and **Race 2** in parallel.
- Shows live progress for both races.
- Displays a **Top Performers banner** (podium-style) for the alternate race.
- Allows you to view all drivers, or see the final **leaderboard** after both races.
- UI built with Flutter, using `go_router`, `flutter_bloc`, and shared preferences for local state.

![Demo](assets/demo.gif)

### 🎯 Why This Exists
This project was built as a way to:
- Understand **Flutter’s navigation** (`go_router`)
- Practice **state management** with `Bloc`
- Work with custom widgets, animations, and shared preferences
- Explore parallel UI updates and game logic coordination

### 🧱 Features
- 🧭 Navigation with `go_router`
- 🔄 Parallel race execution
- 🧠 State management with `flutter_bloc`
- 🏅 Leaderboard and Top Performers logic
- 💾 Persistent view state (list/grid toggle) via SharedPreferences


### 🧪 How to Run
Make sure Flutter is set up, then:

```bash
flutter pub get
flutter run

