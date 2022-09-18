import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/weather_view_model.dart';

class WeatherViewError extends StatelessWidget {
  const WeatherViewError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = context.read<WeatherViewModel>();
    return Center(child: Text(weatherViewModel.userError!.message));
  }
}
