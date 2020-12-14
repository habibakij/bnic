
/// created by AK IJ
/// 12-11-2020

import 'dart:async';
import 'package:bnic/OverseasMedical/overseasmedical.dart';
import 'package:bnic/webview/about.dart';
import 'package:bnic/webview/branchoffice.dart';
import 'package:bnic/webview/claiminformation.dart';
import 'package:bnic/webview/compayprofile.dart';
import 'package:bnic/webview/directorboard.dart';
import 'package:bnic/webview/management.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'MotorInsurance/motorinsurance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BNIC'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var connectionChecker;
  bool checkNetworkConnection= true;

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

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    //EasyLoading.show(status: "Loading...");
    EasyLoading.isShow;
  }

  void inValidToast() {
    Fluttertoast.showToast(
        msg: "Not valid at this time",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void customDialog(BuildContext context) {
    showDialog(context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Container(
              height: 200.0,
              width: 100.0,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 10.0,),

                  Image.asset("assetimage/logo.png", color: HexColor("#F9A825"), height: 100.0, width: 100.0,),

                  SizedBox(height: 10.0,),

                  Text("This feature will be available soon.", style: TextStyle(fontSize: 14.0,),),

                  SizedBox(height: 10.0,),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    color: HexColor("#F9A825"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK", style: TextStyle(color: Colors.white),),
                  ),
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
    configLoading();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    connectivityStatus();
    super.dispose();
  }

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

  /// custom toast
  void customToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: HexColor("#F9A825"),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0.1),
              child: Container(
                padding: EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xFFFFCA28),
                    const Color(0xFF303F9F)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      width: 150.0,
                      child: Image.asset("assetimage/logo.png"),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 50.0,
                      width: 200.0,
                      child: Text(
                        "Bangladesh National Insurance Company Limited",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            CustomListTile(Icons.person, "About Us", () =>
            {
              Navigator.pop(context),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUS())),
            }),
            CustomListTile(Icons.business, "Company Profile", () =>
            {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompanyProfile())),
            }),
            CustomListTile(Icons.people, "Board of Director", () =>
            {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DirectorBoard())),
            }),
            CustomListTile(Icons.business_center, "Management", () =>
            {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Management())),
            }),
            CustomListTile(Icons.offline_pin_outlined, "Branch Office", () =>
            {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BranchOffice())),
            }),
            CustomListTile(Icons.info, "Claim Information", () =>
            {
              Navigator.pop(context),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClaimInformation())),
            }),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[

            SizedBox(height: 10.0,),

            Container(
              height: 100.0,
              width: 100.0,
              child: Image.asset("assetimage/logo.png"),
            ),

            SizedBox(height: 20.0,),

            Text("Buy Insurance Online", style: TextStyle(fontSize: 18.0,),),

            SizedBox(height: 20.0,),

            /// first row with two property MOTOR & OVERPASS MEDICAL insurance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Card(
                  elevation: 10.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 90.0,
                        width: 150.0,
                        child: Image.asset("assetimage/motor.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 10.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Motor Insurance",
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

                SizedBox(width: 10.0,),

                Card(
                  elevation: 10.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 50.0,
                        width: 150.0,
                        child: Image.asset("assetimage/travel.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 30.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Overseas Medical Insurance (Health)",
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

              ],
            ),

            SizedBox(height: 20.0,),

            /// second row with two property MARIN & FIRE insurance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Card(
                  elevation: 10.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 90.0,
                        width: 150.0,
                        child: Image.asset("assetimage/marin.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 10.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Marin Insurance",
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

                SizedBox(width: 10.0,),

                Card(
                  elevation: 10.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        height: 80.0,
                        width: 150.0,
                        child: Image.asset("assetimage/fire.png", color: HexColor("#F9A825"),),
                      ),

                      SizedBox(height: 20.0,),

                      Container(
                        width: 150.0,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "Fire Insurance",
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

              ],
            ),

          ],
        ),
      ),
    );
  }

}

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  String title;
  Function onTap;

  CustomListTile(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: HexColor("#F9A825"),
      onTap: onTap,
      child: Container(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
