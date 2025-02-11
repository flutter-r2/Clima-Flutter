import 'package:clima/models/environment.dart';

import 'location.dart';
import 'networking.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> cityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$city&appid=${Environment.openWeatherApiKey}&units=metric');

    return await networkHelper.getWeatherData();
  }

  Future<dynamic> locationWeather() async {
    Location location = Location();
    await location.fetchLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.lat}&lon=${location.lon}&appid=${Environment.openWeatherApiKey}&units=metric');

    return await networkHelper.getWeatherData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
