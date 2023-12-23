import 'Days.dart';
import 'Hour.dart';

class ForecastDay {
  String date;
  Days dayInfo;
  List<HourInfo> hourlyInfo;
  ForecastDay({required this.date,
    required this.dayInfo,
    required this.hourlyInfo ,
    });
  factory ForecastDay.fromJson(dynamic json) {
    List<dynamic> hourList = json['hour'];
    List<HourInfo> hours = hourList.map((hour) => HourInfo.fromJson(hour)).toList();
    return ForecastDay(
      date: json['date'],
      dayInfo: Days.fromJson(json['day']),
      hourlyInfo: hours,
    );
  }
}
