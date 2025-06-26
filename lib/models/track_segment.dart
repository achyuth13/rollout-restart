enum SegmentType { straight, curve, gravel, boost }

class TrackSegment {
  final SegmentType segmentType;
  final double length;

  TrackSegment({required this.segmentType, required this.length});
}
