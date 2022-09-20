import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view/home_view/components/home_control_panel/control_panel.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_panel_states/weather_panel_error.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_panel_states/weather_panel_loading.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_panel_states/weather_panel_success.dart';

import '../../view_models/weather_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _getWeatherPanel(BuildContext context) {
    if (context.select((WeatherViewModel weatherVM) => weatherVM.onLoading)) {
      return const WeatherPanelLoading();
    }

    if (context.select((WeatherViewModel weatherVM) => weatherVM.userError) !=
        null) {
      return const WeatherPanelError();
    }

    return const WeatherPanelSuccess();
  }

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
            children: [
              Expanded(
                flex: 3,
                child: _getWeatherPanel(context),
              ),
              const Expanded(
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
