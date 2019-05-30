import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/weather?key=4c4dc19b&user_ip=remote";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.blue, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
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
