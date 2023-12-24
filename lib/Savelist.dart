import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weathercityitem.dart';
import 'Modeling/Weather.dart';
import 'dbprovider.dart';
class Savecitylist extends StatefulWidget {
  const Savecitylist({super.key});

  @override
  State<Savecitylist> createState() => _SavecitylistState();
}

class _SavecitylistState extends State<Savecitylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather List'),
          actions: [
          IconButton(
          onPressed: (){

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Do you want to delete all the List ?' , style: TextStyle(fontSize: 30),),
                    actions: [
                      ElevatedButton(
                          onPressed:(){
                  DatabaseProvider.db.removeAll();
                  setState(() {

                  });
                  Navigator.pop(context);
                  }
                  , child:Text('ok ')),
                    ]

                  );
                },);

  },
    icon: Icon(Icons.delete)
    )



    ],

      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, child) {
          return FutureBuilder<List<Weather>>(
            future: DatabaseProvider.db.getAlWeather(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                List<Weather> weatherList = snapshot.data!;
                if (weatherList!.isEmpty)
                  return Center(child: Text('No item in the List'),);
                return ListView.builder(
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    return weathercityitem(weather: weatherList[index]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {

                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
