import 'package:rollout_restart/models/leader_board_entry.dart';

abstract class TournamentState {}

class TournamentInitialState extends TournamentState {}

class InitialRacesRunning extends TournamentState {
  final List<LeaderboardEntry> liveRace1;
  final List<LeaderboardEntry> liveRace2;

  InitialRacesRunning({required this.liveRace1, required this.liveRace2});
}

class InitialRacesComplete extends TournamentState {}

class FinalRaceRunning extends TournamentState {}

class FinalRaceComplete extends TournamentState {
  final List<LeaderboardEntry> leaderboard;
  FinalRaceComplete(this.leaderboard);
}