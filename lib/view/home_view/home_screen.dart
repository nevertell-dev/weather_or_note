import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view/home_view/components/home_control_panel/control_view.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_view_states/weather_view_error.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_view_states/weather_view_loading.dart';
import 'package:weather_or_note/view/home_view/components/home_weather_panel/weather_view_states/weather_view_success.dart';

import '../../view_models/weather_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _child(BuildContext context) {
    if (context.select((WeatherViewModel weatherVM) => weatherVM.onLoading)) {
      return const WeatherViewLoading();
    }

    if (context.select((WeatherViewModel weatherVM) => weatherVM.userError) !=
        null) {
      return const WeatherViewError();
    }

    return const WeatherViewSuccess();
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
                child: _child(context),
              ),
              const Expanded(
                flex: 1,
                child: ControlView(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
