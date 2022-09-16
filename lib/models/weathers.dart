import 'dart:convert';

Weathers weatherFromJson(String str) => Weathers.fromJson(jsonDecode(str));

class Weathers {
  Weathers({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.datas,
    required this.city,
  });

  final String cod;
  final int message;
  final int cnt;
  final List<Data> datas;
  final City city;

  factory Weathers.fromJson(Map<String, dynamic> json) => Weathers(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        datas: List<Data>.from(json["list"].map((x) => Data.fromJson(x))),
        city: City.fromJson(json["city"]),
      );
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );
}

class Data {
  Data({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.rain,
    required this.sys,
    required this.dtTxt,
  });

  final DateTime dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain? rain;
  final Sys sys;
  final DateTime dtTxt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dt: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000, isUtc: true),
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"].toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );
}

class Clouds {
  Clouds({
    required this.all,
  });

  final int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );
}

class Rain {
  Rain({
    required this.threeHours,
  });

  final double threeHours;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        threeHours: json["3h"].toDouble(),
      );
}

class Sys {
  Sys({
    required this.pod,
  });

  final String pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"],
      );
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double speed;
  final int deg;
  final double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
      );
}
