/// created by AK IJ
/// 12-11-2020

import 'package:bnic/OverseasMedical/omih.dart';
import 'package:bnic/webview/about.dart';
import 'package:bnic/webview/branchoffice.dart';
import 'package:bnic/webview/claiminformation.dart';
import 'package:bnic/webview/compayprofile.dart';
import 'package:bnic/webview/directorboard.dart';
import 'package:bnic/webview/management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  void inValidToast(){
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
  
  void customDialog(BuildContext context){
    showDialog(context: context,
    builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Container(
          height: 200.0,
          width: 100.0,
          child: Column(
            children: <Widget> [
              SizedBox(height: 10.0,),
              Image.asset("assetimage/logo.png", color: HexColor("#F9A825"), height: 100.0,),
              SizedBox(height: 10.0,),
              Text("This feature will be available soon.", style: TextStyle(fontSize: 14.0,),),
              SizedBox(height: 10.0,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                color: HexColor("#F9A825"),
                onPressed: (){Navigator.pop(context);},
                child: Text("OK", style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),
      );
    });
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
            CustomListTile(Icons.person, "About Us", () => {
                  Navigator.pop(context),
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUS())),
                }),
            CustomListTile(Icons.business, "Company Profile", () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfile())),
            }),
            CustomListTile(Icons.people, "Board of Director", () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => DirectorBoard())),
            }),
            CustomListTile(Icons.business_center, "Management", () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => Management())),
            }),
            CustomListTile(Icons.offline_pin_outlined, "Branch Office", () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => BranchOffice())),
            }),
            CustomListTile(Icons.info, "Claim Information", () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClaimInformation())),
            }),
          ],
        ),
      ),

      body: SingleChildScrollView(
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

            SizedBox(
              height: 20.0,
            ),

            /// first row with two property MOTOR & OVERPASS MEDICAL insurance
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //margin: const EdgeInsets.all(5.0),
                  //padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: FlatButton(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 120.0,
                          child: Image.asset("assetimage/motor.png", color: HexColor("#F9A825"),),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 20.0,
                          width: 100.0,
                          child: Text(
                            "Motor Insurance",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MotorInsurance()));
                    },
                  ),
                ),
                SizedBox(width: 10.0,),

                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: FlatButton(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Container(
                          height: 50.0,
                          width: 120.0,
                          child: Image.asset("assetimage/travel.png", color: HexColor("#F9A825"),),
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          height: 30.0,
                          width: 100.0,
                          child: Text(
                            "Overseas Medical Insurance (Health)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OMIH()));
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0,),

            /// second row with two property MARIN & FIRE insurance
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
                          child: Image.asset("assetimage/marin.png", color: HexColor("#F9A825"),),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 20.0,
                          width: 100.0,
                          child: Text(
                            "Marin Insurance",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      customDialog(context);
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
                          child: Image.asset("assetimage/fire.png", color: HexColor("#F9A825"),),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          height: 20.0,
                          width: 100.0,
                          child: Text(
                            "Fire Insurance",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      customDialog(context);
                    },
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
