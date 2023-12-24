import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Modeling/Weather.dart';
import 'package:http/http.dart'as http;

class HourlyForecast extends StatefulWidget {
  @override
  _HourlyForecastState createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Weather>> futureWeather;

  Future<List<Weather>> fetchData(String cityName) async {

    List<Weather> WeatherList = [];

    try {
      final  response = await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=${cityName}&days=3&aqi=no&alerts=no"));
      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        Weather weather = Weather.fromJson(data);
        WeatherList.add(weather);

      } else {
         print('Failed to fetch data for ${cityName}uri. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching data for $uri: $e');
    }


    return WeatherList  ;

  }


  @override
  void initState() {
    super.initState();
    futureWeather=fetchData('cityname');
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
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
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
              Expanded(


              child : FutureBuilder(
                  future:futureWeather,
                  builder: (context, snapshot)
                  {
                    if (snapshot.hasData) {
                      List <Weather>?weatherlist = snapshot.data;
                      return ListView.builder(
                        itemCount:weatherlist?.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(' ${weatherlist![index].location.cityName}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                  for (var forecastDay in weatherlist![index].forecast.forecastDays!)
                                    Card(
                                      color: Colors.white60,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 7,
                                      child: Column(
                                        children: [
                                          //  hourly forecast for each day
                                          ExpansionTile(

                                            title: Text(forecastDay.date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                            children: [
                                              for (var hour in forecastDay.hourlyInfo)
                                                Card(
                                                  color: Colors.white10,
                                                  margin: EdgeInsets.symmetric(vertical: 8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),

                                                  child: Padding(
                                                    padding: EdgeInsets.all(3),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 150,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text(hour.time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                                                              SizedBox(height: 20,),
                                                              Text('Temp : ${hour.tempC}°C', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ),
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                          width:150 ,
                                                          child: Column(
                                                            children: [
                                                              Image.network('https:${hour.condition.img}', height: 100, width: 100,),
                                                              Text(' ${hour.condition.ConitionText}', style: TextStyle(fontSize: 20) , softWrap: true,),
                                                            ],
                                                          ),
                                                        ),



                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );

                        },

                      );
                    }


                    else if (snapshot.hasError)
                      return Text('error ${snapshot.error}');
                    else {
                      return  Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },

                ),






              ),
            ],
          ),
        ),
      ),
    );
  }
}




