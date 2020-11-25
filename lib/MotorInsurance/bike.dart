import 'dart:convert';

///CREATED BY AK IJ
///25-11-2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Bike extends StatefulWidget {
  @override
  _BikeState createState() => _BikeState();
}

class _BikeState extends State<Bike> {
  TextEditingController capacityController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var formattedDate, newDateFormat;
  var newDate;

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

  /// Plan Type area
  var planList;
  String planListItem;
  String getPlanId;
  String getPlanListUrl= 'http://online.bnicl.net/api/plan-type/list';
  Future<String> getPlanList() async {
    var response = await http.get(getPlanListUrl);
    if(response.statusCode == 200){
      var decode = json.decode(response.body);
      setState(() {
        planList= decode['list'];
      });
      print("Plan list are: $planList");
    } else{
      customToast("Server Response Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPlanList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Motor Cycle Insurance",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
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

                      child: Text(
                          "Please Enter Vehicle Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#008577"),
                          )
                      ),

                    ),

                    SizedBox(height: 10.0,),

                    Text("Plan Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                    SizedBox(height: 2.0,),

                    /// select plan name spinner(dropdown list)
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
                                      hint: Text("Plan Name"),
                                      icon: Icon(Icons.arrow_downward),
                                      value: planListItem,
                                      iconSize: 18,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black),

                                      onChanged: (_newSelected){
                                        setState(() {
                                          planListItem= _newSelected;
                                          getPlanList();
                                          print(planListItem);
                                        });

                                      },

                                      items: planList?.map<DropdownMenuItem<String>>((_item){
                                        return DropdownMenuItem<String>(
                                          child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                          value: _item['name'].toString(),
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

                    Text("Vehicle Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                    SizedBox(height: 2.0,),

                    /// select Vehicle type spinner(dropdown list)
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
                                    hint: Text("Vehicle Type"),
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 18,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {

                                      });
                                    },
                                    items: [],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                    ),

                    SizedBox(height: 10.0,),

                    /// Driver and Capacity(cc/ton) text in row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 160.0,
                            child: Text(
                              "Driver",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 140.0,
                            child: Text(
                              "Capacity(cc/ton)",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )),
                      ],
                    ),

                    SizedBox(height: 2.0,),

                    /// Driver and Capacity(cc/ton) spinner in row
                    Container(
                      height: 40.0,
                      width: 310.0,
                      //color: Colors.deepPurple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 145.0,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                            child: Stack(
                              children: <Widget> [
                                Container(
                                  width: 145.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 103.0,
                                      ),
                                      Container(
                                        width: 40.0,
                                        color: Colors.amberAccent,
                                      ),
                                    ],
                                  ),

                                ),

                                Positioned(
                                  child: Container(
                                    child: Row(
                                      children: <Widget> [
                                        Container(
                                          width: 143.0,
                                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text("Select Driver"),
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 18,
                                              elevation: 16,
                                              style: TextStyle(color: Colors.black),
                                              onChanged: (_newSelected) {
                                                setState(() {

                                                });
                                              },
                                              items: [],
                                            ),
                                          ),
                                        ),

                                        Container(),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(width: 10.0,),

                          Container(
                            height: 40.0,
                            width: 145.0,
                            child: TextField(
                              maxLines: 1,
                              controller: capacityController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'capacity',
                              ),
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Text("Passenger", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                    SizedBox(height: 2.0,),

                    /// select Passenger spinner(dropdown list)
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
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 18,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                      });
                                    },
                                    items: [],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                    ),

                    SizedBox(height: 10.0,),

                    /// Date picker text in row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 160.0,
                            child: Text(
                              "Policy Start Date",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 140.0,
                            child: Text(
                              "Policy End Date",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )),
                      ],
                    ),

                    SizedBox(height: 2.0,),

                    /// Data picker start and end
                    Container(
                      height: 40.0,
                      width: 320.0,
                      child: Row(
                        children: <Widget> [
                          Container(
                            width: 145.0,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
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
                                            firstDate: DateTime(2000), lastDate: DateTime(2222)
                                        ).then((date) {
                                          setState(() {
                                            formattedDate = dateFormat.format(date);
                                            print("Formatted date is: $formattedDate");
                                            newDate = new DateTime(date.year+1, date.month, date.day);
                                            newDateFormat= dateFormat.format(newDate);
                                            print("new Date is: $newDate");
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

                          SizedBox(width: 14.0,),

                          Container(
                            height: 40.0,
                            width: 145.0,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                            child: Container(
                              height: 40.0,
                              width: 145.0,
                              alignment: Alignment.center,
                              color: HexColor("#f5f5f5"),
                              child: Text(
                                newDateFormat == null ? "Select Date" : newDateFormat,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.0,),

                    /// Button Get Quote
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
                              onPressed: () {}
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
