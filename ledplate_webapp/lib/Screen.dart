import 'dart:math' as math;

import 'package:flutter/material.dart';

///This class is meant to group data about a screen.
///TO DO: create instances for the server side
///@author andre
class Screen {
  ///number of led on x and y axis
  int ledX;
  int ledY;

  ///number of panels on x and y axis
  int panelX;
  int panelY;

  int screenResolutionX;
  int screenResolutionY;

  ///list of colors
  List<Color> ledColors;
  List colors4Server;

  Screen(int ledX, int ledY, int panelX, int panelY) {
    this.ledX = ledX;
    this.ledY = ledY;
    this.panelX = panelX;
    this.panelY = panelY;
    this.screenResolutionX = (this.ledX) * (this.panelX);
    this.screenResolutionY = (this.ledY) * (this.panelY);
    this.ledColors = new List(screenResolutionY * screenResolutionX);
    for (int i = 0; i < this.ledColors.length; i++) {
      this.ledColors[i] =
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0);
    }
    sortColorsIMG();

    print("Screen: created: " +
        this.screenResolutionX.toString() +
        " x " +
        this.screenResolutionY.toString());
  }

  @override
  String toString() {
    return ledX.toString() +
        " " +
        ledY.toString() +
        " " +
        panelX.toString() +
        " " +
        panelY.toString();
  }

  void sortColorsIMG(){
    this.colors4Server= new List(this.ledColors.length+1);
    this.colors4Server[0]= "0";
    for(int i=0; i<this.ledColors.length; i++){
      this.colors4Server[i+1]= this.ledColors[i].red.toString()+this.ledColors[i].green.toString()+this.ledColors[i].blue.toString();
    }
    print(this.colors4Server);
  }
}
