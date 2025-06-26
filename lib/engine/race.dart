import 'package:rollout_restart/models/driver_progress.dart';

import '../models/driver.dart';
import '../models/track.dart';

class Race {
  final Track track;
  final List<Driver> drivers;
  final Map<String, DriverProgress> progressMap = {};
  bool isFinished = false;

  Race({required this.track, required this.drivers}) {
    _initializeProgress();
  }

  void _initializeProgress() {
    for (final driver in drivers) {
      progressMap[driver.id] =
          DriverProgress(driver, 0.0, 0, false, Duration.zero);
    }
  }

  void giveHeadStart(String driverId, double meters) {
    final dp = progressMap[driverId];
    if (dp != null) {
      dp.distanceCovered += meters;
      dp.isHeadStarted = true;
    }
  }
}
