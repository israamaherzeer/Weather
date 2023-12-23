import 'Condition.dart';
class Days {
  double maxTempC;
  double minTempC;
  Condition condition;
  double maxtemp_f;
  double mintemp_f;
  double maxwind_kph;
  Days({
    required this.maxTempC,
    required this.minTempC,
  required this.condition,
  required this.maxwind_kph,
    required this.maxtemp_f,
    required this.mintemp_f,
  });
  factory Days.fromJson(Map<String, dynamic> json) {
    return Days(
      maxwind_kph: json['maxwind_kph'],
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      maxtemp_f: json['maxtemp_f'],
      mintemp_f: json['mintemp_f'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}


