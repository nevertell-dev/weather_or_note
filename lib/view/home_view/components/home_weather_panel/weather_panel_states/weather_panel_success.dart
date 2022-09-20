import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/weathers.dart';
import '../../../../../../view_models/weather_view_model.dart';

class WeatherPanelSuccess extends StatelessWidget {
  const WeatherPanelSuccess({
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

  String _getCity(BuildContext context) => context.select(
      (WeatherViewModel weatherVM) => weatherVM.forecast?.city.name ?? '');

  String _getDescription(Data? activeData) =>
      activeData != null ? activeData.weathers[0].description : '';

  String _getTemperature(Data? activeData) =>
      activeData != null ? '${activeData.main.temp.round().toString()}°' : '';

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
                  _getCity(context),
                  textAlign: TextAlign.center,
                  style: headlineTextStyle(
                    color: theme.colorScheme.onPrimary,
                    size: 48,
                  ),
                ),
              ),
              Text(
                _getDescription(activeData),
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans().copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const Expanded(child: SizedBox.expand()),
              Text(
                _getTemperature(activeData),
                textAlign: TextAlign.right,
                style: headlineTextStyle(
                  color: theme.colorScheme.onSurface,
                  size: 64,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
