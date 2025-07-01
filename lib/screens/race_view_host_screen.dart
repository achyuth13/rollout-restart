import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/screens/race_view_screen.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';

import '../rosters/roster_sheet.dart';
import '../viewmodel/tournament_cubit.dart';
import '../viewmodel/tournament_state.dart';

class RaceViewHostScreen extends StatefulWidget {
  final RaceCubit raceCubit1;
  final RaceCubit raceCubit2;
  final TournamentCubit tournamentCubit;

  const RaceViewHostScreen({
    super.key,
    required this.raceCubit1,
    required this.raceCubit2,
    required this.tournamentCubit,
  });

  @override
  State<RaceViewHostScreen> createState() => _RaceViewHostScreenState();
}

class _RaceViewHostScreenState extends State<RaceViewHostScreen> {
  bool _showRace1 = true;
  bool _showFinalRace = false;


  @override
  void initState() {
    super.initState();
    widget.tournamentCubit.resetTournament();
    widget.tournamentCubit.startInitialRaces();
  }

  void _startFinalRace() {
    widget.tournamentCubit.startFinalRace();
    setState(() {
      _showFinalRace = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showFinalRace
              ? "Final Race"
              : (_showRace1 ? "Race 1" : "Race 2"),
        ),
        actions: !_showFinalRace
            ? [
          IconButton(
            onPressed: () {
              setState(() {
                _showRace1 = !_showRace1;
              });
            },
            icon: const Icon(Icons.swap_horiz),
          ),
        ]
            : null,
      ),
      body: BlocBuilder<TournamentCubit, TournamentState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: _showRace1
                    ? RaceViewScreen(raceCubit: widget.raceCubit1, raceTrack: widget.tournamentCubit.repo.tournament.race1.track)
                    : RaceViewScreen(raceCubit: widget.raceCubit2, raceTrack: widget.tournamentCubit.repo.tournament.race2.track),
              ),
              if (state is InitialRacesComplete && !_showFinalRace)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: () => _showLeaderBoard(context),
                        child: const Text("Leaderboard"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: _startFinalRace,
                        child: const Text("Start Final Race"),
                      ),
                    ),
                  ],
                ),
              if (state is FinalRaceComplete && _showFinalRace)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () => _showLeaderBoard(context),
                    child: const Text("Final Leaderboard"),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}


void _showLeaderBoard(BuildContext context) {
  final leaderBoard =
      context.read<TournamentCubit>().repo.tournament.getFinalLeaderboard();
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: leaderBoard
              .map((entry) => ListTile(
                    title: Text("${entry.driver.name} (${entry.team.name})"),
                    trailing: Text("${entry.timeTaken.inMilliseconds / 1000}s"),
                  ))
              .toList(),
        );
      });
}
