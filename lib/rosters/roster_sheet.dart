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

  late final List<Driver> firstRaceDrivers;
  late final List<Driver> secondRaceDrivers;

  Track get firstRaceTrack => tracks[0];
  Track get secondRaceTrack => tracks[1];

  RosterSheet({
    required this.teams,
    required this.drivers,
    required this.tracks,
    required this.finalTrack,
  }) {
    _distributeDriversToRaces();
  }

  void _distributeDriversToRaces() {
    final Map<String, List<Driver>> teamToDrivers = {};

    for (var driver in drivers) {
      teamToDrivers.putIfAbsent(driver.team.name, () => []).add(driver);
    }

    firstRaceDrivers = [];
    secondRaceDrivers = [];

    for (var teamDrivers in teamToDrivers.values) {
      if (teamDrivers.length >= 2) {
        firstRaceDrivers.add(teamDrivers[0]);
        secondRaceDrivers.add(teamDrivers[1]);
      } else if (teamDrivers.length == 1) {
        // In case there's only one driver for a team
        firstRaceDrivers.add(teamDrivers[0]);
      }
    }
  }

  static RosterSheet load() {
    final teams = TeamRoster.build();
    final drivers = DriverRoster.build(teams);
    final tracks = TrackRoster.buildInitialTracks();
    final finalTrack = TrackRoster.buildFinalTrack();

    return RosterSheet(
      teams: teams,
      drivers: drivers,
      tracks: tracks,
      finalTrack: finalTrack,
    );
  }
}

