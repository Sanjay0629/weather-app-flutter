import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/weather_forecast_screen.dart';
import 'package:weather_app/additional_info.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeaather();
  }

  Future getCurrentWeaather() async {
    try {
      String cityName = "London";
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey",
        ),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "An unexpected error occured";
      }
      setState(() {
        temp = data['List'][0]['main']['temp'];
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      //Main card
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "$temp K",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Icon(Icons.cloud, size: 64),
                          SizedBox(height: 20),
                          Text("Rain", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //weather information card
            const Text(
              "Weather Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 13),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  WeatherForecastScreen(
                    time: "09,00",
                    icons: Icons.cloud,
                    temp: "300.17",
                  ),
                  WeatherForecastScreen(
                    time: "12.00",
                    icons: Icons.wb_sunny,
                    temp: "300.54",
                  ),
                  WeatherForecastScreen(
                    time: "15.00",
                    icons: Icons.ac_unit,
                    temp: "300.11",
                  ),
                  WeatherForecastScreen(
                    time: "18.00",
                    icons: Icons.umbrella,
                    temp: "300.75",
                  ),
                  WeatherForecastScreen(
                    time: "21.00",
                    icons: Icons.wb_cloudy,
                    temp: "300.89",
                  ),
                  WeatherForecastScreen(
                    time: "24.00",
                    icons: Icons.cloud,
                    temp: "300.65",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Additional Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  speed: "94",
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: "Wind Speed",
                  speed: "7.67",
                ),
                AdditionalInfoItem(
                  icon: Icons.speed,
                  label: "Pressure",
                  speed: "1006",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
