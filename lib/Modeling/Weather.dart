
import 'Current.dart';
import 'Cities.dart';

import 'Forecast.dart';
class Weather {

final Location location;
final Current current;
final Forecast forecast;

Weather({
  required this.location,
  required this.current,
 required this.forecast

});

factory Weather.fromJson( dynamic json) {
return Weather(
location: Location.fromJson(json['location']),
current: Current.fromJson(json['current']),
  forecast: Forecast.fromJson(json['forecast']),

);
}
}










