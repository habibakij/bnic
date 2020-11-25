///CREATED BY AK IJ
///25-11-2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Car extends StatefulWidget {
  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car> {
  TextEditingController carPriceController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var formattedDate, newDateFormat;
  var newDate;
  bool carPriceVisibility= false;
  bool helperVisibility= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Private & Commercial Vehicles",
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

                    Text("Plan Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                    SizedBox(height: 2.0,),

                    /// select Plan type spinner(dropdown list)
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
                                    hint: Text("Plan Type"),
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

                    Text("Sub Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                    SizedBox(height: 2.0,),

                    /// select Sub type spinner(dropdown list)
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
                                    hint: Text("Sub Type"),
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

                    Visibility(
                      visible: !carPriceVisibility,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [

                            Text("Car Price", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                            SizedBox(height: 2.0,),

                            Container(
                              height: 40.0,
                              child: TextField(
                                maxLines: 1,
                                controller: carPriceController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Car Price',
                                ),
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
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

                    Visibility(
                      visible: helperVisibility,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [

                            Text("Helper", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                            SizedBox(height: 2.0,),

                            /// select Helper spinner(dropdown list)
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
                                            hint: Text("Helper"),
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

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Text("Passenger", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

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
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Passenger"),
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

                    SizedBox(height: 20.0,),

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

