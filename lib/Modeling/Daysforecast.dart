import 'Condition.dart';
class DaysForecast {
  double maxTempC;
  double minTempC;
  Condition condition;

  DaysForecast({
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
  });

  factory DaysForecast.fromJson(Map<String, dynamic> json) {
    return DaysForecast(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}


