import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weathercityitem.dart';
import 'Modeling/Weather.dart';

import 'package:http/http.dart'as http;

class places extends StatefulWidget {
  @override
  _placesState createState() => _placesState();
}

class _placesState extends State<places> {
   TextEditingController _searchController = TextEditingController();
  List<Weather> weatherList = [];
  late Future<List<Weather>> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather=fetchData('cityName');
  }

  Future<List<Weather>> fetchData(String cityName) async {

      final response = await http.get(Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=$cityName&days=3&aqi=no&alerts=no"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Weather weather = Weather.fromJson(data);
        weatherList.add(weather);
      }
    return weatherList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/m5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter City Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.2),
                  ),
                ),
               onSubmitted: (value) {
                  setState(() {
                    futureWeather = fetchData(value);
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Weather>? weather = snapshot.data;
                    return ListView.builder(
                      itemCount: weather?.length,
                      itemBuilder: (context, index) {
                        return weathercityitem(weather: weather![index]);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('error ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
