import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as IMG;
import 'package:ledplate_webapp/dashboard/TableBuilder.dart';
import 'package:ledplate_webapp/main.dart';

///@author andre
class WebLayout extends StatefulWidget {
  @override
  State createState() {
    return WebLayoutState();
  }
}

class WebLayoutState extends State<WebLayout> {
  static IMG.Image image, resizedImage;
  static var fileBytes, dataColors;
  List<int> _selectedFile;

  Uint8List _bytesData;
  String serverResponse = "response";

  void send() async {
    Response response = await post("http://10.0.0.1:3000",
        body: {'message': LedPlate.screen.colors4Server.toString()});
  }

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
      LedPlate.screen.sortColorsIMG();
    });
  }


  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
      setScreenColors(_bytesData);
    });


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 60, bottom: 40),
        child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              LayoutBuilder(builder: (context, constraints) {

                print("WebLayout: Building the preview table.");

                return TableBuilder(screen: LedPlate.screen);
              }),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ///Upload from file system button
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            tooltip: "Choose an image and preview it!",
                            icon: Icon(Icons.add),
                            color: Colors.black,
                            iconSize: 35,
                            onPressed: () async {

                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 7),
                                    content: Text("Uploading image...",
                                    style: TextStyle(
                                      color: Colors.orange,
                                    ),),
                                  )
                                );

                              if (kIsWeb) {
                                InputElement uploadInput =
                                    FileUploadInputElement();
                                uploadInput.draggable = true;
                                uploadInput.click();


                                uploadInput.onChange.listen((e) {
                                  final files = uploadInput.files;
                                  if (files.length == 1) {
                                    final file = files[0];
                                    final reader = new FileReader();
                                    reader.onLoadEnd.listen((e) {
                                      _handleResult(reader.result);
                                    });
                                    reader.readAsDataUrl(file);
                                  }
                                });
                              }

                              //print(LedPlate.screen.ledColors.toString());
                            }),
                        Container(
                          child: Text(
                            "Crop pic",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Send to screen button
                  Flexible(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              tooltip: "Send image to the screen!",
                              icon: Icon(Icons.slideshow),
                              color: Colors.lightGreenAccent,
                              iconSize: 35,
                              onPressed: () {
                                try {
                                  send();
                                } finally {
                                  setState(() {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        "Your picture has been sent to the screen!",
                                        style: TextStyle(
                                          color: Colors.lightGreenAccent,
                                        ),
                                      ),
                                    ));
                                  });
                                }
                              }),
                          Container(
                            child: Text(
                              "Show Image",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ]),

                    /* Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return FileTable();
                  }),
                )
                */
                  ),

                  ///Stop showing button: all led are set to black
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            tooltip: "Stop the playback!",
                            icon: Icon(Icons.stop),
                            color: Colors.red,
                            iconSize: 35,
                            onPressed: () {
                              setState(() {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Playback stopped!",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ));
                              });
                              setState(() {

                                for (int i = 0;
                                    i < LedPlate.screen.ledColors.length;
                                    i++) {
                                  LedPlate.screen.ledColors[i] = Colors.black;
                                }
                                LedPlate.screen.sortColorsIMG();
                                send();
                              });
                            }),
                        Container(
                          child: Text(
                            "Stop",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
