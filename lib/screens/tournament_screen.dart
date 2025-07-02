import 'package:flutter/material.dart';
import 'package:rollout_restart/screens/race_view_host_screen.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/viewmodel/tournament_cubit.dart';

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
             child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(context,
                   MaterialPageRoute(builder: (_) => DriverRosterScreen(drivers: widget.tournamentCubit.repo.rosterSheet.drivers)));
                 },
                 child: const Text("See drivers")
             ),
           ),
           const SizedBox(height: 20.0),
           Center(
             child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (_) => RaceViewHostScreen(
                               raceCubit1: widget.raceCubit1,
                               raceCubit2: widget.raceCubit2,
                               tournamentCubit: widget.tournamentCubit
                           )));
                 },
                 child: const Text("Start Races")),
           ),
           const SizedBox(width: 20.0, height: 20.0),
           const Text("Two races will start in parallel")
         ],
        ));
  }
}
