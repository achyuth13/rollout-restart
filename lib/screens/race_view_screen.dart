import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/models/driver_progress.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';

import '../models/track.dart';
import '../viewmodel/race_state.dart';
import 'animated_car_track.dart';

class RaceViewScreen extends StatelessWidget {
  final RaceCubit raceCubit;
  final Track raceTrack;

  const RaceViewScreen({super.key, required this.raceCubit, required this.raceTrack});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaceCubit, RaceState>(
        bloc: raceCubit,
        builder: (context, state) {
          final progressMap = state.progress;
          final isFinished = state.isFinished;
          return Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: progressMap.values
                      .map((dp) => _buildAnimatedDriversColumn(dp, raceTrack))
                      .toList(),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  (isFinished ? "Race Complete" : "Racing..."),
                ),
              )
            ],
          );
        });
  }
}

Widget _buildAnimatedDriversColumn(DriverProgress dp, Track raceTrack) {
  final progress = (dp.distanceCovered / 300).clamp(0.0, 1.0);
  return AnimatedCarTrack(
    progress: progress,
    trackColor: dp.driver.team.color,
    driverName: dp.driver.name,
    segments: raceTrack.segments,
  );
}

