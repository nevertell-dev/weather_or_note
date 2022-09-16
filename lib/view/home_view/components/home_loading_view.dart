import 'package:flutter/material.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({
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
