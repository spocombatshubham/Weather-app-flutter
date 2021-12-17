import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future get_weather() async {
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?q=Dehradun&appid=49d6d740ef9d7cdab3172fd72742b101");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.get_weather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Dehradun",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0 kelvin" : "loadinig",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "loadinig",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text(
                      temp != null ? temp.toString() + " kelvin" : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text(
                      description != null ? description.toString() : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Humidity"),
                  trailing:
                      Text(humidity != null ? humidity.toString() : "loading"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Wind"),
                  trailing: Text(windSpeed != null
                      ? windSpeed.toString() + " mph"
                      : "loading"),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
