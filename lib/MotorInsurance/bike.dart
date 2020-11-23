import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Bike extends StatefulWidget {
  @override
  _BikeState createState() => _BikeState();
}

class _BikeState extends State<Bike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Motor Cycle Insurance",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
