// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();

    if (locationData?.latitude == null || locationData?.longitude == null) {
      print("Konum Bilgileri Gelmiyor");
    } else {
      print("latitude " + locationData!.latitude.toString());
      print("longitude " + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("Apiden Bilgiler boş dönüyor");
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
      return MainScreen();
    })));
  }

// uygulama ilk çalıştığında çalışan fonksiyon
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue])),
        child: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 150.0,
            duration: Duration(seconds: 3),
          ),
        ),
      ),
    );
  }
}
