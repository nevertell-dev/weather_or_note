import 'package:flutter/material.dart';

class WeatherPanelLoading extends StatelessWidget {
  const WeatherPanelLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: CircularProgressIndicator(
            strokeWidth: 10.0,
          )),
    );
  }
}
