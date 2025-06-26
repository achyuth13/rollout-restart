import 'package:rollout_restart/models/driver_progress.dart';

class RaceState {
  final Map<String, DriverProgress> progress;
  final bool isFinished;

  RaceState({required this.progress, required this.isFinished});
}