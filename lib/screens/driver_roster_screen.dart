import 'package:flutter/material.dart';
import 'package:rollout_restart/models/driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRosterScreen extends StatefulWidget {
  final List<Driver> drivers;
  final String appBarTitle;

  const DriverRosterScreen(
      {super.key, required this.drivers, required this.appBarTitle});

  @override
  State<DriverRosterScreen> createState() => _DriverRosterScreenState();
}

class _DriverRosterScreenState extends State<DriverRosterScreen> {
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _loadViewPreference();
  }

  Future<void> _loadViewPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isGridView = prefs.getBool('isGridView') ?? false;
    });
  }

  Future<void> _toggleView() async {
    setState(() {
      _isGridView = !_isGridView;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGridView', _isGridView);
    print("Grid view after setting ${prefs.get('isGridView')}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => _toggleView(),
          )
        ],
      ),
      body: _isGridView ? _buildGroupedTeamView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: widget.drivers.length,
      itemBuilder: (context, index) {
        final driver = widget.drivers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical()),
          elevation: 4,
          color: driver.team.color.withOpacity(0.5),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title:
                Text(driver.name, style: const TextStyle(color: Colors.white)),
            subtitle: Text("Team: ${driver.team.name}",
                style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _buildGroupedTeamView() {
    // Group drivers by team
    final Map<String, List<Driver>> teamToDrivers = {};
    for (var driver in widget.drivers) {
      teamToDrivers.putIfAbsent(driver.team.name, () => []).add(driver);
    }

    final teamEntries = teamToDrivers.entries.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: teamEntries.length,
      itemBuilder: (context, index) {
        final teamName = teamEntries[index].key;
        final drivers = teamEntries[index].value;
        final teamColor = drivers.first.team.color;

        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical()),
          elevation: 4,
          color: teamColor.withOpacity(0.3),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Team: $teamName",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: drivers.map((driver) {
                    return Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.person, color: Colors.white, size: 36),
                          const SizedBox(height: 6),
                          Text(
                            driver.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
