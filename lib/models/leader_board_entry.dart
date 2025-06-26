import 'package:rollout_restart/models/team.dart';

import 'driver.dart';

class LeaderboardEntry {
  final Driver driver;
  final Team team;
  final int position;
  final Duration timeTaken;
  final int points;

  LeaderboardEntry(
      {required this.driver,
      required this.team,
      required this.position,
      required this.timeTaken,
      required this.points});
}
