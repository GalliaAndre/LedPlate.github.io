import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ledplate_webapp/Screen.dart';
import 'package:ledplate_webapp/dashboard/Dashboard.dart';
import 'package:ledplate_webapp/initial_settings/InitialSettingsForm.dart';

void main() => runApp(LedPlate());

class LedPlate extends StatelessWidget {
  /// Create a global key that uniquely identifies the Form widget
  /// and allows validation of the form.
  ///
  /// Note: This is a GlobalKey<FormState>,
  /// not a GlobalKey<MyCustomFormState>.
  /// @author andre

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static Screen screen;
  static String path = "path";

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Initial Settings';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          elevation: 10,
          backgroundColor: Colors.orange,
        ),
        body: InitialSettingsForm(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("Main: Floating button pressed. Initializing Dashboard... ");

            /// Validate returns true if the form is valid, or false
            /// otherwise.
            if (formKey.currentState.validate()) {

              ///unfocus the keyboard when FloatingActionButton is pressed
              SystemChannels.textInput.invokeMethod('TextInput.hide');

              screen = new Screen(
                  int.parse(InitialSettingsFormState.controllerLedX.text),
                  //ledX
                  int.parse(InitialSettingsFormState.controllerLedY.text),
                  //ledY
                  int.parse(InitialSettingsFormState.controllerPanelX.text),
                  //panelX
                  int.parse(
                      InitialSettingsFormState.controllerPanelY.text) //panelY
                  );



              Navigator.push(formKey.currentContext,
                  MaterialPageRoute(builder: (context) => Dashboard()));

            }
          },
          label: Text("Launch"),
          icon: Icon(Icons.cast),
          elevation: 10,
          tooltip: "Create a new LedPlate and connect to the server",
        ),
      ),
    );
  }
}
