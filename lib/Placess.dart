import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather/Modeling/Weather.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  List<String> weatherList = [];



late  Future<List<Weather>> futureweather;
  Future<List<Weather>> fetchData() async {
    List<String> citiesListUri = [

      "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Jerusalem&aqi=no",
     "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Amman &aqi=no" ,
     "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Damascus&aqi=no",
     "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Beirut&aqi=no",
     "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Doha&aqi=no",
      "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Algeria&aqi=no",
      "http://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Kuwait&aqi=no",





    ];

    List<Weather> WeatherList = [];

    for (String uri in citiesListUri) {
      try {
        final response = await http.get(Uri.parse(uri));
        if (response.statusCode == 200) {

          var data = json.decode(response.body);
          Weather weather = Weather.fromJson(data);
          WeatherList.add(weather);
        } else {
          print('Failed to fetch data for $uri. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching data for $uri: $e');
      }

    }
    return  WeatherList;

  }
  @override
  void initState() {
    super.initState();
    futureweather=fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:futureweather,
      builder: (context, snapshot)
    {
      if (snapshot.hasData) {
        List <Weather>? weather = snapshot.data;
        return ListView.builder(
          itemCount: weather?.length,

          itemBuilder: (context, index) {
            return Card(
              color: Colors.white60,
              margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),

            ),
                elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(5.0),

                child:  Row

                  (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                [Text(weather![index].location.cityName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  Column(
                    children:
                    [
                      Row(
                        children: [
                       Text(weather[index].current.condition.ConitionText,style: TextStyle(fontSize: 17) ),
                        ],

                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [

                          Text(weather[index].current.temp.toString(),style: TextStyle(fontSize: 17) ),
                        ],

                      ),

                    ],
                  ),

                  Image.network('https:${weather[index].current.condition.img}', height: 120, width: 120,)
                ],
                )


              ),
            );
          },

        );
      }


      else if (snapshot.hasError)
        return Text('');
      else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },

    );


  }
}

