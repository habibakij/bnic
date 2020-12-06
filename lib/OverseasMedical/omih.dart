/// created by AK IJ
/// 16-11-2020

import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:bnic/Network/omihmodel.dart';
import 'package:bnic/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'omihinfoentry.dart';

class OMIH extends StatefulWidget {
  @override
  _OMIHState createState() => _OMIHState();
}

class _OMIHState extends State<OMIH> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  final DateTime currentDateTime = DateTime.now();
  String formattedDate;
  String currentDate;
  String years;
  var mediaQueryWidth;

  /// Alert Dialog
  void customDialog(BuildContext context, String msg){
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
                  Text(msg, style: TextStyle(fontSize: 14.0,),),
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

  /// Type select area
  List typeList;
  var typeListItem;
  var getTypeId;
  var oldId= 1;
  String postTypeUrl = 'http://online.bnicl.net/api/insurance-sub-type/list';
  Future<String> postType() async {
    EasyLoading.show();
    await http.post(postTypeUrl, body: {
      'type_id': '4',
    }).then((response) {
      EasyLoading.dismiss();
      var decode = json.decode(response.body);
      setState(() {
        typeList = decode['list'];
      });
      print("Type area: $decode");
    });
  }

  /// Category select area
  List categoryList;
  var categoryListItem;
  var getCategoryId;
  String postCategoryUrl = 'http://online.bnicl.net/api/insurance-category/list';
  Future<String> postCategory(var id) async {
    EasyLoading.show();
    categoryList= new List();
    /*if(categoryList.isNotEmpty){
      categoryList.clear();
    }*/
    print("get_type_id: $id");
    await http.post(postCategoryUrl, body: {
      'sub_type_id': id,
    }).then((response) {
      EasyLoading.dismiss();
      var decode = json.decode(response.body);
      setState(() {
        categoryList = decode['list'];
      });
      print("Category area: $decode");
    });
  }

  /// Stay period select area
  var stayPeriodList;
  var stayPeriodListItem;
  var getStayPeriodId;
  String postStayPeriodUrl = 'http://online.bnicl.net/api/insurance-omp-charge/list';
  Future<String> postStayPeriod(var getTypeID, var getCategoryID) async {
    EasyLoading.show();
    print("get_type_id: $getTypeID");
    print("get_category_id: $getCategoryID");
    await http.post(postStayPeriodUrl, body: {
      'type_id': '4',
      'sub_type_id': getTypeID,
      'category_id': getCategoryID,
    }).then((response) {
      EasyLoading.dismiss();
      var decode = json.decode(response.body);
      setState(() {
        stayPeriodList = decode['list'];
      });
      print("Stay period area: $decode");
    });
  }

  /// Get Quote area
  int status;
  String message;
  var netAmount, vatAmount, totalAmount;
  var quoteMax, quoteMin;
  var birthDate;
  String postGetQuoteUrl = 'http://online.bnicl.net/api/omp/price-quote';
  Future<String> postGetQuote(var getTypeID, var getCategoryID, var max, var min, var date) async {
    EasyLoading.show();
    print("get_type_id: $getTypeID");
    print("get_category_id: $getCategoryID");
    await http.post(postGetQuoteUrl, body: {
      'type_id': '4',
      'sub_type_id': getTypeID,
      'category_id': getCategoryID,
      'dob': date,
      'min_stay': min,
      'max_stay': max,
    }).then((response) {
      EasyLoading.dismiss();
      var decode = json.decode(response.body);
      setState(() {
        netAmount = decode['net'];
        vatAmount = decode['vat'];
        totalAmount = decode['total_cost'];
        status= decode['status'];
        message= decode['message'];

        print("net Amount is: $netAmount"
            "vat Amount is: $vatAmount"
            "total Amount is: $totalAmount"
            "status is: $status"
            "message is: $message");
      });
      print("Stay period area: $decode");
    });
  }

  /// custom toast
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
  void initState() {
    // TODO: implement initState
    postType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryWidth= MediaQuery.of(context).size.width;
    currentDate= dateFormat.format(currentDateTime);
    print("Current Date: $currentDate");
    YYDialog.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Overseas Medical Insurance (Health)",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            elevation: 5.0,
            child: Container(
              //width: ((mediaQueryWidth/10)*9),
              width: 320.0,
              color: HexColor("#f5f5f5"),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: 40.0,
                    width: 320.0,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                    child: Text("Please Enter OMP Information", style: TextStyle(fontSize: 16.0, color: HexColor("#008577"),)),

                  ),

                  SizedBox(height: 10.0,),

                  Text("Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                  SizedBox(height: 2.0,),

                  /// select type spinner(dropdown list)
                  Container(
                    height: 40.0,
                    width: 320.0,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black26)),
                    child: Stack(
                      children: <Widget>[

                        Container(
                          height: 40.0,
                          width: 297.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 260.0,
                              ),
                              Container(
                                width: 37.0,
                                color: Colors.amberAccent,
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          child: Container(
                            child: Row(children: <Widget>[
                              Container(
                                width: 290.0,
                                alignment: Alignment.centerRight,

                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Select Type"),
                                    value: typeListItem,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),

                                    onChanged: (_newSelected) {
                                      setState(() {
                                        typeListItem = _newSelected;
                                        postType();
                                        print("type: $typeListItem");
                                      });
                                    },
                                    items: typeList?.map<DropdownMenuItem<String>>((_item) {
                                      return DropdownMenuItem<String>(
                                        child: new Text(_item['name'], style: TextStyle(fontSize: 12.0),),
                                        value: _item['name'].toString(),
                                        onTap: () {
                                          getTypeId = _item['id'].toString();
                                          print("type id: $getTypeId for select category.");
                                          postCategory(getTypeId);
                                        },
                                      );
                                    })?.toList(),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0,),

                  Text("Category", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                  SizedBox(height: 2.0,),

                  /// select category type spinner(dropdown list)
                  Container(
                    height: 40.0,
                    width: 320.0,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                    child: Stack(children: <Widget>[

                      Container(
                        height: 40.0,
                        width: 297.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                            ),
                            Container(
                              width: 37.0,
                              color: Colors.amberAccent,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        child: Container(
                          child: Row(children: <Widget>[
                            Container(
                              width: 290.0,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Select Category"),
                                  value: categoryListItem,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconSize: 18,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (_newSelected) {
                                    setState(() {
                                      categoryListItem = _newSelected;
                                      print("category $categoryListItem");
                                    });
                                  },
                                  items: categoryList?.map<DropdownMenuItem<String>>((_item) {
                                    return DropdownMenuItem<String>(
                                      child: new Text(_item['name'], style: TextStyle(fontSize: 12.0),),
                                      value: _item['name'].toString(),
                                      onTap: () {
                                        getCategoryId = _item['id'].toString();
                                        print("category id: $getCategoryId for stay period.");
                                        postStayPeriod(getTypeId, getCategoryId);
                                      },
                                    );
                                  })?.toList(),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),

                  SizedBox(height: 10.0,),

                  /// birth day and age text in row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 160.0,
                          child: Text(
                            "Birth Date",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HexColor("#008577"),
                            ),
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 140.0,
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HexColor("#008577"),
                            ),
                          )),
                    ],
                  ),

                  SizedBox(height: 2.0,),

                  /// birth date picker and age calculate in a row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Date Picker

                      GestureDetector(

                        child: Container(
                          height: 40.0,
                          width: 145.0,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  height: 39.0,
                                  width: 40.0,
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(0.0),
                                    color: Colors.amberAccent,
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2222)
                                      ).then((date) {
                                        formattedDate = dateFormat.format(date);
                                        print("Formatted date is: $formattedDate");
                                        setState(() {
                                          String selectDateTimeYear= formattedDate.substring(6);
                                          String todayDateTimeYear= currentDate.substring(6);
                                          print("selected year $selectDateTimeYear and current year $todayDateTimeYear");
                                          var selectYear= int.parse(selectDateTimeYear);
                                          var currentYear= int.parse(todayDateTimeYear);
                                          print("after converted selected year $selectYear and current year $currentYear");
                                          var year= currentYear-selectYear;
                                          print("calculated year: $year");
                                          years= year.toString();
                                          print("string converted year: $years");
                                        });
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    formattedDate == null ? "Picked Date" : formattedDate.toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ]),

                        ),

                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2222)
                          ).then((date) {
                            formattedDate = dateFormat.format(date);
                            print("Formatted date is: $formattedDate");
                            setState(() {
                              String selectDateTimeYear= formattedDate.substring(6);
                              String todayDateTimeYear= currentDate.substring(6);
                              print("selected year $selectDateTimeYear and current year $todayDateTimeYear");
                              var selectYear= int.parse(selectDateTimeYear);
                              var currentYear= int.parse(todayDateTimeYear);
                              print("after converted selected year $selectYear and current year $currentYear");
                              var year= currentYear-selectYear;
                              print("calculated year: $year");
                              years= year.toString();
                              print("string converted year: $years");
                            });
                          });
                        },

                      ),

                      SizedBox(width: 10.0,),

                      /// Calculate year
                      Container(
                        height: 40.0,
                        width: 145.0,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Text(
                            years == null ? "Select Date" : "$years years"
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 10.0,),

                  Text("Stay Period (in day's)", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                  SizedBox(height: 2.0,),

                  /// select Stay period spinner(dropdown list)
                  Container(
                    height: 40.0,
                    width: 320.0,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                    child: Stack(children: <Widget>[

                      Container(
                        height: 40.0,
                        width: 297.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 260.0,
                            ),
                            Container(
                              width: 37.0,
                              color: Colors.amberAccent,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        child: Container(
                          child: Row(children: <Widget>[
                            Container(
                              width: 290.0,
                              alignment: Alignment.centerRight,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Select Period"),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconSize: 18,
                                  elevation: 16,
                                  value: stayPeriodListItem,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (_newSelected) {
                                    setState(() {
                                      stayPeriodListItem = _newSelected;
                                      print("Stay Period: $stayPeriodListItem");
                                    });
                                  },
                                  items: stayPeriodList?.map<DropdownMenuItem<String>>((_item) {
                                    return DropdownMenuItem<String>(
                                      child: new Text(_item['stay'], style: TextStyle(fontSize: 12.0),),
                                      value: _item['stay'].toString(),
                                      onTap: (){
                                        quoteMax= _item['max_stay'].toString();
                                        quoteMin= _item['min_stay'].toString();
                                        postGetQuote(getTypeId, getCategoryId, quoteMax, quoteMin, formattedDate);
                                      },
                                    );
                                  })?.toList(),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),

                  SizedBox(height: 15.0,),

                  /// RaiseButton
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: RaisedButton(
                            color: HexColor("#F9A825"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.red)
                              ),
                            child: Text(
                              "Get Quote",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () {
                              if(typeListItem == null){
                                customToast("Select OMP Information");
                              } else if(categoryListItem == null) {
                                customToast("Select Category");
                              } else if(formattedDate == null){
                                customToast("Select Date");
                              } else if(stayPeriodListItem == null){
                                customToast("Select Stay Period");
                              } else{
                                if(status != 1){
                                  customDialog(context, message);
                                } else {
                                  YYDialogDemo(context);
                                }
                              }
                            }
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveDate() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("type", typeListItem.toString());
    preferences.setString("categoryType", categoryListItem.toString());
    preferences.setString("stayPeriod", stayPeriodListItem.toString());
    preferences.setString("date", formattedDate.toString());
    preferences.setString("totalAmount", totalAmount.toString());
    print("total amount passing :"+totalAmount.toString());
    preferences.commit();
    customToast("Date save successfully");
  }

  YYDialog YYDialogDemo(BuildContext context) {
    print("get quote data: $getTypeId, $getCategoryId, $quoteMax, $quoteMin, $formattedDate");
    return YYDialog().build(context)
      ..height = 300
      ..width = 250
      ..widget(

        Container(
          height: 300.0,
          width: 250.0,
          child: Column(
            children: <Widget> [

              Container(
                height: 35.0,
                width: 250.0,
                color: HexColor("#f9a825"),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                //alignment: Alignment.center,
                child: Text(
                  "OMP Insurance Quotation",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 240.0,
                  width: 250.0,
                  child: Column(
                    children: <Widget> [

                      Container(
                          height: 25.0,
                          width: 250.0,
                          //padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            "Premium Calculation",
                            style: TextStyle(fontSize: 12.0),
                          )
                      ),

                      Container(
                        height: 180.0,
                        width: 250.0,
                        child: Column(
                          children: <Widget> [

                            Container(
                              width: 250.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  top: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 250.0,
                                alignment: Alignment.center,
                                color: HexColor("#e6e6e6"),
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),

                                child: Text("Total Amount", style: TextStyle(fontSize: 12.0),),
                              ),
                            ),

                            Container(
                              height: 145.0,
                              width: 250.0,
                              child: Table(
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        height: 40.0,
                                        color: HexColor("#e6e6e6"),
                                        alignment: Alignment.center,

                                        child: Text("Net", style: TextStyle(fontSize: 12.0,),),
                                      ),

                                      Container(
                                        height: 40.0,
                                        color: HexColor("#e6e6e6"),
                                        alignment: Alignment.center,
                                        child: Text(
                                          netAmount == null ? "null" : netAmount.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  TableRow(
                                    children: [
                                      Container(
                                        height: 40.0,
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: Text("Vat", style: TextStyle(fontSize: 12.0,),),
                                      ),

                                      Container(
                                        height: 40.0,
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: Text(
                                          vatAmount == null ? "null" : vatAmount.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  TableRow(
                                    children: [
                                      Container(
                                        height: 40.0,
                                        color: HexColor("#e6e6e6"),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Total Amount",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        height: 40.0,
                                        color: HexColor("#e6e6e6"),
                                        alignment: Alignment.center,
                                        child: Text(
                                          totalAmount == null ? "null" : totalAmount.toString(),
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

                          ],
                        ),
                      ),

                      Container(
                        height: 35.0,
                        width: 250.0,
                        child: Row(
                            children: [
                              FlatButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.amberAccent,
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")
                              ),

                              SizedBox(width: 20.0,),

                              FlatButton(
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  color: Colors.amberAccent,
                                  onPressed: (){
                                    saveDate();
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OmihInfoEntry()));
                                  },
                                  child: Text("Buy Insurance")
                              ),
                            ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      )
      ..show();
  }
}

