import 'dart:convert';

import 'package:bnic/OverseasMedical/omihinfoentry.dart';
import 'package:bnic/OverseasMedical/overseasconformation.dart';
import 'package:bnic/webview/paymentpage.dart';
import 'package:bnic/webview/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'carinfoentry.dart';

// ignore: camel_case_types
class commercialConformation extends StatefulWidget {
  @override
  _commercialConformationState createState() => _commercialConformationState();
}

// ignore: camel_case_types
class _commercialConformationState extends State<commercialConformation> {
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

      body: PreviewDetails(),
    );
  }
}

 class PreviewDetails extends StatefulWidget {
   @override
   _PreviewDetailsState createState() => _PreviewDetailsState();
 }

 class _PreviewDetailsState extends State<PreviewDetails> {

  bool check= true;
  String privacyPolicyText= "I hereby declare that the details furnished above are true and correct to the best of my "
      "knowledge and belief and I undertake to inform you of any changes therein immediately."
      "I also declare that all the documents to operate the vehicle on public road are current and valid.";

  String getNameFromSP, getAddressFromSP, getCityFromSP, getCityId, getMailAddressFromSP, getMailCityFromSP, getMailCityId, getMobileFromSP, getEmailFromSP, getBrandFromSP, getMenuYearFromSP,
      getRegNumberFromSP, getRegDateFromSP, getEngNumberFromSP, getChassisNoFromSP, getPlanNameFromSP, getVehiclesTypeFromSP,getDriverFromSP, getCapacityFromSP,
      getContactorFromSP, contactor= '0', getHelperFromSP, getPassengerFromSP, getPoStartDateFromSP, getPoEndDateFromSP, getTotalCastFromSP;

  double convertTaka;


  /// SSL Commerce area
  String status;
  String id= 'bnicllive';
  String password= '5D89D9DCB840278023';
  String amount= '';
  String transactionId= '123456789098765';
  String paymentMethod= 'NO';
  String productName= 'food';
  String productCategory= 'food';
  String productProfile= 'general';
  String currency= 'BDT';
  String successUrl= 'https://securepay.sslcommerz.com/gw/apps/result.php';
  String failUrl= 'https://securepay.sslcommerz.com/gw/apps/result.php';
  String cancelUrl= 'https://securepay.sslcommerz.com/gw/apps/result.php';

  String paymentPostUrl= 'https://securepay.sslcommerz.com/gwprocess/v4/api.php';
  String paymentPageUrl;

  void customToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFromSP();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {

     return SingleChildScrollView(
       child: Center(
         child: Column(
           children: <Widget> [

             Card(
               margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
               elevation: 10.0,
               child: Container(
                 color: HexColor("#f5f5f5"),
                 width: 320.0,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget> [

                     Container(
                       height: 40.0,
                       width: 320.0,
                       decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                       child: Container(
                         height: 40.0,
                         width: 320.0,
                         color: HexColor("#75f9a825"),
                         alignment: Alignment.centerLeft,
                         padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                         child: Text("Personal & Vehicles Information",
                             style: TextStyle(
                               color: HexColor("#008577"),
                               fontSize: 16.0,
                             )),
                       ),
                     ),

                     SizedBox(height: 15.0,),

                     Container(
                       padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget> [

                           Text("Insured Full Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getNameFromSP == null ? 'null' : getNameFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("Insured Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getAddressFromSP == null ? 'null' : getAddressFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getCityFromSP == null ? 'null' : getCityFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("Mailing Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getMailAddressFromSP == null ? 'null' : getMailAddressFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("Mailing City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getMailCityFromSP == null ? 'null' : getMailCityFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Mobile", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Email", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           //SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getMobileFromSP == null ? 'null' : getMobileFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10.0,
                                 ),
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getEmailFromSP == null ? 'null' : getEmailFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Vehicles Brand/Make", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Year of Manufacture", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           //SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getBrandFromSP == null ? 'null' : getBrandFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10.0,
                                 ),
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getMenuYearFromSP == null ? 'null' : getMenuYearFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Registration Number", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Registration Date", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           //SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getRegNumberFromSP == null ? 'null' : getRegNumberFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10.0,
                                 ),
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getRegDateFromSP == null ? 'null' : getRegDateFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Engine Number", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Chassis No", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           //SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getEngNumberFromSP == null ? 'null' : getEngNumberFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),

                                 SizedBox(width: 10.0,),

                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getChassisNoFromSP == null ? 'null' : getChassisNoFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                         ],
                       ),
                     ),

                   ],
                 ),
               ),
             ),

             Card(
               margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
               elevation: 10.0,
               child: Container(
                 color: HexColor("#f5f5f5"),
                 width: 320.0,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget> [

                     Container(
                       height: 40.0,
                       width: 320.0,
                       decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                       child: Container(
                         height: 40.0,
                         width: 320.0,
                         color: HexColor("#75f9a825"),
                         alignment: Alignment.centerLeft,
                         padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                         child: Text("Please Enter Vehicles Information",
                             style: TextStyle(
                               color: HexColor("#008577"),
                               fontSize: 16.0,
                             )),
                       ),
                     ),

                     SizedBox(height: 15.0,),

                     Container(
                       padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget> [

                           Text("Plan Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getPlanNameFromSP == null ? 'null' : getPlanNameFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("Vehicles Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getVehiclesTypeFromSP == null ? 'null' : getVehiclesTypeFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Driver", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Capacity ()cc/ton", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getDriverFromSP == null ? 'null' : getDriverFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10.0,
                                 ),
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getCapacityFromSP.toString() == null ? 'null' : getCapacityFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Contactor", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Helper", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     contactor,
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   width: 10.0,
                                 ),
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getHelperFromSP == '' ? "0" : getHelperFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Text("Passenger", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                           SizedBox(height: 5.0,),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                             alignment: Alignment.centerLeft,
                             decoration:
                             BoxDecoration(border: Border.all(color: Colors.black26)),
                             child: Text(
                               getPassengerFromSP == null ? "0" : getPassengerFromSP.toString(),
                               style: TextStyle(
                                 fontSize: 12.0,
                               ),
                             ),
                           ),

                           SizedBox(height: 15.0,),

                           Row(
                             children: <Widget>[
                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Policy Start Date", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                               ),

                               SizedBox(width: 10.0,),

                               Container(
                                 height: 20.0,
                                 width: 145.0,
                                 padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                 child: Text("Policy End Date", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                               ),
                             ],
                           ),

                           Container(
                             height: 40.0,
                             width: 320.0,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getPoStartDateFromSP == null ? 'null' : getPoStartDateFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),

                                 SizedBox(width: 10.0,),

                                 Container(
                                   height: 40.0,
                                   width: 145.0,
                                   alignment: Alignment.centerLeft,
                                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black26)),
                                   child: Text(
                                     getPoEndDateFromSP == null ? 'null' : getPoEndDateFromSP.toString(),
                                     style: TextStyle(
                                       fontSize: 12.0,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           SizedBox(height: 15.0,),

                         ],
                       ),
                     ),

                   ],
                 ),
               ),
             ),

             Card(
               margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
               elevation: 10.0,
               child: Container(
                 color: HexColor("#f5f5f5"),
                 width: 320.0,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget> [

                     Container(
                       height: 40.0,
                       width: 320.0,
                       decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                       child: Container(
                         height: 40.0,
                         width: 320.0,
                         color: HexColor("#75f9a825"),
                         alignment: Alignment.centerLeft,
                         padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                         child: Text("Declaration",
                             style: TextStyle(
                               color: HexColor("#008577"),
                               fontSize: 16.0,
                             )),
                       ),
                     ),

                     Container(
                       padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget> [

                           SizedBox(height: 15.0,),

                           Container(
                             height: 130.0,
                             width: 320.0,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget> [

                                 SizedBox(
                                   height: 24.0,
                                   width: 24.0,
                                   child: Checkbox(
                                     checkColor: Colors.greenAccent,
                                     activeColor: HexColor("#F9A825"),
                                     value: check,
                                     onChanged: (bool value){
                                       setState(() {
                                         check = value;
                                         print("Check Box value: $check");
                                       });
                                     },
                                   ),
                                 ),

                                 SizedBox(width: 5.0,),

                                 Container(
                                   width: 250.0,
                                   child: Column(
                                     children: <Widget> [
                                       Container(
                                         child: Text(
                                           privacyPolicyText,
                                           style: TextStyle(
                                             fontSize: 10.0,
                                           ),
                                         ),
                                       ),

                                       SizedBox(height: 10.0,),

                                       Container(
                                         alignment: Alignment.centerLeft,
                                         child: GestureDetector(
                                           child: Text(
                                             "View Policy",
                                             style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.amber[600],
                                               decoration: TextDecoration.underline,
                                             ),
                                           ),

                                           onTap: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));
                                           },
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),

                         ],
                       ),
                     ),

                   ],
                 ),
               ),
             ),

             SizedBox(height: 20.0,),

             Container(
               height: 40.0,
               width: 320.0,
               margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget> [

                   Container(
                     width: 125.0,
                     child: RaisedButton(
                       color: Colors.amber,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                           side: BorderSide(color: Colors.red)
                       ),
                       child: Text("Go Back", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                       onPressed: (){
                         Navigator.push(context, MaterialPageRoute (builder: (context) => CarInfoEntry()));
                       },
                     ),
                   ),

                   SizedBox(width: 40.0,),

                   Container(
                     width: 125.0,
                     child: RaisedButton(
                       color: Colors.amber,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                           side: BorderSide(color: Colors.red)
                       ),
                       child: Text("Pay Now", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                       onPressed: (){
                         if(check == true){
                           postPaymentInformation();
                         } else {
                           customToast("Please accept terms & conditions.");
                         }
                       },
                     ),
                   ),
                 ],
               ),
             ),

           ],
         ),
       ),
     );
   }

  Future<String> postPaymentInformation() async {
    EasyLoading.show();
    /*convertTaka= double.parse(getTotalCastFromSP);
    print("convert: $convertTaka");
    amount= convertTaka.toString();*/
    print(id);
    print(password);
    print(getTotalCastFromSP);
    print(transactionId);
    print(getNameFromSP);
    print(getEmailFromSP);
    print(getAddressFromSP);
    print(getCityFromSP);
    print("country null");
    print(getMobileFromSP);
    print(paymentMethod);
    print(productName);
    print(productCategory);
    print(productProfile);
    print(currency);
    print(successUrl);
    await http.post(paymentPostUrl, body: {
      'store_id': id.toString(),
      'store_passwd': password.toString(),
      'total_amount': amount.toString(),
      'tran_id': transactionId.toString(),
      'cus_name': getNameFromSP.toString(),
      'cus_email': getEmailFromSP.toString(),
      'cus_add1': getAddressFromSP.toString(),
      'cus_city': getCityFromSP.toString(),
      'cus_country': "",
      'cus_phone': getMobileFromSP.toString(),
      'shipping_method': paymentMethod.toString(),
      'product_name': productName.toString(),
      'product_category': productCategory.toString(),
      'product_profile': productProfile.toString(),
      'currency': currency.toString(),
      'success_url': 'https://securepay.sslcommerz.com/gw/apps/result.php',
      'fail_url': 'https://securepay.sslcommerz.com/gw/apps/result.php',
      'cancel_url': 'https://securepay.sslcommerz.com/gw/apps/result.php',
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        status= decode['status'];
        paymentPageUrl= decode['GatewayPageURL'];
        print("Status is: $status and $paymentPageUrl");
        if(status.endsWith("SUCCESS")){
          customToast("You are able to pay");
          EasyLoading.dismiss();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage(paymentPageUrl)));
        } else{
          EasyLoading.dismiss();
          customToast("Server Error");
        }
      });
      print("SSL area: $decode");
    });
  }

   void getDataFromSP() async {
     SharedPreferences preferences= await SharedPreferences.getInstance();
     setState(() {
       getNameFromSP= preferences.get("MIIE_name");
       getAddressFromSP= preferences.get("MIIE_address");
       getCityFromSP= preferences.get("MIIE_city");
       getCityId= preferences.get("MIIE_city_id");
       getMailAddressFromSP= preferences.get("MIIE_mailing_address");
       getMailCityFromSP= preferences.get("MIIE_mailing_city");
       getMailCityId= preferences.get("MIIE_mailing_city_id");
       getMobileFromSP= preferences.get("MIIE_mobile");
       getEmailFromSP= preferences.get("MIIE_email");
       getBrandFromSP= preferences.get("MIIE_vehicles_brand");
       getMenuYearFromSP= preferences.get("MIIE_year");
       getRegNumberFromSP= preferences.get("MIIE_registration_number");
       getRegDateFromSP= preferences.get("MIIE_registration_date");
       getEngNumberFromSP= preferences.get("MIIE_engine_number");
       getChassisNoFromSP= preferences.get("MIIE_chassis_no");
       getPlanNameFromSP= preferences.get("EVI_plan_type");
       getVehiclesTypeFromSP= preferences.get("EVI_vehicles_type");
       getDriverFromSP= preferences.get("EVI_driver");
       getCapacityFromSP= preferences.get("EVI_capacity");
       //contactor
       getHelperFromSP= preferences.get("EVI_helper");
       print("helper is: ${getHelperFromSP.toString()}");
       getPassengerFromSP= preferences.get("EVI_passenger");
       getPoStartDateFromSP= preferences.get("EVI_start_date");
       getPoEndDateFromSP= preferences.get("EVI_end_date");
       getTotalCastFromSP= preferences.get("EVI_total_cast");
       print("receive amount: $getTotalCastFromSP");

     });
   }

 }
