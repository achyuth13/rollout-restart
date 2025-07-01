import 'package:flutter/material.dart';

import '../models/team.dart';

class TeamRoster {
  static List<Team> build() {
    return [
      Team(id: 1, name: "Crude Bling Liar", color: Colors.blueAccent),
      Team(id: 2, name: "Mad Scree Gems", color: Colors.black),
      Team(id: 3, name: "Lancer M", color: Colors.orange),
      Team(id: 4, name: "Rare Fir", color: Colors.redAccent),
      Team(id: 1, name: "Tornado Manti", color: Colors.green),
    ];
  }
}
