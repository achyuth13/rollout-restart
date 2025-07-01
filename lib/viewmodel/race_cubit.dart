import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/engine/race_engine.dart';
import 'package:rollout_restart/viewmodel/race_state.dart';

import '../models/driver_progress.dart';

class RaceCubit extends Cubit<RaceState> {
  RaceCubit() : super(RaceState(progress: {}, isFinished: false));

  void updateProgress(Map<String, DriverProgress> progress, bool isFinished) {
    emit(RaceState(progress: progress, isFinished: isFinished));
  }
}
