import 'dart:convert';

import 'package:bnic/Network/facilitymodel.dart';
import 'package:bnic/Network/omihmodel.dart';
///CREATED BY AK IJ
///25-11-2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
  bool carPriceVisibility = false;
  bool facilityVisibility = false;
  bool facilityListVisibility = false;


  bool check= true, check1= true, check2= true, check3= true;

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

  /// Plan Type area
  List planList;
  String planListItem;
  String getPlanId;
  String getPlanListUrl = 'http://online.bnicl.net/api/plan-type/list';
  Future<String> getPlanList() async {
    var response = await http.get(getPlanListUrl);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      setState(() {
        planList= decode['list'];
      });
      print("Plan list are: $planList");
    } else {
      customToast("Server Response Error");
    }
  }

  /// Sub Type area
  var subTypeList = ['Private Vehicle', 'Commercial Vehicle (CV)'];
  String subTypeListItem;

  /// Vehicles Type area
  String driverSelectItem;
  String passengerSelectItem;
  String helperSelectItem;
  List customDriverList;
  List customHelperList;
  List customPassengerList;
  List passengerSeatList;


  int listCount;
  var subTypeId;
  List<ListElement> vehiclesTypeList;
  List<Seat> vehiclesSeatList;
  String vehiclesTypeListItem;
  String vehiclesTypeListId;
  String getVehiclesTypeListUrl = 'http://online.bnicl.net/api/vehicle-type/list';
  Future<String> getVehiclesTypeList() async {
    await http.post(getVehiclesTypeListUrl, body: {
      'type_id':'1',
      'sub_type_id': subTypeId,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        OverseasJsonModel.fromJson(decode);
        OverseasJsonModel overseasJsonModel= OverseasJsonModel.fromJson(decode);
        vehiclesTypeList= overseasJsonModel.list.toList();
        listCount=  vehiclesTypeList.length;
      });
      print("Vehicles area: $vehiclesTypeList");
      print("Count: $listCount");
    });
  }

  /// Facility area
  List nameList, valueList;
  int length;
  String status;
  int conStatus;
  String foodCast, earthqCast, riotsCast, theftCast;
  String facilityListUrl= 'http://online.bnicl.net/api/insurance-facility/list';
  List facilityPercentageList;
  String planId, vehiclesTypeId, capacity;
  Future<String> getFacilityList(String planId, String vehiclesTypeId, String capacity) async {
    await http.post(facilityListUrl, body: {
    'plan_id':planId,
    'type_id':'1',
    'sub_type_id':'2',
    'vehicle_type_id':vehiclesTypeId,
    'cc':capacity,
    }).then((response) {
      var decode = json.decode(response.body);
      print("responsed: "+response.body);
      setState(() {

        facilityPercentageList= decode['list'];
        length= facilityPercentageList.length;
        status= decode['status'].toString();
        print("status: $status");
        conStatus= int.parse(status);
        print("status after convert: $status");

      });
      print("Facility area: $facilityPercentageList");
    });
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: Text("Please Enter Vehicle Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#008577"),
                          )),
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
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
                                    hint: Text("Plan Name"),
                                    icon: Icon(Icons.arrow_downward),
                                    value: planListItem,
                                    iconSize: 18,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        planListItem = _newSelected;
                                        getPlanList();
                                        print(planListItem);
                                      });
                                    },
                                    items: planList?.map<DropdownMenuItem<String>>((_item) {
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item['name'].toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        value: _item['name'].toString(),
                                        onTap: (){
                                          planId= _item['id'].toString();
                                          print("PlanId $planId");
                                          if(planId == 1.toString()){
                                            carPriceVisibility= false;
                                            facilityVisibility= false;
                                            facilityListVisibility= false;
                                          } else {
                                            carPriceVisibility= true;
                                            facilityVisibility= true;
                                          }
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
                                    value: subTypeListItem,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        subTypeListItem = _newSelected;
                                        print("similar value is: $subTypeListItem");
                                      });
                                    },
                                    items: subTypeList?.map<DropdownMenuItem<String>>((_item) {
                                      return DropdownMenuItem<String>(
                                        child: Text(_item, style: TextStyle(fontSize: 12.0),),
                                        value: _item,
                                        onTap: (){
                                          print("value is: $_item");
                                          int _index= subTypeList.indexOf(_item);
                                          print("index is: $_index");
                                          if(_index == 1){
                                            subTypeId= 9.toString();
                                            getVehiclesTypeList();
                                          }else {
                                            subTypeId= 2.toString();
                                            getVehiclesTypeList();
                                          }
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

                    Text("Vehicle Type", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                    SizedBox(height: 2.0,),

                    /// select Vehicle type spinner(dropdown list)
                    Container(
                      height: 40.0,
                      width: 320.0,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
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
                                    value: vehiclesTypeListItem,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        vehiclesTypeListItem= _newSelected;
                                        print("Selected: $_newSelected");
                                      });
                                    },
                                    items: vehiclesTypeList?.map<DropdownMenuItem<String>>((_item){
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item.name.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,),
                                        ),
                                        value: _item.name.toString(),
                                        onTap: (){
                                          vehiclesTypeId= _item.id.toString();
                                          print("vehicles Type Id: $vehiclesTypeId");
                                          vehiclesSeatList= _item.seat;
                                          print("vehicles seat list: ${vehiclesSeatList[0].maxCapacity}");
                                          customList(vehiclesSeatList);
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

                    Visibility(
                      visible: carPriceVisibility,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Car Price",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: HexColor("#008577"),
                                )),
                            SizedBox(
                              height: 2.0,
                            ),
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
                              children: <Widget>[

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
                                      children: <Widget>[
                                        Container(
                                          width: 143.0,
                                          padding: EdgeInsets.fromLTRB(
                                              5.0, 0.0, 10.0, 0.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text("Select Driver"),
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 18,
                                              elevation: 16,
                                              value: driverSelectItem,
                                              style: TextStyle(color: Colors.black),
                                              onChanged: (_newSelected) {
                                                setState(() {
                                                  driverSelectItem = _newSelected;
                                                  print("Select: $_newSelected");
                                                });
                                              },
                                              items: customDriverList?.map<DropdownMenuItem<String>>((_item){
                                                return DropdownMenuItem<String>(
                                                  child: Text(_item.maxCapacity, style: TextStyle(fontSize: 12.0),),
                                                  value: _item.maxCapacity,
                                                );
                                              })?.toList(),
                                            ),
                                          ),
                                        ),
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

                              style: TextStyle(fontSize: 12.0,),

                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Text("Helper", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                    SizedBox(height: 2.0,),

                    /// select Helper spinner(dropdown list)
                    Container(
                      height: 40.0,
                      width: 320.0,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
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
                                    value: helperSelectItem,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        helperSelectItem= _newSelected;
                                        print("Select: $_newSelected");
                                      });
                                    },
                                    items: customHelperList?.map<DropdownMenuItem<String>>((_item){
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item.maxCapacity,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                        value: _item.maxCapacity
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

                    Visibility(
                      visible: facilityVisibility,

                      child: TextButton(
                        child: Text("Facility",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HexColor("#008577"),
                            )
                        ),
                        onPressed: (){
                          setState(() {
                            if(capacityController.text.isEmpty){
                              customToast("Enter Capacity");
                            } else {
                              getFacilityList(planId, vehiclesTypeId, capacityController.text);
                              facilityListVisibility= true;
                              if(conStatus == 1){
                                print("matcher: $planId , $vehiclesTypeId , ${capacityController.text}");
                              } else{
                                print(conStatus.runtimeType);
                                print("matcher: $planId , $vehiclesTypeId , ${capacityController.text}");
                                print("Data not found");
                              }
                            }
                          });
                        },
                      ),

                    ),

                    Visibility(
                      visible: facilityListVisibility,
                      child: Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: length,
                            itemBuilder: (BuildContext context, int index){
                          return Container(
                            width: 320.0,
                            child: Row(
                              children: <Widget> [

                                Checkbox(
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


                                Container(
                                  height: 40.0,
                                  width: 120.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  child: Text(
                                    facilityPercentageList[index]['name'].toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),

                                ),

                                SizedBox(width: 2.0,),

                                Container(
                                  height: 40.0,
                                  width: 120.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  child: Text(
                                    facilityPercentageList[index]['cost'].toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          );
                        }),

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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
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
                                    value: passengerSelectItem,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        passengerSelectItem= _newSelected;
                                        print("Select: $_newSelected");
                                      });
                                    },
                                    items: passengerSeatList?.map((_item){
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item.toString(),
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                        value: _item.toString(),
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
                        children: <Widget>[
                          Container(
                            width: 145.0,
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
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2222))
                                            .then((date) {
                                          setState(() {
                                            formattedDate =
                                                dateFormat.format(date);
                                            print(
                                                "Formatted date is: $formattedDate");
                                            newDate = new DateTime(
                                                date.year + 1,
                                                date.month,
                                                date.day);
                                            newDateFormat =
                                                dateFormat.format(newDate);
                                            print("new Date is: $newDate");
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      formattedDate == null
                                          ? "Picked Date"
                                          : formattedDate.toString(),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: 14.0,
                          ),
                          Container(
                            height: 40.0,
                            width: 145.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            child: Container(
                              height: 40.0,
                              width: 145.0,
                              alignment: Alignment.center,
                              color: HexColor("#f5f5f5"),
                              child: Text(
                                newDateFormat == null
                                    ? "Select Date"
                                    : newDateFormat,
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
                              onPressed: () {}),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void customList(List<Seat> vehiclesSeatList){
    customDriverList= new List();
    customHelperList= new List();
    customPassengerList= new List();
    passengerSeatList= new List();

    for(Seat s in vehiclesSeatList ){
      if(s.name.toString() == "Name.DRIVER"){
        print("name: ${s.name.toString()}");
        setState(() {
          customDriverList.add(s);
        });
      } else if(s.name.toString() == "Name.HELPER"){
        print("name: ${s.name.toString()}");
        setState(() {
          customHelperList.add(s);
        });
      } else if(s.name.toString() == "Name.PASSENGER"){
        print("name: ${s.name.toString()}");
        String itemlength;
        setState(() {
          customPassengerList.add(s);
          // ignore: missing_return
          customPassengerList.map<String>((_item){
            itemlength= _item.maxCapacity;
            print("Passenger item: $itemlength");
          }).toString();
          for(int i=1; i<= int.parse(itemlength); i++){
            passengerSeatList.add(i);
          }
        });
      }
    }
  }

}


/*



class customFacilityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 300.0,

      child: Row(
        children: <Widget>[
          Container(
            height: 40.0,
            width: 50.0,
            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Checkbox(
              checkColor: Colors.greenAccent,
              activeColor: HexColor("#F9A825"),
              value: true,
              onChanged: (bool value){
                */
/*setState(() {
                  check = value;
                  print("Check Box value: $check");
                });*//*

              },
            ),
          ),

          SizedBox(width: 2.0,),

          Container(
            height: 40.0,
            width: 120.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Text(
              "Food & Cyclone",
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),

          ),

          SizedBox(width: 2.0,),

          Container(
            height: 40.0,
            width: 120.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Text(
              foodCast == null ? "null":foodCast.toString(),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
