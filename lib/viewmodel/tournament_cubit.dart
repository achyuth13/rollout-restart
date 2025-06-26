import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/repo/race_repo.dart';
import 'package:rollout_restart/viewmodel/tournament_state.dart';

class TournamentCubit extends Cubit<TournamentState> {
  final RaceRepo repo;

  TournamentCubit({required this.repo}) : super(TournamentInitialState());

  Future<void> startInitialRaces() async {
    emit(InitialRacesRunning());
    await repo.tournament.startInitialRaces();
    emit(InitialRacesComplete());
  }

  Future<void> startFinalRace() async {
    emit(FinalRaceRunning());
    repo.tournament.setupFinalRace(topN: 2);
    await repo.tournament.startFinalRace();
    emit(FinalRaceComplete(repo.tournament.getFinalLeaderboard()));
  }

}