import 'package:flutter/material.dart';
import 'package:weather_or_note/repository/api_status.dart';
import 'package:weather_or_note/repository/weather_service.dart';
import 'package:collection/collection.dart';

import '../models/user_error.dart';
import '../models/weathers.dart';

class WeatherViewModel extends ChangeNotifier {
  var _onLoading = false;
  var _hourValue = 0.0;
  var _selectedDays = <Data>[];
  Data? _selectedHour;
  Weathers? _weathers;
  UserError? _userError;

  bool get onLoading => _onLoading;
  double get hourValue => _hourValue;
  Weathers? get weathers => _weathers;
  List<Data> get seletedDays => _selectedDays;
  Data? get selectedTime => _selectedHour;
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

  setSelectedDays(DateTime date) {
    final unfilteredDays = weathers?.datas;
    if (unfilteredDays != null) {
      _selectedDays = List<Data>.from(unfilteredDays.where((data) {
        return data.dt.day == date.day;
      }));
    }
    seletedDays.forEach((element) {
      print(element.dt.hour);
    });
    _selectedHour = seletedDays[0];
  }

  setSelectedTime() {
    if (_selectedDays.isNotEmpty) {
      final closestDay = _selectedDays
          .where((day) => day.dt.hour <= _hourValue)
          .map(((e) => e.dt.hour))
          .toList()
        ..sort();
      if (closestDay.isNotEmpty) {
        _selectedHour = _selectedDays
            .firstWhereOrNull((data) => data.dt.hour == closestDay.last);
      } else {
        _selectedHour = _selectedDays.first;
      }
    } else {
      _selectedHour = _selectedDays.first;
    }
    notifyListeners();
  }

  setTimeValue(double value) {
    _hourValue = value;
    notifyListeners();
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
    setSelectedDays(DateTime.now());
    setLoading(false);
  }
}
