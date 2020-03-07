import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This class create a custom TextFormField widget.
/// This widget allow only numbers inputs.
/// @author andre
class InputNumbers extends StatelessWidget {
  // final String label;
  final String prefix;
  final String helper;
  final TextEditingController controller;

  InputNumbers(
      {
      //@required this.label,
      @required this.prefix,
      @required this.helper,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,

          ///show numbers keyboard
          inputFormatters: <TextInputFormatter>[
            ///allow only numbers input
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: controller,
          decoration: InputDecoration(
            //labelText: label,
            prefixText: prefix,
            helperText: helper,
          ),
          validator: (value) {
            ///Tells the user if there is an empty field, elseif save the
            ///TextField's value in the controller.text variable
            if (value.isEmpty) {
              return "Enter a number, please.";
            }
            return null;
          },
        ));
  }
}
