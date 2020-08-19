import 'package:PrevisaoTempo/view/forecast_next_days.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footer/footer.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Map> getWeather() async {
    http.Response response = await http.get("https://api.hgbrasil.com/weather?key=4c4dc19b&user_ip=remote");
    return jsonDecode(response.body);
  }

  _launchURL() async {
    const url = 'https://github.com/matheus1002';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
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
                    "Carregando...",
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if(snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar os dados",
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
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
                        onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ForecastPage(snapshot.data["results"]))
                          );
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ListView(
                            children: [
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                                title: Text("Temperatura"),
                                trailing: Text(snapshot.data["results"]["temp"].toString() + "°C"),
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.cloud),
                                title: Text("Clima"),
                                trailing: Text(snapshot.data["results"]["description"]),
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.sun),
                                title: Text("Umidade"),
                                trailing: Text(snapshot.data["results"]["humidity"].toString()),
                              ),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.wind),
                                title: Text("Vel. Vento"),
                                trailing: Text(snapshot.data["results"]["wind_speedy"]),
                              )
                            ],
                          ),
                        ),
                      ),
                      Footer(
                        child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: _launchURL,
                              child: Text(
                                "@matheus100",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            )
                        ),
                        backgroundColor: Color(0xfffbfafb),
                      ),
                    ],
                  );
                }
            }
          },
        )
    );
  }
}