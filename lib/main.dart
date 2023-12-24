
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Savelist.dart';
import 'places.dart';
import 'Hourssearch.dart';
import 'Dayssearch.dart';
import 'dbprovider.dart';
void main() => runApp(  const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Weather App';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> DatabaseProvider.db,
      child:  MaterialApp(
        title: appTitle,
        home: MyHomePage(title: appTitle),
      )
      );

  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    Home(),
    places(),
    DailyForecast(),
    HourlyForecast(),

  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
      actions: [
        IconButton(
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Savecitylist ()));
            },
            icon: Icon(Icons.favorite)
        ),


      ],
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(

        child: ListView(

          padding: EdgeInsets.zero,

          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Weather App' , style : TextStyle(  fontSize: 30),),
            ),
            ListTile(
              title: const Text('Home',style: TextStyle(  fontSize: 20,fontWeight:FontWeight.bold ),      ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('Places',style: TextStyle(  fontSize: 20,fontWeight:FontWeight.bold ),),
              selected: _selectedIndex == 1,
              onTap: () {

                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),



            ListTile(
              title: const Text('Daily  Forecast',style: TextStyle(  fontSize: 20,fontWeight:FontWeight.bold ),),
              selected: _selectedIndex == 2,
              onTap: () {

                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),


            ListTile(
              title: const Text('Hourly Forecast' , style: TextStyle( fontSize: 20,fontWeight:FontWeight.bold ),),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);

                Navigator.pop(context);
              },
            ),



          ],
        ),
      ),
    );
  }
}

































