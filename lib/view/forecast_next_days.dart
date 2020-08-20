import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForecastPage extends StatelessWidget {

  final Map getWeather;

  ForecastPage(this.getWeather);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(getWeather["city_name"]),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Container(
            //padding: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 10.0),
              width: double.maxFinite,
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf, size: 30.0),
                          title: Text(getWeather["forecast"][1]["weekday"].toString() + ", dia " + getWeather["forecast"][1]["date"].toString()),
                          subtitle: Text(
                              "Mínima de " + getWeather["forecast"][1]["min"].toString() + "°C" +
                                  " e Máxima de " + getWeather["forecast"][1]["max"].toString() + "°C, "
                                  "com " +  getWeather["forecast"][1]["description"].toString() + ".")
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:4.0)),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf, size: 30.0),
                          title: Text(getWeather["forecast"][2]["weekday"].toString() + ", dia " + getWeather["forecast"][2]["date"].toString()),
                          subtitle: Text(
                              "Mínima de " + getWeather["forecast"][2]["min"].toString() + "°C" +
                                  " e Máxima de " + getWeather["forecast"][2]["max"].toString() + "°C, "
                                  "com " +  getWeather["forecast"][2]["description"].toString() + ".")
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:4.0)),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf, size: 30.0),
                          title: Text(getWeather["forecast"][3]["weekday"].toString() + ", dia " + getWeather["forecast"][3]["date"].toString()),
                          subtitle: Text(
                              "Mínima de " + getWeather["forecast"][3]["min"].toString() + "°C" +
                                  " e Máxima de " + getWeather["forecast"][3]["max"].toString() + "°C, "
                                  "com " +  getWeather["forecast"][3]["description"].toString() + ".")
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:4.0)),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf, size: 30.0),
                          title: Text(getWeather["forecast"][4]["weekday"].toString() + ", dia " + getWeather["forecast"][4]["date"].toString()),
                          subtitle: Text(
                              "Mínima de " + getWeather["forecast"][4]["min"].toString() + "°C" +
                                  " e Máxima de " + getWeather["forecast"][4]["max"].toString() + "°C, "
                                  "com " +  getWeather["forecast"][4]["description"].toString() + ".")
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:4.0)),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf, size: 30.0),
                          title: Text(getWeather["forecast"][5]["weekday"].toString() + ", dia " + getWeather["forecast"][5]["date"].toString()),
                          subtitle: Text(
                              "Mínima de " + getWeather["forecast"][5]["min"].toString() + "°C" +
                                  " e Máxima de " + getWeather["forecast"][5]["max"].toString() + "°C, "
                                  "com " +  getWeather["forecast"][5]["description"].toString() + ".")
                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

}
