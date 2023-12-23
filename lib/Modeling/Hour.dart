import 'Condition.dart';
class HourInfo {
  String time;
  double tempC;
  Condition condition;
  HourInfo({
    required this.time,
    required this.tempC,
    required this.condition,
  });
  factory HourInfo.fromJson(Map<String, dynamic> json) {
    return HourInfo(
      time: json['time'],
      tempC: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

