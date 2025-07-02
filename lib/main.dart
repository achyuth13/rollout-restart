import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/repo/race_repo.dart';
import 'package:rollout_restart/router.dart';
import 'package:rollout_restart/theme.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/viewmodel/tournament_cubit.dart';

void main() {
  runApp(const RolloutApp());
}

class RolloutApp extends StatelessWidget {
  const RolloutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RaceRepo();
    final raceCubit1 = RaceCubit();
    final raceCubit2 = RaceCubit();
    final tournamentCubit = TournamentCubit(
      repo: repo,
      raceCubit1: raceCubit1,
      raceCubit2: raceCubit2,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: raceCubit1),
        BlocProvider.value(value: raceCubit2),
        BlocProvider.value(value: tournamentCubit),
      ],
      child: MaterialApp.router(
        title: 'Rollout Restart',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: appRouter(
          raceCubit1: raceCubit1,
          raceCubit2: raceCubit2,
          tournamentCubit: tournamentCubit,
        ),
      ),
    );
  }
}
