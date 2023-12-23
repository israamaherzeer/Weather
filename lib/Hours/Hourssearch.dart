import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Hourlyforecast.dart';
class Hourssearch extends StatefulWidget {
  @override
  State<Hourssearch> createState() => _HourssearchState();
}
class _HourssearchState extends State<Hourssearch> {
  String searchText= '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:EdgeInsets.all(30) ,
        child: TextField(
          decoration: InputDecoration(
              labelText: 'search',
              hintText: 'Enter City Name ',
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.2),
              )),
          onSubmitted: (value ){
            Navigator.push(context,MaterialPageRoute(builder:(context)=>HourlyForecast(value)));
          },
        ),


      ),

    );
  }
}