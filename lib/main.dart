import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/repo/race_repo.dart';
import 'package:rollout_restart/screens/tournament_screen.dart';
import 'package:rollout_restart/theme.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/viewmodel/tournament_cubit.dart';

void main() {
  final repo = RaceRepo();
  final raceCubit1 = RaceCubit();
  final raceCubit2 = RaceCubit();

  final tournamentCubit = TournamentCubit(
      repo: repo, raceCubit1: raceCubit1, raceCubit2: raceCubit2);

  runApp(MyApp(
    raceCubit1: raceCubit1,
    raceCubit2: raceCubit2,
    tournamentCubit: tournamentCubit,
  ));
}

class MyApp extends StatelessWidget {
  final RaceCubit raceCubit1;
  final RaceCubit raceCubit2;
  final TournamentCubit tournamentCubit;

  const MyApp({
    super.key,
    required this.raceCubit1,
    required this.raceCubit2,
    required this.tournamentCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tournamentCubit),
        BlocProvider.value(value: raceCubit1),
        BlocProvider.value(value: raceCubit2),
      ],
      child: MaterialApp(
        title: 'Rollout Restart',
        theme: AppTheme.darkTheme,
        home: TournamentScreen(
          raceCubit1: raceCubit1,
          raceCubit2: raceCubit2,
          tournamentCubit: tournamentCubit,
        ),
      ),
    );
  }
}
