import '../models/driver.dart';

import '../models/team.dart';

class DriverRoster {
  static List<Driver> build(List<Team> teams) {
    return [
      Driver(id: "nate", name: "Nate Ax Prems V", team: teams[0], aggressiveMaxSpeed: 122, driverControl: 78),
      Driver(id: "zero", name: "Zero Gripe Se", team: teams[0], aggressiveMaxSpeed: 117, driverControl: 85),

      // Mad Scree Gems
      Driver(id: "lone", name: "Lone Slim Witha", team: teams[1], aggressiveMaxSpeed: 120, driverControl: 88),
      Driver(id: "urg", name: "Urg Sole Greels", team: teams[1], aggressiveMaxSpeed: 116, driverControl: 82),

      // Lancer M
      Driver(id: "reach", name: "Reach Cell Slicer", team: teams[2], aggressiveMaxSpeed: 121, driverControl: 75),
      Driver(id: "zas", name: "Zas Ionic Lars", team: teams[2], aggressiveMaxSpeed: 118, driverControl: 90),

      // Rare Fir
      Driver(id: "loaned", name: "Loaned Son Afro", team: teams[3], aggressiveMaxSpeed: 119, driverControl: 79),
      Driver(id: "stone", name: "Stone Crall LL", team: teams[3], aggressiveMaxSpeed: 115, driverControl: 83),

      // Tornado Mantis
      Driver(id: "snarl", name: "Snarl Indoors", team: teams[4], aggressiveMaxSpeed: 124, driverControl: 68),
      Driver(id: "racist", name: "Racist Spa Roar", team: teams[4], aggressiveMaxSpeed: 123, driverControl: 72),
    ];
  }
}

