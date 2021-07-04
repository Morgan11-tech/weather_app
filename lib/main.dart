import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var windSpeed;
  var timezone;
  var currently;
  var coord;
  var humidity;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Accra&appid=5d9f57e4bd235eafe8689d65f7f8bc12'));

    //from API key,
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.timezone = results['timezone'];
      this.currently = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.coord = results['coord']['lon'];
      this.humidity = results['weather'][0]['main'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Currently In Accra',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                  temp != null
                      ? temp.toString() + '\u00B0'
                      : 'Loading', //sign for degrees
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  humidity != null ? humidity.toString() : 'Loading',
                  style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        //this code is for everything in the white background.
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text(
                    'Temperature',
                    style: GoogleFonts.raleway(),
                  ),
                  trailing: Text(
                    temp != null ? temp.toString() + '\u00B0' : 'Loading',
                  ),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.compass),
                  title: Text(
                    'Coordinates',
                    style: GoogleFonts.raleway(),
                  ),
                  trailing: Text(coord != null ? coord.toString() : 'Loading'),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text(
                    'Weather',
                    style: GoogleFonts.raleway(),
                  ),
                  trailing: Text(
                      description != null ? description.toString() : 'Loading'),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.clock),
                  title: Text(
                    'Timezone',
                    style: GoogleFonts.raleway(),
                  ),
                  trailing:
                      Text(timezone != null ? timezone.toString() : 'Loading'),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text(
                    'wind speed',
                    style: GoogleFonts.raleway(),
                  ),
                  trailing: Text(
                      windSpeed != null ? windSpeed.toString() : 'Loading'),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
