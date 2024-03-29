import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view/home_view/components/home_control_panel/control_panel_slider/control_panel_slider.dart';

import '../../../../view_models/weather_view_model.dart';

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
      color: Theme.of(context).colorScheme.onBackground,
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
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                );
                if (pickedDate != null) {
                  readWeatherVM.setActiveDate(pickedDate);
                }
              },
              icon: FittedBox(
                child: Center(
                  child: Text(
                    DateFormat('d\nMM').format(activeDate),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rozhaOne().copyWith(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontSize: 48,
                      height: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: RotatedBox(
                quarterTurns: 3,
                child: ControlPanelSlider(readWeatherVM: readWeatherVM),
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
