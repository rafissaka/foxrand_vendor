import 'package:flutter/material.dart';

class CustomCircularProgress extends StatefulWidget {
  final double radius;
  final Color color;
  final Duration duration;

  const CustomCircularProgress(
      {super.key,
      required this.radius,
      required this.color,
      required this.duration});

  @override
  State<CustomCircularProgress> createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomProgressIndicatorPainter(
        progress: _animation.value,
        color: widget.color,
      ),
      size: Size(widget.radius * 2, widget.radius * 2),
    );
  }
}

class _CustomProgressIndicatorPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CustomProgressIndicatorPainter(
      {required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const startAngle = -90 * (3.14159 / 180);
    final sweepAngle = 360 * progress * (3.14159 / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CustomProgressIndicatorPainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(_CustomProgressIndicatorPainter oldDelegate) =>
      false;
}
