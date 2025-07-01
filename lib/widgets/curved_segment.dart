import 'package:flutter/cupertino.dart';

class CurvedSegment extends StatelessWidget {
  final Color color;
  const CurvedSegment({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: _CurveSegmentPainter(color),
    );
  }
}

class _CurveSegmentPainter extends CustomPainter {
  final Color color;

  _CurveSegmentPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = color.withOpacity(0.3)
        ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height);

    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.75,  // control point
      size.width, size.height * 0.5,         // end point
    );

    // Curve to top
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.25,
      0, 0,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
