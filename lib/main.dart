import 'package:data_table/contact_location.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Data Table",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Data Table"),
        ),
        body: Center(
          child: SizedBox(height: 300.0, child: ContactLocations()),
        ),
      ),
    );
  }
}
