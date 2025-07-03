import 'package:flutter/material.dart';
import 'package:rollout_restart/models/leader_board_entry.dart';

class TopPerformersBanner extends StatelessWidget {
  final List<LeaderboardEntry> topPerformers;
  final String title;
  final VoidCallback onTap;

  const TopPerformersBanner(
      {super.key,
      required this.topPerformers,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical()),
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: topPerformers.map((entry) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: entry.team.color,
                        child: Text(
                          entry.driver.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.driver.name,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${(entry.timeTaken.inMilliseconds / 1000).toStringAsFixed(1)}s",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      )
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
