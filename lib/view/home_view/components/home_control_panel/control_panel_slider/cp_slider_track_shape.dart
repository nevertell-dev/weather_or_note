import 'package:flutter/material.dart';

class CpSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  CpSliderTrackShape(this.buildContext);

  final BuildContext buildContext;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Canvas canvas = context.canvas;

    final thumbSize =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete);

    final radius = Radius.circular(thumbSize.height / 2);

    final rRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx,
          offset.dy + (parentBox.size.height / 2) - (thumbSize.height / 2),
          parentBox.size.width,
          thumbSize.height,
        ),
        radius);

    final paint = Paint()
      ..color = Theme.of(buildContext).colorScheme.onPrimaryContainer;

    canvas.drawRRect(rRect, paint);
  }
}
