import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledplate_webapp/Screen.dart';
import 'package:ledplate_webapp/main.dart';
//import 'dart:math' as math;

///This class is responsible of the preview screen building.
///The screen is represented through a Table.
///A table is composed of Rows and Columns. Every row is a widget (TableRow)
///in which every children created correspond to a column.
///To manage the dynamical behavior of the screen's dimension I created a List
///of TextField for every led on the x-axis and a Container for every led on
///the y-axis. Every y-row contains x-containers. Through this i create a screen
///made of pixels (colored containers).
///@author andre
class TableBuilder extends StatelessWidget {
  final Screen screen;
  static double width = 15;


  TableBuilder({
    @required this.screen,
  });

  ///Create and populate the TableRow list
  List populateList(double width) {
    List<TableRow> rows = new List<TableRow>();
    List<Container> containers = new List<Container>();
    TableRow t;
    Container c;
    double height, dim;
    int screenY = LedPlate.screen.screenResolutionY; //number of rows
    int screenX = LedPlate.screen.screenResolutionX; //number of columns

    ///Leds are always represented as squared.
    height = width;

    ///Here I'm trying to create a responsive preview of the screen.
    if (screenY > 15 || screenX > 15) {
      dim = 10;
      if (screenY >= 32 || screenX >= 32) {
        dim = 5;
        height = dim;
        TableBuilder.width = dim;
        if (screenY >= 64 || screenX >= 64) {
          dim = 2.5;
          height = dim;
          TableBuilder.width = dim;
        }
      }
    }
    print("Container init");

    ///Containers initialization
    for (int i = 0; i < screen.ledColors.length; i++) {
      c = new Container(
          height: height,
          //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          //    .withOpacity(1.0),
          color: screen.ledColors[i]);
      containers.add(c);
    }

    print("Row init");

    ///Rows initialization
    for (int i = 0; i < screen.ledColors.length; i = i + screenX) {
      for (int j = 0; j < screenY; j = j + screenX) {
        t = new TableRow();
        Iterable<Container> range = containers.getRange(i, i + screenX);
        //print(i.toString() + " " + (i + screenX).toString());
        t.children = range.toList();
      }

      rows.add(t);
    }

    print("return rows");

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Colors.black),

      ///Here I use the method described above
      children: populateList(width),
      defaultColumnWidth: FixedColumnWidth(width),
    );
  }
}
