import 'Daysforecast.dart';
import 'HourlyForecast.dart';
class Forecast {
  List<ForecastDay> forecastDays;

  Forecast({required this.forecastDays});

  factory Forecast.fromJson(dynamic json) {
    List<dynamic> forecastDayList = json['forecastday'];
    List<ForecastDay> days = forecastDayList.map((day) => ForecastDay.fromJson(day)).toList();

    return Forecast(forecastDays: days);
  }
}

class ForecastDay {
  String date;
  DaysForecast dayInfo;
  List<HourInfo> hourlyInfo;

  ForecastDay({required this.date, required this.dayInfo, required this.hourlyInfo});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourList = json['hour'];
    List<HourInfo> hours =
    hourList.map((hour) => HourInfo.fromJson(hour)).toList();

    return ForecastDay(
      date: json['date'],
      dayInfo: DaysForecast.fromJson(json['day']),
      hourlyInfo: hours,
    );
  }
}
