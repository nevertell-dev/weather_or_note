import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourSliderThumbShape extends SliderComponentShape {
  HourSliderThumbShape({
    required this.buildContext,
    required this.thumbHeight,
    required this.thumbRadius,
    this.min = 0,
    this.max = 24,
  });

  final BuildContext buildContext;
  final double thumbHeight;
  final double thumbRadius;
  final int min;
  final int max;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbHeight, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Theme.of(buildContext).colorScheme.primaryContainer
      ..style = PaintingStyle.fill;

    final span = TextSpan(
      style: GoogleFonts.workSans().copyWith(
        fontSize: thumbRadius * .6,
        fontWeight: FontWeight.w700,
        color: Theme.of(buildContext)
            .colorScheme
            .primary, //Text Color of Value on Thumb
      ),
      text: '${getValue(value)}:00',
    );

    final tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    tp.layout();

    final textCenter = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tp.height / 2),
    );

    final rRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: center,
          width: thumbHeight * 1.5,
          height: thumbHeight,
        ),
        Radius.circular(thumbRadius));

    canvas.drawRRect(rRect, paint);

    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
