
import 'package:flutter/material.dart';

import 'dart:convert';
import 'Hourlyforecast.dart';
import 'DailyForecast.dart';
import 'Placess.dart';
import 'package:http/http.dart' as http;
import 'Modeling/Weather.dart';
class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  late Future<Weather> cityfuture ;
  Future <Weather> getWeather ()async
  {
    http.Response response= await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=38afbeab0e714cf4a3f160606232911&q=Hevron&aqi=no",));
    if (response.statusCode==200)
    {
      var jsonobj = jsonDecode(response.body);
      Weather city = Weather.fromJson(jsonobj);

      return city;

    }
    else {
      throw
    Exception('can not access the ApI');

    }

  }
  @override void initState() {

    super.initState();
    cityfuture= getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cityfuture,
        builder: (context, snapshot)
        {

          if (snapshot.hasData) {
         Weather? weather= snapshot.data;
         return Center(
           child: Container(
             height:400,
             width: 400,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,

               children: [


                 Text('Hebron', style: TextStyle(fontSize:30 , fontWeight:FontWeight.bold ),),
                 Image.network('https:${weather!.current.condition.img}' ,height: 100, width: 100, ),
                 Text((weather.current.temp).toString(), style : TextStyle(fontSize:30 , fontWeight:FontWeight.bold )),
                 Text(weather.current.condition.ConitionText ,style : TextStyle(fontSize:30  ), ),



               ],
             ),
           ),
         );

        }
     else if  (snapshot.hasError)
         return Text('tt') ;

     else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
     },
    );




  }
}
