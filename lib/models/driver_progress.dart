import 'driver.dart';

class DriverProgress {
  final Driver driver;
  double distanceCovered;
  int currentSegmentIndex;
  bool isHeadStarted;
  Duration totalTimeTaken;

  DriverProgress(this.driver, this.distanceCovered, this.currentSegmentIndex,
      this.isHeadStarted, this.totalTimeTaken);
}