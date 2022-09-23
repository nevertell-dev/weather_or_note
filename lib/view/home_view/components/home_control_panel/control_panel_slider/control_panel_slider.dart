import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class HourSlider extends LeafRenderObjectWidget {
  const HourSlider({
    super.key,
    required this.barColor,
    required this.thumbColor,
    required this.thumbSize,
    required this.min,
    required this.max,
  });

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;
  final double min;
  final double max;

  @override
  RenderHourSlider createRenderObject(BuildContext context) {
    return RenderHourSlider(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
      min: min,
      max: max,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderHourSlider renderObject) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize
      ..min = min
      ..max = max;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
    properties.add(DoubleProperty('min', min));
    properties.add(DoubleProperty('max', max));
  }
}

class RenderHourSlider extends RenderBox {
  RenderHourSlider({
    required barColor,
    required thumbColor,
    required thumbSize,
    required min,
    required max,
  })  : _barColor = barColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize,
        _min = min,
        _max = max {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = ((details) => _updateThumbPosition(details.localPosition))
      ..onUpdate = ((details) => _updateThumbPosition(details.localPosition));
  }

  Color _barColor;
  Color _thumbColor;
  double _thumbSize;
  double _currentThumbValue = 0.5;
  double _min;
  double _max;

  static const _minDesiredWidth = 144.0;

  late HorizontalDragGestureRecognizer _drag;

  Color get barColor => _barColor;
  set barColor(Color value) {
    if (_barColor == value) return;
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) return;
    _thumbColor = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) return;
    _thumbSize = value;
    markNeedsLayout();
  }

  double get min => _min;
  set min(double value) {
    if (_min == value) return;
    _min = value;
    markNeedsPaint();
  }

  double get max => _max;
  set max(double value) {
    if (_max == value) return;
    _max = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final barPaint = Paint()..color = barColor;
    final barRect = Rect.fromLTWH(0, 0, size.width, thumbSize);
    final barRRect =
        RRect.fromRectAndRadius(barRect, Radius.circular(size.height / 2));
    canvas.drawRRect(barRRect, barPaint);

    final spacing = (size.width - thumbSize / 2) / 24;

    for (var i = 1; i <= 24; i++) {
      final center = Offset(i * spacing, thumbSize / 2);
      var dotSize = thumbSize / 16;
      var dotPaint = Paint()..color = Colors.cyan;

      if (i % 3 == 0) {
        dotSize = thumbSize / 8;
        dotPaint = Paint()..color = Colors.red;
      }

      canvas.drawCircle(center, dotSize, dotPaint);
    }

    final thumbPaint = Paint()..color = thumbColor;
    final thumbDx = (_currentThumbValue * (size.width - thumbSize * 2));
    final center = Offset(thumbDx + thumbSize, size.height / 2);
    final thumbRect = Rect.fromCenter(
      center: center,
      width: thumbSize * 2,
      height: thumbSize,
    );
    final thumbRRect =
        RRect.fromRectAndRadius(thumbRect, Radius.circular(thumbSize / 2));
    canvas.drawRRect(thumbRRect, thumbPaint);

    final textSpan = TextSpan(
      text: getSliderValue().toStringAsFixed(2),
      style: const TextStyle(fontSize: 20.0),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset =
        Offset(thumbDx + thumbSize - (textPainter.width / 2), size.height / 4);

    textPainter.paint(canvas, textOffset);

    canvas.restore();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }

  void _updateThumbPosition(Offset localPosition) {
    var dx = localPosition.dx.clamp(0, size.width);
    var newThumbValue = (dx / size.width);
    if (_currentThumbValue == newThumbValue) return;
    _currentThumbValue = newThumbValue;
    // print('$dx / ${size.width} = $newThumbValue');
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  @override
  bool get isRepaintBoundary => true;

  double getSliderValue() {
    return _min + (_currentThumbValue * _max);
  }
}
