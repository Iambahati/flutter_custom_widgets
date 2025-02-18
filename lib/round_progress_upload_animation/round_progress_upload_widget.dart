import 'package:flutter/material.dart';
import 'dart:math' as math show pi;

class RoundProgressUploadAnimation extends StatefulWidget {
  final double radius;
  final double? progress;
  final Color color;
  final Widget? child;
  final double strokeWidth;

  const RoundProgressUploadAnimation(
      {super.key,
      required this.radius,
      this.progress,
      required this.color,
      this.child,
      this.strokeWidth = 4.0});

  @override
  State<RoundProgressUploadAnimation> createState() =>
      _RoundProgressUploadAnimationState();
}

class _RoundProgressUploadAnimationState
    extends State<RoundProgressUploadAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RoundProgressUploadAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != null &&
        oldWidget.progress != null &&
        oldWidget.progress != widget.progress) {
      _animation =
          Tween(begin: oldWidget.progress, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter:  widget.progress != null && widget.progress! > 0.0 ? _RoundProgressPainter(
          radius: widget.radius,
          progress: _animation.value,
          color: widget.color,
          animation: _animation,
          strokeWidth: widget.strokeWidth,
        ) : null,
        child: widget.child,
      );
  }
}

class _RoundProgressPainter extends CustomPainter {
  final double radius;
  final double progress;
  final Color color;
  final Animation<double> animation;
  final double strokeWidth;

  _RoundProgressPainter({
    required this.radius,
    required this.progress,
    required this.color,
    required this.animation,
    required this.strokeWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final strokeWidth = radius / 10;
    final progressAngle = math.pi * 2 * progress;
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.shortestSide / 2),
      -math.pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RoundProgressPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}
