import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/models/driver_progress.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/viewmodel/tournament_state.dart';

import '../repo/race_repo.dart';

class TournamentCubit extends Cubit<TournamentState> {
  final RaceRepo repo;
  final RaceCubit raceCubit1;
  final RaceCubit raceCubit2;

  TournamentCubit({
    required this.repo,
    required this.raceCubit1,
    required this.raceCubit2,
  }) : super(TournamentInitialState());

  Future<void> startInitialRaces() async {
    emit(InitialRacesRunning());
    const tickInterval = Duration(milliseconds: 100);

    while (!repo.tournament.race1.isFinished || !repo.tournament.race2.isFinished) {
      if (!repo.tournament.race1.isFinished) {
        repo.tournament.raceEngine1.tick(tickInterval);
        raceCubit1.updateProgress(
          repo.tournament.raceEngine1.getProgressMap(),
          false,
        );
      }

      if (!repo.tournament.race2.isFinished) {
        repo.tournament.raceEngine2.tick(tickInterval);
        raceCubit2.updateProgress(
          repo.tournament.raceEngine2.getProgressMap(),
          false,
        );
      }

      await Future.delayed(tickInterval);
    }

    raceCubit1.updateProgress(repo.tournament.raceEngine1.getProgressMap(), true);
    raceCubit2.updateProgress(repo.tournament.raceEngine2.getProgressMap(), true);

    final result1 = repo.tournament.raceEngine1.getResults();
    final result2 = repo.tournament.raceEngine2.getResults();
    repo.tournament.leaderboard.addAll(result1);
    repo.tournament.leaderboard.addAll(result2);

    emit(InitialRacesComplete());
  }

  Future<void> startFinalRace() async {
    emit(FinalRaceRunning());
    repo.tournament.setupFinalRace(topN: 2);
    await repo.tournament.startFinalRace();
    emit(FinalRaceComplete(repo.tournament.getFinalLeaderboard()));
  }

  List<DriverProgress> getTopDriversProgress(RaceCubit current) {
    final otherRaceCubit = current == raceCubit1 ? raceCubit2 : raceCubit1;
    return otherRaceCubit.state.progress.values
        .toList()
        ..sort((a,b) => b.distanceCovered.compareTo(a.distanceCovered));
  }

  void resetTournament() {
    repo.tournament.reset(); // You need to implement this
    emit(TournamentInitialState());
  }

}