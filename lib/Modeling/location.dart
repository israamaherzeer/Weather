class Location {
  String cityName;
  double lat;
  String country;

  Location(
      { required this.cityName, required this.lat, required this.country });

  factory Location.fromJson(dynamic json){
    return Location(
      country: json['country'],
      cityName: json['name'],
      lat: json['lat'],
    );
  }

}





















