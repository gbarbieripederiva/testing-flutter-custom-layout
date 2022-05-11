import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyCustomSlider extends LeafRenderObjectWidget {
  final num progress;
  final num maxWidth;
  final num lineThickness;
  final num dotRadius;
  final Color dotColor;
  final Color lineColor;
  final Color progressColor;

  const MyCustomSlider({
    required this.progress,
    this.maxWidth = 200,
    this.dotRadius = 10,
    this.lineThickness = 5,
    this.dotColor = const Color.fromARGB(255, 0, 0, 0),
    this.lineColor = const Color(0xff0000ff),
    this.progressColor = const Color.fromARGB(255, 255, 0, 0),
    Key? key,
  })  : assert(progress >= 0 && progress <= 100, 'progress should be a value between 0 and 100'),
        super(key: key);

  @override
  MyCustomSliderRenderObject createRenderObject(BuildContext context) => MyCustomSliderRenderObject(
        progress: progress,
        maxWidth: maxWidth,
        lineThickness: lineThickness,
        dotRadius: dotRadius,
        dotColor: dotColor,
        lineColor: lineColor,
        progressColor: progressColor,
      );

  @override
  void updateRenderObject(BuildContext context, MyCustomSliderRenderObject renderObject) {
    renderObject
      ..progress = progress
      ..maxWidth = maxWidth
      ..lineThickness = lineThickness
      ..dotRadius = dotRadius
      ..dotColor = dotColor
      ..lineColor = lineColor
      ..progressColor = progressColor;
  }
}

class MyCustomSliderRenderObject extends RenderBox {
  MyCustomSliderRenderObject({
    required num progress,
    required num maxWidth,
    required num lineThickness,
    required num dotRadius,
    required Color dotColor,
    required Color lineColor,
    required Color progressColor,
  })  : _progress = progress,
        _maxWidth = maxWidth,
        _lineThickness = lineThickness,
        _dotRadius = dotRadius,
        _dotColor = dotColor,
        _lineColor = lineColor,
        _progressColor = progressColor;

  num _progress;
  num get progress => _progress;
  set progress(num value) {
    if (_progress == value) {
      return;
    }
    _progress = value;
    markNeedsPaint();
  }

  num _maxWidth;
  num get maxWidth => _maxWidth;
  set maxWidth(num value) {
    if (_maxWidth == value) {
      return;
    }
    _maxWidth = value;
    markNeedsLayout();
  }

  num _lineThickness;
  num get lineThickness => _lineThickness;
  set lineThickness(num value) {
    if (_lineThickness == value) {
      return;
    }
    _lineThickness = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  num _dotRadius;
  num get dotRadius => _dotRadius;
  set dotRadius(num value) {
    if (_dotRadius == value) {
      return;
    }
    _dotRadius = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  Color _dotColor;
  Color get dotColor => _dotColor;
  set dotColor(Color value) {
    if (_dotColor == value) {
      return;
    }
    _dotColor = value;
    markNeedsPaint();
  }

  Color _lineColor;
  Color get lineColor => _lineColor;
  set lineColor(Color value) {
    if (_lineColor == value) {
      return;
    }
    _lineColor = value;
    markNeedsPaint();
  }

  Color _progressColor;
  Color get progressColor => _progressColor;
  set progressColor(Color value) {
    if (_progressColor == value) {
      return;
    }
    _progressColor = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final desiredWidth = math.min(constraints.maxWidth, maxWidth).toDouble();
    final desiredHeight = math.min(constraints.maxHeight, math.max(dotRadius, lineThickness)).toDouble();

    final desiredSize = Size(desiredWidth, desiredHeight);

    size = constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();

    canvas.translate(offset.dx, offset.dy);

    final progressPainter = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineThickness.toDouble();

    final linePainter = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineThickness.toDouble();

    final dotPainter = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = dotRadius.toDouble();

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      linePainter,
    );

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width * progress / 100, 0 + size.height / 2),
      progressPainter,
    );

    final pointDistance = size.width / 10;
    final startingOffset = Offset(0, size.height / 2);
    var points = <Offset>[];
    for (var i = 0; i < 11; i++) {
      points.add(startingOffset.translate(pointDistance * i, 0));
    }
    canvas.drawPoints(
      PointMode.points,
      points,
      dotPainter,
    );

    canvas.restore();
  }
}
