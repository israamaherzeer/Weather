
import 'package:flutter/material.dart';
import 'DaysInformation.dart';
import 'Modeling/Weather.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'Placess.dart';

class HoulyForecast extends StatefulWidget{


  @override
  State<HoulyForecast> createState() => _dailyForcasetState();
}

class _dailyForcasetState extends State<HoulyForecast> {

  late  Future<List<Weather>> futureweather;
  Future<List<Weather>> fetchData() async {
    List<String> citiesListUri = [
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Jerusalem&days=3&aqi=no&alerts=no",
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Amman&days=3&aqi=no&alerts=no" ,
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Damascus&days=3&aqi=no&alerts=no",
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Beirut&days=3&aqi=no&alerts=no",
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Doha&days=3&aqi=no&alerts=no",
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Algeria&days=3&aqi=no&alerts=no",
      "http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=Kuwait&days=3&aqi=no&alerts=no",
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
                      [
                        Text(weather![index].location.cityName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                        ElevatedButton(

                          onPressed: ()
                          {
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Daysinformation()));

                          },
                          child:Text('Hourly Forecast'),

                        )



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
