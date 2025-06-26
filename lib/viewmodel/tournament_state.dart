import 'package:rollout_restart/models/leader_board_entry.dart';

abstract class TournamentState {}

class TournamentInitialState extends TournamentState {}

class InitialRacesRunning extends TournamentState {}

class InitialRacesComplete extends TournamentState {}

class FinalRaceRunning extends TournamentState {}

class FinalRaceComplete extends TournamentState {
  final List<LeaderboardEntry> leaderboard;
  FinalRaceComplete(this.leaderboard);
}