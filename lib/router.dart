import 'package:go_router/go_router.dart';
import 'package:rollout_restart/screens/driver_roster_screen.dart';
import 'package:rollout_restart/screens/race_view_host_screen.dart';
import 'package:rollout_restart/screens/tournament_screen.dart';

import '../repo/race_repo.dart';
import '../viewmodel/race_cubit.dart';
import '../viewmodel/tournament_cubit.dart';
import 'models/driver.dart';

GoRouter appRouter({
  required RaceCubit raceCubit1,
  required RaceCubit raceCubit2,
  required TournamentCubit tournamentCubit,
}) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => TournamentScreen(
          raceCubit1: raceCubit1,
          raceCubit2: raceCubit2,
          tournamentCubit: tournamentCubit,
        ),
      ),
      GoRoute(
        path: '/drivers',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final drivers = extra['drivers'] as List<Driver>;
          final appBarTitle = extra['appBarTitle'] as String;

          return DriverRosterScreen(
            drivers: drivers,
            appBarTitle: appBarTitle,
          );
        },
      ),
      GoRoute(
        path: '/races',
        builder: (context, state) => RaceViewHostScreen(
          raceCubit1: raceCubit1,
          raceCubit2: raceCubit2,
          tournamentCubit: tournamentCubit,
        ),
      ),
    ],
  );
}

