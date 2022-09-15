import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_or_note/view_models/weather_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

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
      return const Center(
        child: SizedBox(
            height: 100.0,
            width: 100.0,
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
            )),
      );
    }

    if (weatherViewModel.userError != null) {
      return Center(child: Text(weatherViewModel.userError!.message));
    }

    return Center(child: Text(weatherViewModel.weathers!.city.name));
  }
}
