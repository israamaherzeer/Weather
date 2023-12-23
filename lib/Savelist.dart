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
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Savecitylist ()));
        DatabaseProvider.db.removeAll();
  },
    icon: Icon(Icons.delete)
    )
    ],

      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, _) {
          return FutureBuilder<List<Weather>>(
            future: DatabaseProvider.db.getAlWeather(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List<Weather> weatherList = snapshot.data!;
                return ListView.builder(
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    return weathercityitem(weather: weatherList[index]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Remove the unintended code block and return the CircularProgressIndicator
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
