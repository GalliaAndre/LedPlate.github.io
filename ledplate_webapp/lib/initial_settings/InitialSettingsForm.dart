import 'package:flutter/material.dart';
import 'package:ledplate_webapp/initial_settings/CardInputTwoFields.dart';
import 'package:ledplate_webapp/main.dart';

/// Create a Form widget. Here is used the custom widget CardInputFields.
/// This class is responsible to retrieve initial settings data. These data are
/// important to create a Screen object that is the main entity to control with
/// this application.
/// @author andre
class InitialSettingsForm extends StatefulWidget {
  @override
  InitialSettingsFormState createState() {
    return InitialSettingsFormState();
  }
}

/// Create a corresponding State class.
/// This class holds data related to the form.
class InitialSettingsFormState extends State<InitialSettingsForm> {
  static final TextEditingController controllerLedX =
      new TextEditingController();
  static final TextEditingController controllerLedY =
      new TextEditingController();
  static final TextEditingController controllerPanelX =
      new TextEditingController();
  static final TextEditingController controllerPanelY =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Build a Form widget using the formKey created above.
    return Form(
        key: LedPlate.formKey,
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment(0, 0),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ///This card collect data about a panel.
                  CardInputTwoFields(
                      controller1: controllerLedX,
                      controller2: controllerLedY,
                      text: "How many leds for each panel?",
                      prefix1: "X:",
                      helper1: "Led's amount on x axis.",
                      prefix2: "Y:",
                      helper2: "Led's amount on y axis."),

                  ///This card collect data about the entire screen: how many
                  ///panels compose it.
                  CardInputTwoFields(
                      controller1: controllerPanelX,
                      controller2: controllerPanelY,
                      text: "How many panels make up the screen?",
                      prefix1: "X:",
                      helper1: "Panels' amount on x axis.",
                      prefix2: "Y:",
                      helper2: "Panels' amount on y axis."),
                ],
              )),
        ));
  }
}
