import 'package:rollout_restart/rosters/driver_roster.dart';
import 'package:rollout_restart/rosters/team_roster.dart';
import 'package:rollout_restart/rosters/track_roster.dart';

import '../models/driver.dart';
import '../models/team.dart';
import '../models/track.dart';

class RosterSheet {
  final List<Team> teams;
  final List<Driver> drivers;
  final List<Track> tracks;
  final Track finalTrack;

  RosterSheet(
      {required this.teams, required this.drivers, required this.tracks, required this.finalTrack});

  List<Driver> get firstRaceDrivers => drivers.sublist(0, 5);
  List<Driver> get secondRaceDrivers => drivers.sublist(5, 10);
  Track get firstRaceTrack => tracks[0];
  Track get secondRaceTrack => tracks[1];

  static RosterSheet load() {
    final teams = TeamRoster.build();
    final drivers = DriverRoster.build(teams);
    final tracks = TrackRoster.buildInitialTracks();
    final finalTrack = TrackRoster.buildFinalTrack();

    return RosterSheet(teams: teams, drivers: drivers, tracks: tracks, finalTrack: finalTrack);
  }
}
