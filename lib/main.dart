import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Weather(),
  ));
}

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TextEditingController inputcontroller = new TextEditingController();

  String city;
  double temp = 0.0;
  double feelsLike = 0.0;
  String env = "----";
  double windspeed = 0.0;

  Future<void> getWeatherInfo() async {
    city = inputcontroller.text;
    var response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=XXXXXXXXXXXXXXXXXXXXX"));
    //replace XXXXXXXXXXXXXXXXXXX with your api key
    Map details = jsonDecode(response.body);

    setState(() {
      temp = (details['main']['temp'] - 273.15).roundToDouble();
      feelsLike = (details['main']['feels_like'] - 273.15).roundToDouble();
      windspeed = details['wind']['speed'];
      env = details['weather'][0]['main'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App',
            style: TextStyle(
                fontSize: 26.0,
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[300],
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 90.0),
            child: Icon(
              Icons.wb_cloudy_rounded,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Enter City',
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'SourceSansPro',
                    color: Colors.grey[700]),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: inputcontroller,
                decoration: InputDecoration(
                  hintText: "Type city name here",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 122.0),
                child: ElevatedButton(
                  child: Text('Get weather info'),
                  onPressed: getWeatherInfo,
                ),
              ),
              Divider(
                height: 30.0,
                color: Colors.grey[700],
              ),
              Text(
                'Temperature',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 3),
              Text(
                '$temp celsius',
                style: TextStyle(fontSize: 30.0, color: Colors.grey[900]),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Feels like',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 3),
              Text(
                ('$feelsLike celsius'),
                style: TextStyle(fontSize: 30.0, color: Colors.grey[900]),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Environment',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 3),
              Text(
                env,
                style: TextStyle(fontSize: 30.0, color: Colors.grey[900]),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Wind speed',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20.0,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 3),
              Text(
                '$windspeed km/hr',
                style: TextStyle(fontSize: 30.0, color: Colors.grey[900]),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
