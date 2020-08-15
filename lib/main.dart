import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() async {
  runApp(MaterialApp(
    title: "Weater App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Map> getWeather() async {
    http.Response response = await http.get("https://api.hgbrasil.com/weather?key=4c4dc19b&user_ip=remote");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map> (
        future: getWeather(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if(snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error is loading data...",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              snapshot.data["results"]["city_name"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data["results"]["temp"].toString() + "°C",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              snapshot.data["results"]["description"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ListView(
                          children: [
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                              title: Text("Temperature"),
                              trailing: Text(snapshot.data["results"]["temp"].toString() + "°C"),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.cloud),
                              title: Text("Weather"),
                              trailing: Text(snapshot.data["results"]["description"]),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.sun),
                              title: Text("Humidity"),
                              trailing: Text(snapshot.data["results"]["humidity"].toString()),
                            ),
                            ListTile(
                              leading: FaIcon(FontAwesomeIcons.wind),
                              title: Text("Wind Speed"),
                              trailing: Text(snapshot.data["results"]["wind_speedy"]),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
          }
        },
      )
    );

    /*Scaffold(
      backgroundColor: Colors.lightBlueAccent[700],
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data["results"]["city_name"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 80.0,
                            left: 75.0,
                          ),
                          /*
                          child: Image.network(
                              "https://assets.hgbrasil.com/weather/images/" +
                                  snapshot.data["results"]["img_id"] +
                                  ".png"),
                          */
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50.0),
                          child: Text(
                            snapshot.data["results"]["temp"].toString() + "°C",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 140.0,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 80.0),
                          child: Text(
                            snapshot.data["results"]["description"],
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            buildWeatherFuture(snapshot, 0),
                            buildWeatherFuture(snapshot, 1),
                            buildWeatherFuture(snapshot, 2),
                            buildWeatherFuture(snapshot, 3),
                            buildWeatherFuture(snapshot, 4)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );*/
  }
}

Widget buildWeatherFuture(snapshot, int index) {
  return Container(
    padding: EdgeInsets.only(left: 9.0),
    child: Column(
      children: <Widget>[
        Text(
          snapshot.data["results"]["forecast"][index]["weekday"].toString(),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        Divider(),
        Row(
          children: <Widget>[
            Icon(Icons.keyboard_arrow_up, size: 18.0, color: Colors.white),
            Text(
              " " +
                  snapshot.data["results"]["forecast"][index]["max"]
                      .toString() +
                  " °C",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.keyboard_arrow_down, size: 18.0, color: Colors.white),
            Text(
              " " +
                  snapshot.data["results"]["forecast"][index]["min"]
                      .toString() +
                  " °C",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}
