import 'package:flutter/material.dart';
import 'package:rollout_restart/models/driver.dart';

class DriverRosterScreen extends StatefulWidget {
  final List<Driver> drivers;

  const DriverRosterScreen({super.key, required this.drivers});

  @override
  State<DriverRosterScreen> createState() => _DriverRosterScreenState();
}

class _DriverRosterScreenState extends State<DriverRosterScreen> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drivers"),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          )
        ],
      ),
      body: _isGridView ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: widget.drivers.length,
      itemBuilder: (context, index) {
        final driver = widget.drivers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          color: driver.team.color.withOpacity(0.5),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: Text(driver.name, style: const TextStyle(color: Colors.white)),
            subtitle: Text("Team: ${driver.team.name}", style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.drivers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final driver = widget.drivers[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          color: driver.team.color.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(driver.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Team: ${driver.team.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        );
      },
    );
  }
}
