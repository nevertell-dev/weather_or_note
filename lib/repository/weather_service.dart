import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_or_note/models/weather.dart';
import 'package:weather_or_note/repository/api_status.dart';

import '../utils/constant.dart';

class WeatherService {
  static Future<Object> getWeather(String location) async {
    try {
      var url = Uri.parse('$uri/forecast?q=$location&appid=$appid');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return Success("200", weatherFromJson(response.body));
      }

      return Failure("100", 'invalid response');
    } on HttpException {
      return Failure("101", 'no internet');
    } on FormatException {
      return Failure("102", 'invalid format');
    } catch (e) {
      return Failure('103', 'unknown error');
    }
  }
}
