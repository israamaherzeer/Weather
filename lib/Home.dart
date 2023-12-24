import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Modeling/Weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late Future<Weather> cityfuture ;
  final TextEditingController _cityController = TextEditingController();
   String cityName = 'jerusalem';
  Future<Weather> getWeather(String cityName) async
  {




    http.Response response= await http.get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=38afbeab0e714cf4a3f160606232911&q=${cityName}&days=3&aqi=no&alerts=no",));
    if (response.statusCode==200)
    {
      var jsonobj = jsonDecode(response.body);
      Weather city = Weather.fromJson(jsonobj);
      return city;
    }
    else {
      throw Exception('Unable to access API. Please check your internet connection and try again');

    }

  }

  void _saveCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', cityName);
  }

  void _loadCity() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString('city') ?? cityName;
    setState(() {
      cityName = savedCity;
      cityfuture = getWeather(savedCity);
    });
  }




  @override void initState() {

    super.initState();
    _loadCity();

  }

  void _showCityInput() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _CityInputSheet(),
    );
  }

  void _fetchWeatherForNewCity() async {
    cityName = _cityController.text;
    setState(() {
      cityfuture = getWeather(cityName);

      _saveCity(cityName);
    });

  }
  Widget _CityInputSheet() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter City Name',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _fetchWeatherForNewCity();
            },
            child: Text('Get Weather'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: cityfuture,
          builder: (context, snapshot)
          {
            if (snapshot.hasData) {
           Weather? weather= snapshot.data;
           return Container(
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image:AssetImage('assets/images/m2.jpg'),
                     fit: BoxFit.cover,
                   ),
                 ),
               child: Center(
                 child: Container(
                   height:400,
                   width: 400,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Text(weather!.location.cityName, style: TextStyle(fontSize:50 , fontWeight:FontWeight.bold ),),
                       Image.network('https:${weather!.current.condition.img}' ,height: 150, width: 150,  ),
                       Text('${weather.current.temp_c}°C ', style : TextStyle(fontSize:30 , fontWeight:FontWeight.bold )),

                       Text(weather.current.condition.ConitionText ,style : TextStyle(fontSize:20 ,fontWeight:FontWeight.bold ),softWrap: true  ),

                       FloatingActionButton(
                          hoverColor: Colors.white,
                         backgroundColor: Colors.white,

                         onPressed: ()
                         {
                           _showCityInput();
                         },


                         child: Icon(Icons.edit_location),
                       ),
                     ],
                   ),
                 )
               ),
             )  ;}
       else if  (snapshot.hasError)
           return Text('error ${snapshot.error}') ;
       else {return const Center(child: CircularProgressIndicator(),);}
       },
    );





  }
}
