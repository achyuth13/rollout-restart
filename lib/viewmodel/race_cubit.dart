import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/engine/race_engine.dart';
import 'package:rollout_restart/viewmodel/race_state.dart';

class RaceCubit extends Cubit<RaceState> {
  final RaceEngine raceEngine;

  RaceCubit({required this.raceEngine}) : super(RaceState(progress: {}, isFinished: false));

  void start() async {
    const tickInterval = Duration(milliseconds: 100);
    while(!raceEngine.race.isFinished) {
      raceEngine.tick(tickInterval);
      emit(RaceState(progress: raceEngine.getProgressMap(), isFinished: false));
      await Future.delayed(tickInterval);
    }
  }
}