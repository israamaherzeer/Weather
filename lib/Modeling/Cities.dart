

class Location

{
  String cityName;

  Location({ required this.cityName});

  factory Location.fromJson(dynamic json){
    return Location(
      cityName: json['name'],

    );
  }

}
























