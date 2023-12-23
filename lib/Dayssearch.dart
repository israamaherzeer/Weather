import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Modeling/Weather.dart';
import 'package:http/http.dart'as http;

class DailyForecast extends StatefulWidget {
  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Weather>> futureWeather;

  Future<List<Weather>> fetchData(String cityName) async {


    List<Weather> WeatherList = [];


      final  response = await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=${cityName}&days=3&aqi=no&alerts=no"));
      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        Weather weather = Weather.fromJson(data);
        WeatherList.add(weather);

      } else {
        // print('Failed to fetch data for $uri. Status code: ${response.statusCode}');
      }

    return WeatherList  ;

  }
  @override
  void initState() {
    super.initState();
    futureWeather=fetchData('cityName');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              child: FutureBuilder(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Weather>? weatherList = snapshot.data;
                    return ListView.builder(
                      itemCount: weatherList?.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Column(
                              children: [
                                Text(
                                  '${weatherList![index].location.cityName}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                for (var forecastDay in weatherList[index].forecast.forecastDays!)
                                  Container(
                                    height: 200,
                                    width: 400,
                                    child: Card(
                                        color: Colors.white10,
                                        margin: EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),


                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width:150,
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children:
                                                    [
                                                      Text('Date: ${forecastDay.date}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                      Text('Max Temp: ${forecastDay.dayInfo.maxTempC}°C', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold  )),
                                                      Text('Min Temp: ${forecastDay.dayInfo.minTempC}°C', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ), ),
                                                    ]
                                                ),
                                              ),

                                              Container(
                                                width: 150,
                                                child: Column(
                                                  children: [
                                                    Image.network('https:${forecastDay.dayInfo.condition.img}', height: 100, width: 100,),
                                                    Text(' ${forecastDay.dayInfo.condition.ConitionText}', style: TextStyle(fontSize: 20) , softWrap: true,),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error fetching weather');
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
