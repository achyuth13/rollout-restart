import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/tournament_cubit.dart';
import 'custom_elevated_button.dart';

class RaceViewFooter extends StatelessWidget {
  final Map<String, VoidCallback> actions;

  const RaceViewFooter({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: CustomElevatedButton(
            onPressed: () => _showLeaderBoard(context),
            text: "Leaderboard",
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(12),
            child: CustomElevatedButton(
              onPressed: () {
                actions['restart']?.call();
              },
              text: "Restart Race",
            )),
      ],
    );
  }
}

void _showLeaderBoard(BuildContext context) {
  final orderedDrivers = context.read<TournamentCubit>().getFinalLeaderboardDrivers();
  context.push('/drivers',
      extra: {'drivers': orderedDrivers, 'appBarTitle': "Final Leaderboard", 'finalRace': true});
}