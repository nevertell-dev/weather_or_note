import 'package:flutter/material.dart';
import 'package:weather_or_note/repository/api_status.dart';
import 'package:weather_or_note/repository/weather_service.dart';
import 'package:collection/collection.dart';

import '../models/user_error.dart';
import '../models/weathers.dart';

// Forecast => List of Day => List of Hour

class WeatherViewModel extends ChangeNotifier {
  bool _onLoading = false;
  Forecast? _forecast;
  List<Data> _activeDayData = [];
  Data? _activeHourData;
  DateTime _activeDate = DateTime.now();
  double _sliderValue = 0.0;
  UserError? _userError;

  bool get onLoading => _onLoading;
  Forecast? get forecast => _forecast;
  List<Data> get activeDayData => _activeDayData;
  Data? get activeHourData => _activeHourData;
  DateTime get activeDate => _activeDate;
  double get sliderValue => _sliderValue;
  UserError? get userError => _userError;

  WeatherViewModel() {
    getWeather();
  }

  void setLoading(bool state) async {
    _onLoading = state;
    notifyListeners();
  }

  void setForecastData(Forecast forecast) {
    _forecast = forecast;
  }

  // ActiveDate is a reference for calculating activeDayDatas
  void setActiveDate(DateTime date) {
    _activeDate = date;
    setActiveDayData();
  }

  // activeDayData is forecast filtered on specific day
  // it's contain list of hourly weather data
  void setActiveDayData() {
    if (_activeDate.difference(DateTime.now()).inDays == 0) {
      _sliderValue = DateTime.now().hour.toDouble();
    }

    final unfilteredDays = forecast?.datas;

    if (unfilteredDays != null) {
      _activeDayData = List<Data>.from(unfilteredDays.where((data) {
        return data.dt.year == _activeDate.year &&
            data.dt.month == _activeDate.month &&
            data.dt.day == _activeDate.day;
      }));
    }

    setActiveHourData();
  }

  // SliderValue is a reference for calculating activeHourData
  void setSliderValue(double hour) {
    _sliderValue = hour;
    notifyListeners();
  }

  // activeHourData is activeDayDatas filtered on specific hour
  // it's contain a weather data
  void setActiveHourData() async {
    if (_activeDayData.isNotEmpty) {
      final closestHours = _activeDayData
        ..sort((a, b) => ((a.dt.hour - _sliderValue).abs())
            .compareTo((b.dt.hour - _sliderValue).abs()));
      _activeHourData = closestHours.firstOrNull;
    } else {
      _activeHourData = null;
    }

    notifyListeners();
  }

  void setUserError(UserError error) {
    _userError = error;
  }

  void getWeather() async {
    setLoading(true);
    final response = await WeatherService.getWeather('pringsewu');
    if (response is Success) {
      setForecastData(response.response as Forecast);
      setActiveDate(DateTime.now());
    }
    if (response is Failure) {
      var err = UserError(response.cod, response.errorResponse as String);
      setUserError(err);
    }
    setLoading(false);
  }
}
