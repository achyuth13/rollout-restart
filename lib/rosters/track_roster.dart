import '../models/track.dart';
import '../models/track_segment.dart';

class TrackRoster {
  static List<Track> buildInitialTracks() {
    final thunderValley = Track(
      id: "track1",
      name: "Thunder Valley",
      segments: [
        TrackSegment(segmentType: SegmentType.straight, length: 100),
        TrackSegment(segmentType: SegmentType.curve, length: 100),
        TrackSegment(segmentType: SegmentType.boost, length: 100),
      ],
      totalDistance: 300,
    );

    final blizzardRun = Track(
      id: "track2",
      name: "Blizzard Run",
      segments: [
        TrackSegment(segmentType: SegmentType.gravel, length: 80),
        TrackSegment(segmentType: SegmentType.curve, length: 120),
        TrackSegment(segmentType: SegmentType.straight, length: 100),
      ],
      totalDistance: 300,
    );

    return [thunderValley, blizzardRun];
  }

  static Track buildFinalTrack() {
    return Track(
      id: "track3",
      name: "Inferno Spiral",
      segments: [
        TrackSegment(segmentType: SegmentType.straight, length: 120),
        TrackSegment(segmentType: SegmentType.curve, length: 100),
        TrackSegment(segmentType: SegmentType.gravel, length: 40),
        TrackSegment(segmentType: SegmentType.boost, length: 40),
      ],
      totalDistance: 300,
    );
  }
}
