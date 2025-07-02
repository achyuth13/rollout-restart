import 'package:flutter/material.dart';
import 'package:rollout_restart/models/track_segment.dart';

class AnimatedCarTrack extends StatelessWidget {
  final double progress;
  final Color trackColor;
  final String driverName;
  final List<TrackSegment> segments;

  const AnimatedCarTrack({
    super.key,
    required this.progress,
    required this.trackColor,
    required this.driverName,
    required this.segments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // BASE TRACK WITH SEGMENT COLORS
              Container(
                width: 40,
                child: Column(
                  children: segments.map((segment) {
                    final color = _segmentColor(segment.segmentType);
                    return Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.25),
                              border: const Border(
                                top: BorderSide(color: Colors.white30, width: 0.5),
                              ),
                            ),
                          ),
                          Center(
                            child: RotatedBox(
                              quarterTurns: 3, // 90 degrees counter-clockwise
                              child: Text(
                                segment.segmentType.name.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // PROGRESS COLOR FILL
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, animatedValue, child) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: animatedValue,
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          color: trackColor.withOpacity(0.35),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // CAR ICON MOVEMENT
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: progress),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment(0, 1 - 2 * value),
                    child: child,
                  );
                },
                child: Icon(Icons.directions_car, color: trackColor),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        // DRIVER NAME
        SizedBox(
          width: 60,
          child: Text(
            driverName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _segmentColor(SegmentType type) {
    switch (type) {
      case SegmentType.straight:
        return Colors.grey.shade400;
      case SegmentType.curve:
        return Colors.blueAccent;
      case SegmentType.gravel:
        return Colors.brown;
      case SegmentType.boost:
        return Colors.orangeAccent;
    }
  }
}
