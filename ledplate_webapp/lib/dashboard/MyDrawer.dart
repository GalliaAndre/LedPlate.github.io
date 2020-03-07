import 'package:flutter/material.dart';
import 'package:ledplate_webapp/main.dart';

///@author andre
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(

        ///Add a ListView to the drawer. This ensures the user can scroll
        ///through the options in the drawer if there isn't enough vertical
        ///space to fit everything.
        child: ListView(

            ///Important: remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "LED PLATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Screen's proportions: " +
                        LedPlate.screen.panelX.toString() +
                        "x" +
                        LedPlate.screen.panelY.toString()),
                    Text("Panel resolution: " +
                        LedPlate.screen.ledX.toString() +
                        "x" +
                        LedPlate.screen.ledY.toString() +
                        " px"),
                    Text("Screen resolution: " +
                        LedPlate.screen.screenResolutionX.toString() +
                        "x" +
                        LedPlate.screen.screenResolutionY.toString() +
                        " px"),
                  ],
                ),
              )),
          ListTile(
            title: Text("Item 1"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Item 2"),
            onTap: () {
              //TO DO
            },
          ),
        ]));
  }
}
