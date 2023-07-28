import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../classes/district.dart';
import '../classes/weather.dart';
import 'package:http/http.dart' as http;
class WeatherController extends GetxController{

  List<District> districts = [
  District(name:'Ampara',lat: 6.9672,lon: 81.1241),
  District(name:'Anuradhapura',lat: 8.3503,lon: 80.4109),
  District(name:'Badulla',lat: 6.9035,lon: 81.2302),
  District(name:'Batticaloa',lat: 7.5356,lon: 81.1915),
  District(name:'Colombo',lat: 6.9270,lon: 80.7717),
  District(name:'Galle',lat: 6.0170,lon: 79.9350),
  District(name:'Gampaha',lat: 6.9738,lon: 80.6116),
  District(name:'Hambantota',lat: 6.2803,lon: 80.4837),
  District(name:'Jaffna',lat: 9.6781,lon: 80.0246),
  District(name:'Kalutara',lat: 6.6959,lon: 79.9107),
  District(name:'Kandy',lat: 7.2221,lon: 80.6628),
  District(name:'Kurunegala',lat: 7.3632,lon: 80.3586),
  District(name:'Mannar',lat: 8.8682,lon: 80.3455),
  District(name:'Matara',lat: 5.9924,lon: 80.5525),
  District(name:'Moneragala',lat: 6.6249,lon: 81.4487),
  District(name:'Mullaitivu',lat: 9.0660,lon: 80.5981),
  District(name:'Nuwara Eliya',lat: 7.1673,lon: 80.7783),
  District(name:'Polonnaruwa',lat: 8.0622,lon: 80.9126),
  District(name:'Puttalam',lat: 7.0511,lon: 79.7842),
  District(name:'Ratnapura',lat: 6.6893,lon: 79.9660),
  District(name:'Trincomalee',lat: 8.6026,lon: 81.2263),
  District(name:'Vavuniya',lat: 9.3449,lon: 80.5163),
];


String _apiKey='';
String _apiUrl="";

bool isLoading=true;


RxList<Weather> weatherData=RxList<Weather>();

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWeather();
  }


  void getWeather() async {
    await dotenv.load();
    _apiKey = dotenv.env['WEATHER_API'].toString();

    try {
      for (int i = 0; i < districts.length; i++) {
        final double? lat = districts[i].lat;
        final double? lon = districts[i].lon;

        _apiUrl =
            'https://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&lon=${lon.toString()}&appid=${_apiKey}';
        final response = await http.get(Uri.parse(_apiUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          final temp = data['main']['temp'];
          final String message = getMessage(temp - 273.15);
          final String icon = getIcon(data['weather'][0]['main']);

          final Weather weather = Weather(
            city: data['name'],
            temperature: temp - 273.15,
            condition: data['weather'][0]['main'],
            humidity: data['main']['humidity'],
            country: data['sys']['country'],
            weatherIcon: icon,
            message: message,
          );
          weatherData.add(weather);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      update(); // Notify listeners that the data has been updated
    }
  }

  String getIcon(String condition) {
  if (condition.contains('Thunderstorm')) {
    return '🌩';
  } else if (condition.contains('Drizzle') || condition.contains('Rain')) {
    return '🌧';
  } else if (condition.contains('Rain')) {
    return '☔️';
  } else if (condition.contains('Snow')) {
    return '☃️';
  } else if (condition.contains('Mist') || condition.contains('Fog')) {
    return '🌫';
  } else if (condition == 'Clear') {
    return '☀️';
  } else if (condition.contains('Clouds')) {
    return '☁️';
  } else {
    return '🤷‍';
  }
}

 String getMessage(double temp) {
  if (temp > 25) {
    return 'It\'s time for 🍦';
  } else if (temp > 20) {
    return 'Wear shorts and 👕';
  } else if (temp < 10) {
    return 'Bundle up with 🧣 and 🧤';
  } else {
    return 'Bring a 🧥 just in case';
  }
}
}