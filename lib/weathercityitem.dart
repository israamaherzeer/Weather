import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Modeling/Weather.dart';
import 'dbprovider.dart';
class weathercityitem extends StatefulWidget {
  final Weather weather;
  weathercityitem({ required this.weather});
  @override
  State<weathercityitem> createState() => _weathercityitemState();
}
class _weathercityitemState extends State<weathercityitem> {
   bool exists = true;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      width: 200,
      child: Card(
        color: Colors.white60,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child:
        Padding(
             padding: const EdgeInsets.all(7),
            child:  Row
              (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(

                      children: [
                        Text(widget.weather!.location.cityName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),

                      ],



                    ),

                    FancyButton(button_text: "Details ",
                        button_height: 40,
                        button_width: 100,
                        button_radius: 50,
                        button_color: Colors.blue,
                        button_outline_color: Colors.blue,
                        button_outline_width: 1,
                        button_text_color: Colors.white,
                        icon_size: 15,
                        onClick: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:  Text('${widget.weather.location.cityName}',style: TextStyle(fontSize: 22.0, color: Colors.indigo),),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    Text('${widget.weather.location.cityName}  _  ${widget.weather.location.country} \n', style: TextStyle(fontSize: 20), softWrap: true, ),
                                    Text('The  temperature in degrees Fahrenheit is ${widget.weather.current.temp_f } f\n', style: TextStyle(fontSize: 20), softWrap: true, ),
                                    Text ('The wind speed  is ${widget.weather.current.wind_kph}kph and the wind direction is ${widget.weather.current.wind_dir} ', style: TextStyle(fontSize: 20), softWrap: true,),


                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('cancel'),
                                ),
                              ],
                            ),
                          );
                        }






                    )
                  ],
                ),
                Column(
                  children:
                  [
                    Image.network('https:${widget.weather.current.condition.img}', height: 100, width: 150,),
                    Row(
                      children: [
                        Text(' Temp :${widget.weather.current.temp_c.toString()}°C ' ,style: TextStyle(fontSize: 20) ),
                      ],

                    ),
                    Row(
                      children: [
                        Text(widget.weather.current.condition.ConitionText,style: TextStyle(fontSize: 20), softWrap: true, ),
                      ],

                    ),

                  ],
                ),



                    IconButton(
                      onPressed: ()  async{
                        bool exists = await DatabaseProvider.db.isWeatherItemExist( widget.weather);
                        if (exists) {
                          context.read<DatabaseProvider>().removeWeather(widget.weather);
                        } else {
                          context.read<DatabaseProvider>().insertweather(widget.weather);
                        }

                        setState(() {

                        });
                      },

    icon: Consumer<DatabaseProvider> (
      builder: (context, value, child) {
       return FutureBuilder<bool>(
            future: context.watch<DatabaseProvider>().isWeatherItemExist(widget.weather),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              else if (snapshot.hasData) {
                return Transform.rotate(
                  angle: 90 * 3.1415927 / 180,
                  child: Icon(
                    snapshot.data ?? false ? Icons.label: Icons.label_outline,
                    size: 50,
                  ),
                );
              }
              else  {
                return CircularProgressIndicator(); // or any other loading indicator
              }
            }
        );
      },

    )),

                  ],



            )

                      ),
                    ),
                  );


  }
}
