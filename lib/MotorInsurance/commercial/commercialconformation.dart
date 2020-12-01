import 'package:bnic/OverseasMedical/omihinfoentry.dart';
import 'package:bnic/OverseasMedical/overseasconformation.dart';
import 'package:bnic/webview/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

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
                         child: Text("Personal Information",
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
                               'name',
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
                               'address',
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
                               'city',
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
                               'mailing address',
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
                               'mailing city',
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
                                     'mobile',
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
                                     'email',
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
                                     'vehicles brand',
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
                                     'manufacture year',
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
                                     'reg number',
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
                                     'reg date',
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
                                     'engine number',
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
                                     'chassis no',
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
                         child: Text("Personal Information",
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
                               'plan name',
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
                               'vehicles type',
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
                                     'driver',
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
                                     'capacity',
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
                                     'contactor',
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
                                     'helper',
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
                               'Passenger',
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
                                     'start date',
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
                                     'end date',
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
                                             fontSize: 12.0,
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
                                             //Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));
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
                         //Navigator.push(context, MaterialPageRoute (builder: (context) => overseasConformation()));
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
                           customToast("you are oky.");
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
 }
