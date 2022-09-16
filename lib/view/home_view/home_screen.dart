import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view/home_view/components/home_error_view.dart';
import 'package:weather_or_note/view/home_view/components/home_success_view.dart';

import '../../view_models/weather_view_model.dart';
import 'components/home_loading_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherViewModel weatherViewModel = context.watch<WeatherViewModel>();
    return Scaffold(
      body: Container(
        child: _child(weatherViewModel),
      ),
    );
  }

  _child(WeatherViewModel weatherViewModel) {
    if (weatherViewModel.onLoading) {
      return const HomeLoadingView();
    }

    if (weatherViewModel.userError != null) {
      return const HomeErrorView();
    }

    return const HomeSuccessView();
  }
}
