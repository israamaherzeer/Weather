
import 'Condition.dart';
class HourInfo {
  String time;
  double tempC;
  double tempF;
  Condition condition;

  HourInfo({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.condition,
  });

  factory HourInfo.fromJson(Map<String, dynamic> json) {
    return HourInfo(
      time: json['time'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

