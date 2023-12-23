
import 'Condition.dart';
import 'Current.dart';
import 'Days.dart';
import 'ForecastDay.dart';
import 'Hour.dart';
import 'location.dart';
import 'Forecast.dart';
class Weather {
 Location location;
  Current current;
  int cityid;
 Forecast forecast;


Weather({
  required this.location,
  required this.current,
 required this.forecast, this.cityid=0
});


  factory Weather.fromJson( dynamic json) {
return Weather(
location: Location.fromJson(json['location']),
current: Current.fromJson(json['current']),
  forecast: Forecast.fromJson(json['forecast']),

);
}

Map<String, dynamic> toMap() {
  return {
    'cityName': location.cityName,
    'country': location.country,
    'lat': location.lat,
    'temp_c': current.temp_c,
    'temp_f': current.temp_f,
    'wind_kph': current.wind_kph,
    'wind_dir': current.wind_dir,
    'condition_text': current.condition.ConitionText,
    'condition_icon': current.condition.img,
  };
}

   factory Weather.fromMap(Map<String, dynamic> map) {

    return Weather(
      location: Location(
        cityName: map['cityName'],
        country: map['country'],
        lat: map['lat'],
      ),
      current: Current(
        temp_c: map['temp_c'],
        temp_f: map['temp_f'],
        wind_kph: map['wind_kph'],
        wind_dir: map['wind_dir'],
        condition: Condition(
          ConitionText: map['condition_text'],
          img: map['condition_icon'],
        ),
      ),
     forecast: Forecast(forecastDays: [
     ForecastDay(date: "2023-12-21",
     dayInfo: Days(
     maxTempC: 30.0,
     minTempC: 20.0,
     condition: Condition(ConitionText: "Sunny", img: "sunny.png"), maxwind_kph:36.0, maxtemp_f:30.0, mintemp_f: 20.0,
     ),
     hourlyInfo: [
     HourInfo(time: "12:00 PM", tempC: 28.0, condition: Condition(ConitionText: "Partly Cloudy", img: "cloudy.png")),]
     ),
     ],
    ),
    );
  }

}










