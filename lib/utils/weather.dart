import 'dart:convert';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = '9b9a713d40c029683eb8b175b2336bca';

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper? locationData;
  double? currentTemperature;
  int? currentCondition;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData?.latitude}&lon=${locationData?.longitude}appid=${apiKey}&unit=metric"));

    //böyle bir site varsa...
    if (response.statusCode == 200) {
      String data = response.body;
      //hava durumu bilgilerini JSON dan okuyoruz
      var currentWeather = jsonDecode(data);

//decode sırasında hata oluşursa
      try {
        currentTemperature = currentWeather!['main']['temp'];
        currentCondition = currentWeather['weather']['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print("Api Çalışmıyor");
    }
  }
}
