import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import '../Modeling/Weather.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';

class HourlyForecast extends StatefulWidget {
  final String searchText;

  HourlyForecast(this.searchText);

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}
class _HourlyForecastState extends State<HourlyForecast> {
  late  Future<List<Weather>>futureweather ;

  Future<List<Weather>> fetchData() async {

    List<Weather> WeatherList = [];

    try {
      final  response = await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=${widget.searchText}&days=3&aqi=no&alerts=no"));
      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        Weather weather = Weather.fromJson(data);
        WeatherList.add(weather);

      } else {
        // print('Failed to fetch data for $uri. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching data for $uri: $e');
    }


    return WeatherList  ;

  }
  @override
  void initState() {
    super.initState();
    futureweather=fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: FutureBuilder(
            future:futureweather,
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
                                                        Text(hour.time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.blue ),),
                                                        SizedBox(height: 20,),
                                                        Text('Temp : ${hour.tempC}°C', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ),
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    width:200 ,
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
                /*   return Container(
                      height: 120,
                      width: 120,
                      child: Card(
                          color: Colors.white60,
                          margin: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),),
                          elevation: 7,
                          child: Padding(
                              padding:  EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(weatherlist![index].location.cityName, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                                    FancyButton(button_text: "Daily Forecast ",
                                        button_height: 40,
                                        button_width: 150,
                                        button_radius: 50,
                                        button_color: Colors.blue,
                                        button_outline_color: Colors.blue,
                                        button_outline_width: 1,
                                        button_text_color: Colors.white,
                                        icon_size: 15,
                                        onClick: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>HoreForecastDetails(weather: weatherlist[index],),));


                                        }),



                                  ]
                              )
                          )
                      ),
                    );

                   */
                  },

                );
              }


              else if (snapshot.hasError)
                return Text('lllllll');
              else {
                return  Center(
                  child: CircularProgressIndicator(),
                );
              }
            },

          ),

        )
    );


  }
}

