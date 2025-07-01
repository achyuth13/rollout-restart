import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/models/driver_progress.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';

import '../viewmodel/race_state.dart';

class RaceViewScreen extends StatelessWidget {
  final RaceCubit raceCubit;

  const RaceViewScreen({super.key, required this.raceCubit});

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
                      .map((dp) => _buildDriversColumn(dp))
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

Widget _buildDriversColumn(DriverProgress dp) {
  final progress = (dp.distanceCovered / 300).clamp(0.0, 1.0);

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
          child: RotatedBox(
        quarterTurns: -1,
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 20,
          color: dp.driver.team.color,
          backgroundColor: Colors.grey.shade300,
        ),
      )),
      const SizedBox(height: 8),
      SizedBox(
        width: 60,
        child: Text(
          dp.driver.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}
