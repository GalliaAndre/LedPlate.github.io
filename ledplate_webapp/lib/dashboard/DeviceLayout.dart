import 'dart:io' as IO;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:ledplate_webapp/dashboard/TableBuilder.dart';
import 'package:ledplate_webapp/main.dart';

///@author andre
class DeviceLayout extends StatefulWidget {
  @override
  State createState() {
    return DeviceLayoutState();
  }
}

class DeviceLayoutState extends State<DeviceLayout> {
  static IMG.Image image, resizedImage;
  static var fileBytes, dataColors;

  void setScreenColors(Uint8List bytes) {
    setState(() {
      image = IMG.decodeImage(bytes);
      resizedImage = IMG.copyResize(image,
          width: LedPlate.screen.screenResolutionX,
          height: LedPlate.screen.screenResolutionY);

      ///This list should be sent sorted to the server
      dataColors = resizedImage.data;

      ///IMG.Image pixels color is in the format #AABBGGRR
      int r, g, b, a;
      for (int i = 0, s = 0; i < LedPlate.screen.ledColors.length; s++, i++) {
        r = dataColors[s] & 0xFFFFFFFF;
        g = ((dataColors[s] & 0xFFFFFFFF) >> 8);
        b = ((dataColors[s] & 0xFFFFFFFF) >> 16);
        a = ((dataColors[s] & 0xFFFFFFFF) >> 24);

        LedPlate.screen.ledColors[i] =
            Color.fromARGB(a, r, g, b).withOpacity(1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 40, bottom: 40),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LayoutBuilder(builder: (context, constraints) {
                  print("MyOneColumnLayout: Building the preview table.");
                  return TableBuilder(screen: LedPlate.screen);
                }),

                Text(LedPlate.path),
                //Image.file(File(LedPlate.path)),

                ///Upload from file system button
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.black,
                          iconSize: 35,
                          onPressed: () async {
                            print("Sei su smartphone");

                            ///opens the file system dialog and take the chosen image path
                            LedPlate.path = await FilePicker.getFilePath(
                                type: FileType.IMAGE);

                            ///create a new File object pointing to the chosen path
                            IO.File file = new IO.File(LedPlate.path);

                            ///decodes the file as a list of bytes
                            fileBytes = file.readAsBytesSync();
                            print("letto il file e creata la lista di bytes");

                            setState(() {
                              setScreenColors(fileBytes);
                            });
                          }),
                      Container(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return FileTable();
                  }),
                )
                */
              ]),
        ));
  }
}
