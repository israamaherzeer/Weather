import 'ForecastDay.dart';
class Forecast {
  List<ForecastDay> forecastDays;

  Forecast({required this.forecastDays});

  factory Forecast.fromJson(dynamic json) {
    List<dynamic> forecastDayList = json['forecastday'];
    List<ForecastDay> forecastday= forecastDayList.map((day) => ForecastDay.fromJson(day)).toList();

    return Forecast(forecastDays:  forecastday);
  }
}


