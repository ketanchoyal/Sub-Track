import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sub_track/ui/shared/shared.dart';

class STRemainingDaysWidget extends StatefulWidget {
  final String remainigDays;
  final double? percent;
  final Color? color;

  STRemainingDaysWidget({
    required this.remainigDays,
    this.percent,
    this.color = Colors.white,
  });

  @override
  State createState() => _STRemainingDaysWidgetState();
}

class _STRemainingDaysWidgetState extends State<STRemainingDaysWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2400));

    _controller.addListener(() {
      setState(() {});
    });

    _controller.animateTo(widget.percent ?? 1.0);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(STRemainingDaysWidget oldWidget) {
    if (widget.percent == null) {
      _controller.animateTo(1.0);
    }
    if (oldWidget.percent != widget.percent) {
      _controller.animateTo(widget.percent ?? 1.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3,
        shape: kRoundedCardBorder(radius: 50),
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              isComplex: false,
              painter: _STRemaningDaysPainter(_controller.value, widget.color!),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Center(
                  child: Text(
                    widget.remainigDays,
                    style: kSmallStyle.copyWith(
                      fontWeight: FontWeightX.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _STRemaningDaysPainter extends CustomPainter {
  final double percent;
  final Color color;

  _STRemaningDaysPainter(
    this.percent,
    this.color,
  );

  @override
  void paint(canvas, size) {
    final paint = Paint();
    paint.color = Colors.transparent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), 0, math.pi * 2,
        false, paint);
    paint.color = color;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), -math.pi / 2,
        -2 * math.pi * percent, false, paint);
  }

  @override
  bool shouldRepaint(_STRemaningDaysPainter oldCategory) {
    return percent != oldCategory.percent || color != oldCategory.color;
  }
}
