import 'package:flutter/material.dart';
import 'package:rollout_restart/models/driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRosterScreen extends StatefulWidget {
  final Map<String, Driver> drivers;
  final String appBarTitle;
  final bool finalRace;

  const DriverRosterScreen(
      {super.key, required this.drivers, required this.appBarTitle, required this.finalRace});

  @override
  State<DriverRosterScreen> createState() => _DriverRosterScreenState();
}

class _DriverRosterScreenState extends State<DriverRosterScreen> {
  late bool _isGridView;

  @override
  void initState() {
    super.initState();
    if (widget.finalRace) {
      _isGridView = false;
    } else {
      _isGridView = true;
      _loadViewPreference();
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          if (!widget.finalRace)
            IconButton(
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
              onPressed: _toggleView,
            ),
        ],
      ),
      body: _isGridView ? _buildGroupedTeamView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    final entries = widget.drivers.entries.toList();

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final position = entry.key;
        final driver = entry.value;

        Color? borderColor;
        if (widget.finalRace) {
          if (position == '1') {
            borderColor = Colors.amber.shade400;
          } else if (position == '2') {
            borderColor = Colors.grey.shade400;
          } else if (position == '3') {
            borderColor = Colors.brown.shade400;
          }
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: driver.team.color.withOpacity(0.5),
            borderRadius: const BorderRadius.vertical(),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 4 : 0,
            ),
            boxShadow: [
              BoxShadow(
                color: driver.team.color.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.team.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          driver.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.finalRace)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        position,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGroupedTeamView() {
    final Map<String, List<Driver>> teamToDrivers = {};

    for (var driver in widget.drivers.values) {
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
