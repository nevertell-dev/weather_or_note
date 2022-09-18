import 'package:flutter/material.dart';

class HourSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  HourSliderTrackShape(this.buildContext);

  final BuildContext buildContext;

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      bool isEnabled = false,
      bool isDiscrete = false,
      required TextDirection textDirection}) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final thumbHeight =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete).width;

    final radius = Radius.circular(thumbHeight / 2);
    final verticalOffset = (thumbHeight / 1.8);
    final horizontalOffset = ((thumbHeight * 1.5) / 2);

    final rRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(
          trackRect.left - horizontalOffset,
          trackRect.top + verticalOffset,
          trackRect.right + horizontalOffset,
          trackRect.bottom - verticalOffset,
        ),
        radius);

    final paint = Paint()
      ..color = Theme.of(buildContext).colorScheme.onPrimaryContainer;

    context.canvas.drawRRect(rRect, paint);
  }
}
