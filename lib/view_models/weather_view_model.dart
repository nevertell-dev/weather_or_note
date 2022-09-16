import 'package:flutter/material.dart';
import 'package:weather_or_note/repository/api_status.dart';
import 'package:weather_or_note/repository/weather_service.dart';
import 'package:collection/collection.dart';

import '../models/user_error.dart';
import '../models/weathers.dart';

class WeatherViewModel extends ChangeNotifier {
  bool _onLoading = false;
  Forecast? _forecast;
  List<Data> _activeDatas = [];
  Data? _activeData;
  double _activeHour = 0.0;
  UserError? _userError;

  bool get onLoading => _onLoading;
  Forecast? get forecast => _forecast;
  List<Data> get activeDatas => _activeDatas;
  Data? get activeData => _activeData;
  double get activeHour => _activeHour;
  UserError? get userError => _userError;

  WeatherViewModel() {
    getWeather();
  }

  setLoading(bool value) async {
    _onLoading = value;
    notifyListeners();
  }

  setWeather(Forecast value) {
    _forecast = value;
  }

  setActiveDatas(DateTime date) {
    final unfilteredDays = forecast?.datas;
    if (unfilteredDays != null) {
      _activeDatas = List<Data>.from(unfilteredDays.where((data) {
        return data.dt.day == date.day;
      }));
    }
    _activeData = activeDatas[0];
  }

  setActiveData() {
    if (_activeDatas.isNotEmpty) {
      final closestDay = _activeDatas
          .where((day) => day.dt.hour <= _activeHour)
          .map(((e) => e.dt.hour))
          .toList()
        ..sort();
      if (closestDay.isNotEmpty) {
        _activeData = _activeDatas
            .firstWhereOrNull((data) => data.dt.hour == closestDay.last);
      } else {
        _activeData = _activeDatas.first;
      }
    } else {
      _activeData = _activeDatas.first;
    }
    notifyListeners();
  }

  setActiveHour(double value) {
    _activeHour = value;
    notifyListeners();
  }

  setUserError(UserError value) {
    _userError = value;
  }

  getWeather() async {
    setLoading(true);
    final response = await WeatherService.getWeather('pringsewu');
    if (response is Success) {
      setWeather(response.response as Forecast);
      setActiveDatas(DateTime.now());
    }
    if (response is Failure) {
      var err = UserError(response.cod, response.errorResponse as String);
      setUserError(err);
    }
    setLoading(false);
  }
}
