import 'package:flutter/cupertino.dart';

import 'package:sqflite/sqflite.dart';
import 'package:weather/Modeling/Weather.dart';
class DatabaseProvider  extends ChangeNotifier {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static int version = 6;
  final String tableName = 'weathertabel';
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'cityweather.db';
    return await openDatabase(
      path,
      version: version,
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion)
          db.execute('DROP TABEL IF EXISTS  weathertabel');
        _creattabel(db, version);
      },
      onCreate: _creattabel,

    );
  }

  void _creattabel(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE weathertabel (
        cityid INTEGER PRIMARY KEY AUTOINCREMENT,
        cityName TEXT,
        country TEXT,
        lat REAL,
        temp_c REAL,
        temp_f REAL,
        wind_kph REAL,
        wind_dir TEXT,
        condition_text TEXT,
        condition_icon TEXT
      )
    ''');
  }



  Future<bool> isWeatherItemExist(Weather weather) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query('weathertabel', where: 'cityName = ? ', whereArgs: [weather.location.cityName]);
    return results.isNotEmpty;

  }


  Future<void> insertweather(Weather weather) async {
      final db = await database;
    await db.insert(tableName, weather.toMap());
      notifyListeners();
    }


    Future<List<Weather>> getAlWeather() async {
      final db = await database;
      List<Map<String, dynamic>> results = await db.query(tableName);
      List<Weather> weatherlist = [];
      for (var element in results) {
        Weather weather = Weather.fromMap(element);
        weatherlist.add(weather);
      }
      return weatherlist ;
    }

    Future<void> removeAll() async {
      final db = await database;
    await db.delete(tableName);
      notifyListeners();
    }

  Future<void> removeWeather(Weather weather) async {
    final db = await database;
   await db.delete('weathertabel', where: 'lat = ?', whereArgs: [weather.location.lat]);
  notifyListeners();
}



  }










