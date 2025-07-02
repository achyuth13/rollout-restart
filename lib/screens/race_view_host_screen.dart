import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/screens/race_view_screen.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';

import '../rosters/roster_sheet.dart';
import '../viewmodel/tournament_cubit.dart';
import '../viewmodel/tournament_state.dart';
import '../widgets/top_performers_banner.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showFinalRace ? "Final Race" : (_showRace1 ? "Race 1" : "Race 2"),
        ),
      ),
      body: BlocBuilder<TournamentCubit, TournamentState>(
        builder: (context, state) {
          return Column(
            children: [
              TopPerformersBanner(
                  title: _showRace1
                      ? "Top Performers - Race 2"
                      : "Top Performers - Race 1",
                  topPerformers: _showRace1
                      ? widget.tournamentCubit.repo.tournament.raceEngine2
                          .getResults()
                          .take(3)
                          .toList()
                      : widget.tournamentCubit.repo.tournament.raceEngine1
                          .getResults()
                          .take(3)
                          .toList(),
                  onTap: () {
                    setState(() {
                      _showRace1 = !_showRace1;
                    });
                  }),
              const SizedBox(height: 10),
              Expanded(
                child: _showRace1
                    ? RaceViewScreen(
                        raceCubit: widget.raceCubit1,
                        raceTrack:
                            widget.tournamentCubit.repo.tournament.race1.track)
                    : RaceViewScreen(
                        raceCubit: widget.raceCubit2,
                        raceTrack:
                            widget.tournamentCubit.repo.tournament.race2.track),
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
                          onPressed: () {
                            widget.tournamentCubit.resetTournament();
                            widget.tournamentCubit.startInitialRaces();
                            setState(() {
                              _showFinalRace = false;
                              _showRace1 = true;
                            });
                          },
                          child: const Text("Restart Race"),
                        )),
                  ],
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
