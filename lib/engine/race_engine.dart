import 'dart:math';

import 'package:rollout_restart/engine/race.dart';
import 'package:rollout_restart/models/leader_board_entry.dart';
import 'package:rollout_restart/models/track_segment.dart';

import '../models/driver_progress.dart';

class RaceEngine {
  final Race race;

  RaceEngine(this.race);

  void tick(Duration delta) {
    for (final dp in race.progressMap.values) {
      if (dp.currentSegmentIndex >= race.track.segments.length) continue;

      final segment = race.track.segments[dp.currentSegmentIndex];
      final modifier = _segmentModifier(segment.segmentType);
      final controlFactor = dp.driver.driverControl / 100.0;
      final randomness = _randomness();

      final baseSpeed = dp.driver.aggressiveMaxSpeed * 1000 / 3600;
      final effectiveSpeed = baseSpeed * modifier * controlFactor * randomness;
      final progress = effectiveSpeed * delta.inMilliseconds / 1000;

      dp.distanceCovered += progress;
      dp.totalTimeTaken += delta;

      final segmentOffset = _segmentStartOffset(dp.currentSegmentIndex);
      if (dp.distanceCovered - segmentOffset >= segment.length) {
        dp.currentSegmentIndex++;
      }
    }

    if (_allDriversFinished()) {
      race.isFinished = true;
    }
  }

  List<LeaderboardEntry> getResults() {
    final results = race.progressMap.values.toList()
      ..sort((a, b) => a.totalTimeTaken.compareTo(b.totalTimeTaken));
    return results.asMap().entries.map((entry) {
      final pos = entry.key + 1;
      final dp = entry.value;

      return LeaderboardEntry(
          driver: dp.driver,
          team: dp.driver.team,
          position: pos,
          timeTaken: dp.totalTimeTaken,
          points: _pointsForPosition(pos));
    }).toList();
  }

  Map<String, DriverProgress> getProgressMap() {
    return race.progressMap;
  }


  double _segmentModifier(SegmentType type) {
    switch (type) {
      case SegmentType.straight:
        return 1.0;
      case SegmentType.curve:
        return 0.7;
      case SegmentType.gravel:
        return 0.5;
      case SegmentType.boost:
        return 1.2;
    }
  }

  void reset() {
    for (final dp in race.progressMap.values) {
      dp.distanceCovered = 0;
      dp.totalTimeTaken = Duration.zero;
      dp.currentSegmentIndex = 0;
    }

    race.isFinished = false;
  }

  double _segmentStartOffset(int index) {
    double offset = 0.0;
    for (int i = 0; i < index; i++) {
      offset += race.track.segments[i].length;
    }
    return offset;
  }

  double _randomness() {
    return Random().nextDouble() * 0.1 + 0.95;
  }

  bool _allDriversFinished() {
    return race.progressMap.values
        .every((dp) => dp.distanceCovered >= race.track.totalDistance);
  }

  int _pointsForPosition(int pos) {
    switch (pos) {
      case 1:
        return 10;
      case 2:
        return 7;
      case 3:
        return 5;
      case 4:
        return 3;
      case 5:
        return 1;
      default:
        return 0;
    }
  }
}
