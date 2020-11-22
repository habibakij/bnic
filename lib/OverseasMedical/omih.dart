import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:bnic/Network/omihmodel.dart';
import 'package:bnic/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

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
  int flagType=0, flagCategory=0, flagBirthDay=0, flagStayPeriod=0;
  String years;

  /// Type select area
  var typeList;
  var typeListItem;
  var getTypeId;
  String postTypeUrl = 'http://online.bnicl.net/api/insurance-sub-type/list';
  Future<String> postType() async {
    await http.post(postTypeUrl, body: {
      'type_id': '4',
    }).then((response) {
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
    /*if(categoryList.isNotEmpty){
      categoryList.clear();
    }*/
    print("get_type_id: $id");
    await http.post(postCategoryUrl, body: {
      'sub_type_id': id,
    }).then((response) {
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
    print("get_type_id: $getTypeID");
    print("get_category_id: $getCategoryID");
    await http.post(postStayPeriodUrl, body: {
      'type_id': '4',
      'sub_type_id': getTypeID,
      'category_id': getCategoryID,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        stayPeriodList = decode['list'];
      });
      print("Stay period area: $decode");
    });
  }

  /// Get Quote area
  var netAmount, vatAmount, totalAmount;
  var quoteMax, quoteMin;
  var birthDate;
  String postGetQuoteUrl = 'http://online.bnicl.net/api/omp/price-quote';
  Future<String> postGetQuote(var getTypeID, var getCategoryID, var max, var min, var date) async {
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
      var decode = json.decode(response.body);
      setState(() {
        netAmount = decode['net'];
        vatAmount = decode['vat'];
        totalAmount = decode['total_cost'];

        print("Net Amount is: $netAmount"
            "Vat Amount is: $vatAmount"
            "total Amount is: $totalAmount");
      });
      print("Stay period area: $decode");
    });
  }


  void getQuoteInValidToast(){
    Fluttertoast.showToast(
        msg: "Select OMP Information",
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
    currentDate= dateFormat.format(currentDateTime);
    print("Current Date: $currentDate");
    YYDialog.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
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
            child: Container(
              width: 320.0,
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

                    child: Text("Please Enter OMP Information", style: TextStyle(fontSize: 16.0,)),

                  ),

                  SizedBox(height: 10.0,),

                  Text("Type", style: TextStyle(fontSize: 12.0,),),

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
                                    icon: Icon(Icons.arrow_downward),
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
                                        value: _item['id'].toString(),
                                        onTap: () {
                                          flagType++;
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

                  Text("Category", style: TextStyle(fontSize: 12.0,)),

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
                                  icon: Icon(Icons.arrow_downward),
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
                                      value: _item['id'].toString(),
                                      onTap: () {
                                        flagCategory++;
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
                            ),
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 140.0,
                          child: Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 12.0,
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
                      Container(
                        height: 40.0,
                        width: 145.0,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 39.0,
                                width: 40.0,
                                child: RaisedButton(
                                  child: Icon(
                                    Icons.calendar_today,
                                    size: 15.0,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                        context: context, initialDate: DateTime.now(),
                                        firstDate: DateTime(2000), lastDate: DateTime(2222))
                                        .then((date) {
                                          formattedDate = dateFormat.format(date);
                                          print("Formatted date is: $formattedDate");
                                          setState(() {
                                            flagBirthDay++;
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

                  Text("Stay Period (in day's)", style: TextStyle(fontSize: 12.0,),),

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
                                  value: stayPeriodListItem,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 18,
                                  elevation: 16,
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
                                        flagStayPeriod++;
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
                        RaisedButton(
                          color: Colors.amberAccent,
                          child: Text(
                            "Get Quote",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            if(flagType == 0){
                              getQuoteInValidToast();
                            } else if(flagCategory == 0) {
                              getQuoteInValidToast();
                            } else if(flagBirthDay == 0){
                              getQuoteInValidToast();
                            } else if(flagStayPeriod == 0){
                              getQuoteInValidToast();
                            } else{
                              YYDialogDemo(context);
                            }
                          }
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


  YYDialog YYDialogDemo(BuildContext context) {
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
                                child: Text(
                                    "Total Amount",
                                    style: TextStyle(fontSize: 12.0),),
                              ),
                            ),

                            Container(
                              height: 145.0,
                              width: 250.0,
                              child: Table(
                                border: TableBorder.all(),
                                //columnWidths: {1:FractionColumnWidth(.2)},
                                children: [

                                  TableRow(
                                    children: [
                                      Container(
                                        height: 40.0,
                                        color: HexColor("#e6e6e6"),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Net",
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
                                        child: Text(
                                          "Vat",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          width: 200.0,
          child: Column(
            children: <Widget> [

              Container(
                height: 40.0,
                color: Colors.yellow[800],
                child: Text(
                  "OMP Insurance Quotation",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),

              Text("Premium Calculation"),

              Table(
                border: TableBorder.all(),
                columnWidths: {2:FractionColumnWidth(.3)},
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 50.0,
                        color: Colors.amber,
                      ),

                      Container(
                        height: 50.0,
                        color: Colors.blue,
                      ),

                    ],
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}

