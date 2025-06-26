import 'package:rollout_restart/models/track_segment.dart';

class Track {
  final String id;
  final String name;
  final List<TrackSegment> segments;
  final double totalDistance;

  Track(
      {required this.id,
      required this.name,
      required this.segments,
      required this.totalDistance});
}
