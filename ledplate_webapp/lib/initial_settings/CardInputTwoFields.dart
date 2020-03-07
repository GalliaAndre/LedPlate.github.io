import 'package:flutter/material.dart';
import 'package:ledplate_webapp/initial_settings/InputNumbers.dart';

/// This class create a custom Card widget with two custom TextField inside.
/// The TextField is InputNumbers.
/// CardInputTwoFields requires a description (text), two prefixes, two helpers
/// and two TextEditingControllers.
/// @author andre
class CardInputTwoFields extends StatelessWidget {
  final String text;
  final String prefix1;
  final String prefix2;
  final String helper1;
  final String helper2;
  final TextEditingController controller1;
  final TextEditingController controller2;

  CardInputTwoFields(
      {@required this.text,
      @required this.prefix1,
      @required this.helper1,
      @required this.prefix2,
      @required this.helper2,
      @required this.controller1,
      @required this.controller2});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        padding: EdgeInsets.only(bottom: 45, left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(text),
            InputNumbers(
              prefix: prefix1,
              helper: helper1,
              controller: controller1,
            ),
            InputNumbers(
              prefix: prefix2,
              helper: helper2,
              controller: controller2,
            )
          ],
        ),
      ),
    );
  }
}
