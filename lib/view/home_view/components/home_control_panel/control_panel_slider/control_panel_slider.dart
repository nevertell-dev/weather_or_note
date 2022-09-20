import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view/home_view/components/home_control_panel/control_panel_slider/cp_slider_thumb_shape.dart';
import 'package:weather_or_note/view/home_view/components/home_control_panel/control_panel_slider/cp_slider_track_shape.dart';

import '../../../../../view_models/weather_view_model.dart';

class ControlPanelSlider extends StatelessWidget {
  const ControlPanelSlider({
    Key? key,
    required this.readWeatherVM,
  }) : super(key: key);

  final WeatherViewModel readWeatherVM;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData().copyWith(
        thumbShape: CpSliderThumbShape(context, 50.0),
        trackShape: CpSliderTrackShape(context),
      ),
      child: Slider(
        value: context.watch<WeatherViewModel>().sliderValue,
        min: 0.0,
        max: 24.0,
        divisions: 24,
        onChanged: (value) {
          readWeatherVM.setSliderValue(value);
        },
        onChangeEnd: (value) {
          readWeatherVM.setActiveHour();
        },
      ),
    );
  }
}
