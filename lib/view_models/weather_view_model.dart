import 'package:flutter/material.dart';
import 'package:weather_or_note/repository/api_status.dart';
import 'package:weather_or_note/repository/weather_service.dart';

import '../models/user_error.dart';
import '../models/weather.dart';

class WeatherViewModel extends ChangeNotifier {
  bool _onLoading = false;
  Weathers? _weathers;
  UserError? _userError;

  bool get onLoading => _onLoading;
  Weathers? get weathers => _weathers;
  UserError? get userError => _userError;

  WeatherViewModel() {
    getWeather();
  }

  setLoading(bool value) async {
    _onLoading = value;
    notifyListeners();
  }

  setWeather(Weathers value) {
    _weathers = value;
  }

  setUserError(UserError value) {
    _userError = value;
  }

  getWeather() async {
    setLoading(true);
    var response = await WeatherService.getWeather('pringsewu');
    if (response is Success) {
      setWeather(response.response as Weathers);
    }
    if (response is Failure) {
      var err = UserError(response.cod, response.errorResponse as String);
      setUserError(err);
    }
    // TODO: delete later
    await Future.delayed(const Duration(seconds: 5));
    setLoading(false);
  }
}
