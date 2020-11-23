import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class confirmInformation extends StatefulWidget {
  @override
  _confirmInformationState createState() => _confirmInformationState();
}

class _confirmInformationState extends State<confirmInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Preview Details",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: infoDetails(),
    );
  }
}

class infoDetails extends StatefulWidget {
  @override
  _infoDetailsState createState() => _infoDetailsState();
}

class _infoDetailsState extends State<infoDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
        child: Container(
          width: 320.0,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [

              Container(
                height: 40.0,
                width: 320.0,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Text("Personal Information",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ),

              SizedBox(height: 10.0,),

              Text("Full Name", style: TextStyle(fontSize: 12.0,)),

              SizedBox(height: 2.0,),

              Container(
                height: 40.0,
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

