
/// CREATED BY AK IJ
/// 24-11-2020

import 'dart:convert';

import 'package:bnic/webview/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sslcommerz/sslcommerz.dart';
import 'package:http/http.dart' as http;
import 'omihinfoentry.dart';

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

  String privacyPolicyText= "I hereby declare that the details furnished above are true and correct to the best of my "
      "knowledge and belief and I undertake to inform you of any changes therein immediately."
      "I also declare that all the documents to operate the vehicle on public road are current and valid.";
  bool check = false;
  String getNameFromSP, getAddressFromSP, getMobileFromSP, getEmailFromSP, getPassportFromSP, getVisitedCountryFromSP, getCityFromSP, getCategoryFromSP;
  String getTypeFromSP, getOMPCategoryFromSP, getStayPeriodFromSP, getBirthDayFromSP;

  /// SSL Commerce area
  String status;
  String id= "bnicllive";
  String password= "5D89D9DCB840278023";
  String amount= "";
  String transactionId= "123456789098765";
  String paymentMethod= "NO";
  String productName= "food";
  String productCategory= "food";
  String productProfile= "general";
  String currency= "BDT";
  String successUrl= "https://securepay.sslcommerz.com/gw/apps/result.php";
  String failUrl= "https://securepay.sslcommerz.com/gw/apps/result.php";
  String cancelUrl= "https://securepay.sslcommerz.com/gw/apps/result.php";

  String paymentPostUrl= "https://securepay.sslcommerz.com/gwprocess/v4/api.php";
  String paymentPageUrl= "https://epay.sslcommerz.com/b96a25b5578d64dae9c141449093c7e44adaec0a";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getDataFormSP();
    });
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(children: <Widget>[

          Card(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            elevation: 10.0,
            child: Container(
              color: HexColor("#f5f5f5"),
              width: 320.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: 40.0,
                    width: 320.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black26)),
                    child: Text("Personal Information",
                        style: TextStyle(
                          color: HexColor("#008577"),
                          fontSize: 16.0,
                        )),
                  ),

                  SizedBox(height: 10.0,),

                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [

                        Text("Full Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getNameFromSP == null ? "null" : getNameFromSP.toString(),
                            //getNameFromSP,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getAddressFromSP == null ? "null" : getAddressFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getCityFromSP == null ? "null" : getCityFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Row(
                          children: <Widget>[
                            Container(
                              child: Text("Mobile", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),
                            ),
                            SizedBox(
                              width: 120.0,
                            ),
                            Container(
                              child: Text("Birth Day", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),
                            ),
                          ],
                        ),

                        SizedBox(height: 2.0,),

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
                                  getMobileFromSP == null ? "null" : getMobileFromSP.toString(),
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
                                  getBirthDayFromSP == null ? "null" : getBirthDayFromSP.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Email", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getEmailFromSP == null ? "null" : getEmailFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Passport", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getPassportFromSP == null ? "null" : getPassportFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Visited Country", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getVisitedCountryFromSP == null ? "null" : getVisitedCountryFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0,),

                        Container(
                            height: 20.0,
                            width: 320.0,
                            alignment: Alignment.center,
                            child: Text("Category", style: TextStyle(color: HexColor("#008577"), fontSize: 12.0,))
                        ),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.center,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getCategoryFromSP == null ? "null" : getCategoryFromSP.toString(),
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
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                    child: Text("OMP Information", style: TextStyle(fontSize: 16.0, color: HexColor("#008577"),)),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [

                        SizedBox(height: 10.0,),

                        Text("Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getTypeFromSP == null ? "null" : getTypeFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Category's", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getOMPCategoryFromSP == null ? "null" : getOMPCategoryFromSP.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text("Stay Period in Day's", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                        SizedBox(height: 2.0,),

                        Container(
                          height: 40.0,
                          width: 320.0,
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          alignment: Alignment.centerLeft,
                          decoration:
                          BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Text(
                            getStayPeriodFromSP == null ? "null" : getStayPeriodFromSP.toString(),
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
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                    child: Text(
                        "Declaration",
                        style: TextStyle(
                          color: HexColor("#008577"),
                          fontSize: 16.0,
                        )
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [

                        SizedBox(height: 10.0,),

                        Container(
                          height: 130.0,
                          width: 320.0,
                          child: Row(
                            children: <Widget> [
                              Container(
                                alignment: Alignment.topRight,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OmihInfoEntry()));
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
        ]),
      ),
    );
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
    EasyLoading.show(status: "Loading...");
    EasyLoading.isShow;
  }

  Future<String> postPaymentInformation() async {
    await http.post(paymentPostUrl, body: {
      'store_id': id,
      'store_passwd': password,
      'total_amount': amount,
      'tran_id': transactionId,
      'cus_name': getNameFromSP,
      'cus_email': getEmailFromSP,
      'cus_add1': getAddressFromSP,
      'cus_city': getCityFromSP,
      'cus_country': getVisitedCountryFromSP,
      'cus_phone': getMobileFromSP,
      'shipping_method': paymentMethod,
      'product_name': productName,
      'product_category': productCategory,
      'product_profile': productProfile,
      'currency': currency,
      'success_url': successUrl,
      'fail_url': failUrl,
      'cancel_url': cancelUrl,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        status= decode['status'];
        print("Status is: $status");
        configLoading();
        if(status.endsWith("SUCCESS")){
          customToast("You are able to pay");
          EasyLoading.dismiss();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> confirmInformation()));
        } else{
          customToast("Server Error");
        }
      });
      print("Type area: $decode");
    });
  }

  void getDataFormSP() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    getNameFromSP = preferences.get("fullName");
    getAddressFromSP = preferences.get("address");
    getMobileFromSP = preferences.get("mobile");
    getEmailFromSP = preferences.get("email");
    getPassportFromSP = preferences.get("password");
    getVisitedCountryFromSP = preferences.get("country");
    getCityFromSP = preferences.get("selectedCity");
    getCategoryFromSP = preferences.get("selectedCategory");
    getTypeFromSP = preferences.get("type");
    getOMPCategoryFromSP = preferences.get("categoryType");
    getStayPeriodFromSP = preferences.get("stayPeriod");
    getBirthDayFromSP = preferences.get("date");
    amount= preferences.get("totalAmount");
  }

}


