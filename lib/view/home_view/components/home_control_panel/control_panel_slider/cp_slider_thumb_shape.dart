import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CpSliderThumbShape extends SliderComponentShape {
  CpSliderThumbShape(
    this.buildContext,
    this.thumbHeight, {
    this.min = 0,
    this.max = 24,
  });

  final BuildContext buildContext;
  final double thumbHeight;
  final int min;
  final int max;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbHeight * 2, thumbHeight);
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

    final hour = getValue(value);

    final textSpan = TextSpan(
      text: '${hour < 10 ? '0$hour' : '$hour'}:00',
      style: GoogleFonts.workSans().copyWith(
        fontSize: thumbHeight / 2 * .6,
        fontWeight: FontWeight.w700,
        color: Theme.of(buildContext)
            .colorScheme
            .primary, //Text Color of Value on Thumb
      ),
    );
    final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();

    final textCenter = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: thumbHeight * 2,
        height: thumbHeight,
      ),
      Radius.circular(thumbHeight / 2),
    );

    canvas.drawRRect(rRect, paint);

    textPainter.paint(canvas, textCenter);
  }

  int getValue(double value) {
    return (min + (max - min) * value).round();
  }
}
