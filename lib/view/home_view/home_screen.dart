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
    return Scaffold(
      body: Container(
        child: _child(context),
      ),
    );
  }

  _child(BuildContext context) {
    if (context.select((WeatherViewModel weatherVM) => weatherVM.onLoading)) {
      return const HomeLoadingView();
    }

    if (context.select((WeatherViewModel weatherVM) => weatherVM.userError) !=
        null) {
      return const HomeErrorView();
    }

    return const HomeSuccessView();
  }
}
