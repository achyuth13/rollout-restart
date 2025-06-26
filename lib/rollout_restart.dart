import 'package:rollout_restart/models/leader_board_entry.dart';
import 'package:rollout_restart/rosters/roster_sheet.dart';

import 'engine/race.dart';
import 'engine/race_engine.dart';

class RolloutRestart {
  final RosterSheet rosterSheet;
  late final Race race1;
  late final Race race2;
  late final Race finalRace;

  late final RaceEngine raceEngine1;
  late final RaceEngine raceEngine2;
  late final RaceEngine finalRaceEngine;

  final List<LeaderboardEntry> leaderboard = [];

  RolloutRestart({required this.rosterSheet}) {
    _setupInitialRaces();
  }

  void _setupInitialRaces() {
    race1 = Race(
        track: rosterSheet.firstRaceTrack,
        drivers: rosterSheet.firstRaceDrivers);
    race2 = Race(
        track: rosterSheet.secondRaceTrack,
        drivers: rosterSheet.secondRaceDrivers);

    raceEngine1 = RaceEngine(race1);
    raceEngine2 = RaceEngine(race2);
  }

  Future<void> startInitialRaces() async {
    final Duration tickInterval = Duration(milliseconds: 100);

    while (!race1.isFinished || !race2.isFinished) {
      if (!race1.isFinished) raceEngine1.tick(tickInterval);
      if (!race2.isFinished) raceEngine2.tick(tickInterval);
      await Future.delayed(tickInterval);
    }

    final result1 = raceEngine1.getResults();
    final result2 = raceEngine2.getResults();
    leaderboard.addAll(result1);
    leaderboard.addAll(result2);
  }

  void setupFinalRace({int topN = 2}) {
    final topDrivers = leaderboard
        .where((entry) => entry.position <= topN)
        .map((entry) => entry.driver)
        .toList();

    finalRace = Race(track: rosterSheet.firstRaceTrack, drivers: topDrivers);
    finalRaceEngine = RaceEngine(finalRace);
  }

  Future<void> startFinalRace() async {
    final Duration tickInterval = Duration(milliseconds: 100);
    while (!finalRace.isFinished) {
      finalRaceEngine.tick(tickInterval);
      await Future.delayed(tickInterval);
    }

    final finalResults = finalRaceEngine.getResults();
    leaderboard.clear();
    leaderboard.addAll(finalResults);
  }

  List<LeaderboardEntry> getFinalLeaderboard() {
    leaderboard.sort((a, b) => a.position.compareTo(b.position));
    return leaderboard;
  }
}
