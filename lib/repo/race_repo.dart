import 'package:rollout_restart/rollout_restart.dart';
import 'package:rollout_restart/rosters/roster_sheet.dart';

class RaceRepo {
  late final RosterSheet _rosterSheet;
  late final RolloutRestart _tournament;

  RaceRepo() {
    _rosterSheet = RosterSheet.load();
    _tournament = RolloutRestart(rosterSheet: _rosterSheet);
  }

  RosterSheet get rosterSheet => _rosterSheet;
  RolloutRestart get tournament => _tournament;
}