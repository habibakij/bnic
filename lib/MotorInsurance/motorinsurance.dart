/// CREATED BY AK IJ
/// 14-11-2020

import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'motorcycle/motorcyl.dart';
import 'commercial/car.dart';

class MotorInsurance extends StatefulWidget {
  @override
  _MotorInsuranceState createState() => _MotorInsuranceState();
}

class _MotorInsuranceState extends State<MotorInsurance> {

  void customToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

  /// Internet connection Dialog
  void dialogConnectionTest(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),

                  Image.asset("assetimage/notconnect.jpg", height: 100.0, width: 80.0,),

                  SizedBox(height: 10.0,),

                  Text(msg, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),

                  SizedBox(height: 10.0,),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    color: HexColor("#F9A825"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    connectivityStatus();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    connectivityStatus();
    super.dispose();
  }

  var connectionChecker;
  void connectivityStatus() async {
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);

    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    connectionChecker= await DataConnectionChecker().connectionStatus;

    if(connectionChecker == DataConnectionStatus.connected){
      print("permission granted");
    } else{
      dialogConnectionTest(context, "No Internet Connection");
    }

    print("Last results: ${DataConnectionChecker().lastTryResults}");

    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
  }

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

            Text("Buy Motor Insurance", style: TextStyle(fontSize: 20.0, color: Colors.black,),),

            SizedBox(height: 20.0,),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              GestureDetector(
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 90.0,
                        width: 150.0,
                        child: Image.asset("assetimage/car.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 10.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Private & Commercial Vehicles",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Car()));
                },
              ),

              SizedBox(width: 10.0,),

              GestureDetector(
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 90.0,
                        width: 150.0,
                        child: Image.asset("assetimage/bike.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 20.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Motor Cycle Insurance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MotorCycle()));
                },
              ),

            ],),
          ]
        ),
      ),
    );
  }
}
