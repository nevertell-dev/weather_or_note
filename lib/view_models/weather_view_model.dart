import 'package:flutter/material.dart';
import 'package:weather_or_note/repository/api_status.dart';
import 'package:weather_or_note/repository/weather_service.dart';
import 'package:collection/collection.dart';

import '../models/user_error.dart';
import '../models/weathers.dart';

// activeDay contains activeHour(s) for 3 hour forecast
// activeDay controlled by date picker
// activeHour controlled by slider, and set with onChangedEnd

class WeatherViewModel extends ChangeNotifier {
  bool _onLoading = false;
  Forecast? _forecast;
  List<Data> _activeDay = [];
  Data? _activeHour;
  DateTime _activeDate = DateTime.now();
  double _sliderValue = 0.0;
  UserError? _userError;

  bool get onLoading => _onLoading;
  Forecast? get forecast => _forecast;
  List<Data> get activeDay => _activeDay;
  Data? get activeHour => _activeHour;
  DateTime get activeDate => _activeDate;
  double get sliderValue => _sliderValue;
  UserError? get userError => _userError;

  WeatherViewModel() {
    getWeather();
  }

  setLoading(bool state) async {
    _onLoading = state;
    notifyListeners();
  }

  setWeather(Forecast forecast) {
    _forecast = forecast;
  }

  setActiveDay(DateTime date) {
    final unfilteredDays = forecast?.datas;

    if (unfilteredDays != null) {
      _activeDay = List<Data>.from(unfilteredDays.where((data) {
        return data.dt.month == date.month && data.dt.day == date.day;
      }));
    }

    setActiveHour();
  }

  setActiveHour() async {
    if (_activeDay.isNotEmpty) {
      final closestHours = _activeDay
          .where((day) => day.dt.hour <= _sliderValue)
          .map(((e) => e.dt.hour))
          .toList()
        ..sort();
      if (closestHours.isNotEmpty) {
        _activeHour = _activeDay
            .firstWhereOrNull((hour) => hour.dt.hour == closestHours.last);
      } else {
        _activeHour = _activeDay.first;
      }
    } else {
      _activeHour = null;
    }
    notifyListeners();
  }

  setActiveDate(DateTime date) {
    _activeDate = date;
    setActiveDay(date);
  }

  setSliderValue(double hour) {
    _sliderValue = hour;
    notifyListeners();
  }

  setUserError(UserError error) {
    _userError = error;
  }

  getWeather() async {
    setLoading(true);
    final response = await WeatherService.getWeather('pringsewu');
    if (response is Success) {
      setWeather(response.response as Forecast);
      setActiveDay(DateTime.now());
    }
    if (response is Failure) {
      var err = UserError(response.cod, response.errorResponse as String);
      setUserError(err);
    }
    setLoading(false);
  }
}
