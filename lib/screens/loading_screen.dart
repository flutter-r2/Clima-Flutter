import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'b6907d289e10d714a6e88b30761fae22'; // only for 'sample' server
//only works for a fixed lat/lon pair, change to 'api' to use unrestrictedly
const server = 'sample';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double lon;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.currentLocation();

    lat = location.lat;
    lat = location.lon;

    getWeatherData();
  }

  Future<void> getWeatherData() async {
    http.Response response = await http.get(Uri.parse(
        'https://$server.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'));

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getWeatherData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
