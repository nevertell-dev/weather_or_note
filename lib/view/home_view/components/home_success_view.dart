import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/weathers.dart';
import '../../../view_models/weather_view_model.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/WeatherIllustration.png',
            fit: BoxFit.cover,
          ),
          Row(
            children: const [
              Expanded(
                flex: 3,
                child: WeatherPanel(),
              ),
              Expanded(
                flex: 1,
                child: ControlPanel(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherPanel extends StatelessWidget {
  const WeatherPanel({
    Key? key,
  }) : super(key: key);

  TextStyle? headlineTextStyle(ThemeData theme, Color color) =>
      theme.textTheme.headline1?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Selector<WeatherViewModel, Data?>(
        selector: (_, weatherVM) => weatherVM.activeData,
        builder: (context, activeData, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                child: Text(
                  context.select((WeatherViewModel weatherVM) =>
                      weatherVM.forecast?.city.name ?? ''),
                  textAlign: TextAlign.center,
                  style: headlineTextStyle(theme, theme.colorScheme.background),
                ),
              ),
              Text(
                activeData?.weathers[0].description ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.background,
                ),
              ),
              const Expanded(child: SizedBox.expand()),
              Text(
                activeData?.main.temp.round().toString() ?? '',
                textAlign: TextAlign.right,
                style: headlineTextStyle(theme, theme.colorScheme.onSurface),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ControlPanel extends StatelessWidget {
  const ControlPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeDate =
        context.select((WeatherViewModel weatherVM) => weatherVM.activeDate);
    final readWeatherVM = context.read<WeatherViewModel>();
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 96.0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ),
          SizedBox.square(
            dimension: 96.0,
            child: IconButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: activeDate,
                  firstDate: DateTime(activeDate.year),
                  lastDate: DateTime(activeDate.year + 1),
                );
                if (pickedDate != null) {
                  readWeatherVM.setActiveDate(pickedDate);
                }
              },
              icon: Center(
                child: Text(
                  DateFormat('d\nMM').format(activeDate),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          Expanded(
            child: RotatedBox(
              quarterTurns: 1,
              child: Slider(
                value: context.watch<WeatherViewModel>().activeHour,
                min: 0.0,
                max: 24.0,
                divisions: 24,
                onChanged: (value) {
                  readWeatherVM.setActiveHour(value);
                },
                onChangeEnd: (value) {
                  readWeatherVM.setActiveData();
                },
              ),
            ),
          ),
          SizedBox.square(
            dimension: 96.0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
    );
  }
}
