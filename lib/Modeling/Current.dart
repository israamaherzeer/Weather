import 'Condition.dart';
class Current {
   double temp_c;
   Condition condition;
   double wind_kph;
   String wind_dir;
   double temp_f;
  Current({
    required this.temp_c,
    required this.temp_f,
    required this.condition,
    required this.wind_kph,
    required this.wind_dir,
  });
  factory Current.fromJson(dynamic json) {
    return Current(
      wind_dir: json['wind_dir'],
      wind_kph: json['wind_kph'],
      temp_c: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
      temp_f:json['temp_f'],

    );
  }


  }


