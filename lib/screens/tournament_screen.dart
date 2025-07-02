import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rollout_restart/screens/race_view_host_screen.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/viewmodel/tournament_cubit.dart';

import '../widgets/custom_elevated_button.dart';
import 'driver_roster_screen.dart';

enum RaceView { race1, race2 }

class TournamentScreen extends StatefulWidget {
  final RaceCubit raceCubit1;
  final RaceCubit raceCubit2;
  final TournamentCubit tournamentCubit;

  const TournamentScreen(
      {super.key,
      required this.raceCubit1,
      required this.raceCubit2,
      required this.tournamentCubit});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tournament"),
        ),
        body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
             child: CustomElevatedButton(
               onPressed: () => context.push(
                 '/drivers',
                 extra: {
                   'drivers': widget.tournamentCubit.repo.rosterSheet.drivers,
                   'appBarTitle': 'Driver Roster',
                 },
               ),
               text: "See drivers",
             ),
           ),
           const SizedBox(height: 20.0),
           Center(
             child: CustomElevatedButton(
                 onPressed: () => context.push('/races'),
                 text: "Start Races"),
           ),
           const SizedBox(width: 20.0, height: 20.0),
           const Text("Two races will start in parallel")
         ],
        ));
  }
}
