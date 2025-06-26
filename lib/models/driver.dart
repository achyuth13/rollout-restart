import 'package:rollout_restart/models/team.dart';

class Driver {
  final String id;
  final String name;
  final Team team;
  final int aggressiveMaxSpeed;
  final int driverControl;

  Driver({
    required this.id,
    required this.name,
    required this.team,
    required this.aggressiveMaxSpeed,
    required this.driverControl,
  });
}
