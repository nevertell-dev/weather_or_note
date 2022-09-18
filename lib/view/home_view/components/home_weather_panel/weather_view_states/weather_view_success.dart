import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/weathers.dart';
import '../../../../../../view_models/weather_view_model.dart';

class WeatherViewSuccess extends StatelessWidget {
  const WeatherViewSuccess({
    Key? key,
  }) : super(key: key);

  TextStyle? headlineTextStyle({
    required Color color,
    required double size,
  }) {
    return GoogleFonts.rozhaOne().copyWith(
      color: color,
      fontSize: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Selector<WeatherViewModel, Data?>(
        selector: (_, weatherVM) => weatherVM.activeHour,
        builder: (context, activeData, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                child: Text(
                  context.select((WeatherViewModel weatherVM) =>
                      weatherVM.forecast?.city.name ?? ''),
                  textAlign: TextAlign.center,
                  style: headlineTextStyle(
                    color: theme.colorScheme.onPrimary,
                    size: 48,
                  ),
                ),
              ),
              Text(
                activeData?.weathers[0].description ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans().copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const Expanded(child: SizedBox.expand()),
              Text(
                activeData != null
                    ? '${activeData.main.temp.round().toString()}°'
                    : '',
                textAlign: TextAlign.right,
                style: headlineTextStyle(
                  color: theme.colorScheme.onSurface,
                  size: 48,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
