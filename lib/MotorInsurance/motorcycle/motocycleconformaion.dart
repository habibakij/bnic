import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MotorCycleConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text("MotorCycle Preview Details", style: TextStyle(fontSize: 14.0),),
      ),

      body: MotorDetails(),

    );
  }
}
class MotorDetails extends StatefulWidget {
  @override
  _MotorDetailsState createState() => _MotorDetailsState();
}

class _MotorDetailsState extends State<MotorDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
