import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'bike.dart';
import 'car.dart';

class MotorInsurance extends StatefulWidget {
  @override
  _MotorInsuranceState createState() => _MotorInsuranceState();
}

class _MotorInsuranceState extends State<MotorInsurance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text("Motor Insurance"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [

            Text(
              "By Motor Insurance",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),

          SizedBox(height: 20.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 90.0,
                        width: 120.0,
                        child: Image.asset("assetimage/car.png", color: Colors.amberAccent),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        height: 30.0,
                        width: 120.0,
                        child: Text(
                          "Private & Commercial Vehicles",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Car()));
                  },
                ),
              ),

              SizedBox(
                width: 10.0,
              ),
              Container(
                //margin: const EdgeInsets.all(5.0),
                //padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0,),
                      Container(
                        height: 70.0,
                        width: 120.0,
                        child: Image.asset("assetimage/bike.png", color: Colors.amberAccent),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        height: 30.0,
                        width: 100.0,
                        child: Text(
                          "Motor Cycle Insurance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Bike()));
                  },
                ),
              ),
            ],
          ),
        ]
        ),
      ),
    );
  }
}
