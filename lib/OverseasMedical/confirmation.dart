
/// CREATED BY AK IJ
/// 24-11-2020

import 'dart:convert';

import 'package:bnic/webview/paymentpage.dart';
import 'package:bnic/webview/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
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
  String getTypeFromSP, getOMPCategoryFromSP, getStayPeriodFromSP, getBirthDayFromSP, taka;
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

  @override
  void initState() {
    // TODO: implement initState
    getDataFormSP();
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


  Future<String> postPaymentInformation() async {
    EasyLoading.show();
    convertTaka= double.parse(taka.replaceAll(',', ''));
    print("convert: $convertTaka");
    amount= convertTaka.toString();
    print(id);
    print(password);
    print(amount);
    print(transactionId);
    print(getNameFromSP);
    print(getEmailFromSP);
    print(getAddressFromSP);
    print(getCityFromSP);
    print(getVisitedCountryFromSP);
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
      'cus_country': getVisitedCountryFromSP.toString(),
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

  void getDataFormSP() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    setState(() {
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
      taka= preferences.get("totalAmount");
    });
    print("received for SP: $taka");
  }

}


