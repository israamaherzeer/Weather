
import 'Current.dart';
import 'Cities.dart';
class Weather {

final Location location;
final Current current;

Weather({
  required this.location,
  required this.current,

});

factory Weather.fromJson( dynamic json) {
return Weather(
location: Location.fromJson(json['location']),
current: Current.fromJson(json['current']),

);
}
}










