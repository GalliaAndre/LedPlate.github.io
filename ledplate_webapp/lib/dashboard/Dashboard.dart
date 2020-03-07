import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ledplate_webapp/dashboard/DeviceLayout.dart';
import 'package:ledplate_webapp/dashboard/MyDrawer.dart';
import 'package:ledplate_webapp/dashboard/WebLayout.dart';
import 'package:ledplate_webapp/main.dart';

///Dashboard class manages the main page of the application.
///Here are shown settings data.
///@author andre
class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  ///deve essere lista di matrici
  static List<List<List<int>>> arrayDiMatrix;

  ///deve essere una lista di matrici
  static List<List<List<int>>> matrixX4;

  static List<int> vectorColorOrdered;

  static List<String> array4Server;

  ///determina la corretta creazione dell'output
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),

        ///In order to make my application responsive I used LayoutBuilder whom
        ///allows to choose programmatically which widget show on the route.
        body: LayoutBuilder(builder: (context, constraints) {
          ///So if the application is running on web.
          if (kIsWeb) {
            print("Dashboard: Launching WebLayout.");
            return WebLayout();
          }

          ///If it is running on browser or tablet.
          else {
            print("Dashboard: Launching DeviceLayout.");
            return WebLayout(); //to do TWO COLUMNS
          }
        }),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return new FloatingActionButton.extended(
              onPressed: () {
                print("Dashboard: Changing randomly preview colors.");

                for (int i = 0; i < LedPlate.screen.ledColors.length; i++) {
                  LedPlate.screen.ledColors[i] = Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                      .withOpacity(1.0);
                }
                LedPlate.screen.sortColorsIMG();

                setState(() {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: new Text(
                      "Random colors has been setted to your preview!",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ));
                });
              },
              label: Text("Random"),
            );
          },
        ),
        drawer: MyDrawer());
  }
}
