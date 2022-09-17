import 'package:flutter/material.dart';

import 'package:weather_or_note/view/home_view/components/home_success_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeSuccessView(),
    );
  }
}
