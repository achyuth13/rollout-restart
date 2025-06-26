import 'package:rollout_restart/rollout_restart.dart';
import 'package:rollout_restart/rosters/roster_sheet.dart';

Future<void> runSim() async {
  final rosterSheet = RosterSheet.load();
  final tournament = RolloutRestart(rosterSheet: rosterSheet);

  print("starting tournament");
  await tournament.startInitialRaces();

  print("first race complete");
  print("intial leaderboard");
  for (var entry in tournament.leaderboard) {
    print(
        "${entry.position}. ${entry.driver.name} (${entry.team.name}) - ${entry.timeTaken.inSeconds}.${entry.timeTaken.inMilliseconds % 1000}s");
  }

  tournament.setupFinalRace(topN: 5);
  print("starting final race");
  await tournament.startFinalRace();

  print("Final leaderboard");
  final finalLeaderboard = tournament.getFinalLeaderboard();
  for (var entry in finalLeaderboard) {
    print(
        "${entry.position}. ${entry.driver.name} (${entry.team.name}) - ${entry.timeTaken.inSeconds}.${entry.timeTaken.inMilliseconds % 1000}s");
  }
}
