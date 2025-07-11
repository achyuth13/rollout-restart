import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollout_restart/screens/race_view_screen.dart';
import 'package:rollout_restart/viewmodel/race_cubit.dart';
import 'package:rollout_restart/widgets/count_down_widget.dart';
import 'package:rollout_restart/widgets/race_view_footer.dart';

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
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    _startCountdownAndRace();
  }

  Future<void> _startCountdownAndRace() async {
    widget.tournamentCubit.resetTournament();
    for (int i = 3; i >= 1; i--) {
      setState(() => _countdown = i);
      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() => _countdown = 0);
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
          return Stack(children: [
            Column(
              children: [
                if (_countdown == 0)
                  TopPerformersBanner(
                    title: _showRace1
                        ? "Top Performers - Race 2"
                        : "Top Performers - Race 1",
                    topPerformers: _showRace1
                        ? context
                            .read<TournamentCubit>()
                            .getTopPerformersForRace2()
                        : context
                            .read<TournamentCubit>()
                            .getTopPerformersForRace1(),
                    onTap: () {
                      setState(() {
                        _showRace1 = !_showRace1;
                      });
                    },
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: _showRace1
                      ? RaceViewScreen(
                          raceCubit: widget.raceCubit1,
                          raceTrack: widget
                              .tournamentCubit.repo.tournament.race1.track)
                      : RaceViewScreen(
                          raceCubit: widget.raceCubit2,
                          raceTrack: widget
                              .tournamentCubit.repo.tournament.race2.track),
                ),
                if (state is InitialRacesComplete && !_showFinalRace)
                  RaceViewFooter(
                    actions: {
                      'restart': () {
                        setState(() {
                          _showFinalRace = false;
                          _showRace1 = true;
                        });
                        _startCountdownAndRace();
                      }
                    },
                  )
              ],
            ),
            if (_countdown > 0) CountdownWidget(countdown: _countdown)
          ]);
        },
      ),
    );
  }
}
