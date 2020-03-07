import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
          DataTable(columns: [
            DataColumn(
              label: Text("File"),
            ),
          ], rows: [
            /* DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),

            */
            /*DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),

             */
            /*DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),

             */
            DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),
            DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),
            DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),
            DataRow(selected: true, cells: [
              DataCell(
                Text('lorem ipsum'),
              ),
            ]),
          ]),
        ]));
  }
}
