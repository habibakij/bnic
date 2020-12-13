
/// CREATED BY AK IJ
/// 29-11-2020

import 'dart:convert';

import 'package:bnic/Network/facilitymodel.dart';
import 'package:bnic/Network/omihmodel.dart';

///CREATED BY AK IJ
///25-11-2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'carinfoentry.dart';

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
  bool check = true;

  void customDialog(BuildContext context, String msg) {
    showDialog(context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Container(
              height: 200.0,
              width: 100.0,
              padding: EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[

                  SizedBox(height: 10.0,),

                  Text(msg, style: TextStyle(fontSize: 14.0,),),

                  SizedBox(height: 10.0,),

                  Image.asset("assetimage/logo.png", color: HexColor("#F9A825"), height: 80.0,),

                  SizedBox(height: 20.0,),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    color: HexColor("#F9A825"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK", style: TextStyle(color: Colors.white),),)
                ],
              ),
            ),
          );
        });
  }

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
  String planId;
  String getPlanListUrl = 'http://online.bnicl.net/api/plan-type/list';
  Future<String> getPlanList() async {
    EasyLoading.show();
    var response = await http.get(getPlanListUrl);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      setState(() {
        EasyLoading.dismiss();
        planList = decode['list'];
      });
      print("Plan list are: $planList");
    } else {
      customToast("Server Response Error");
    }
  }

  /// Sub Type area
  int subTypeFlag = 0;
  var subTypeId;
  var subTypeList = ['Private Vehicle', 'Commercial Vehicle (CV)'];
  String subTypeListItem;

  /// Vehicles Type area
  int helperFlag = 0, passengerFlag = 0;
  String driverSelectItem;
  String passengerSelectItem;
  String helperSelectItem;
  String driverSelectId = "0";
  String passengerSelectId = "0";
  String helperSelectId = "0";
  String contactorSelectId = "0";
  List customDriverList;
  List customHelperList;
  List customPassengerList;
  List passengerSeatList;
  int listCount;
  List<ListElement> vehiclesTypeList;
  List<Seat> vehiclesSeatList;
  String vehiclesTypeListItem;
  String vehiclesTypeId;
  String getVehiclesTypeListUrl = 'http://online.bnicl.net/api/vehicle-type/list';
  Future<String> getVehiclesTypeList() async {
    await http.post(getVehiclesTypeListUrl, body: {
      'type_id': '1',
      'sub_type_id': subTypeId,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        EasyLoading.dismiss();
        OverseasJsonModel.fromJson(decode);
        OverseasJsonModel overseasJsonModel =
            OverseasJsonModel.fromJson(decode);
        vehiclesTypeList = overseasJsonModel.list.toList();
        listCount = vehiclesTypeList.length;
      });
      print("Vehicles area: $vehiclesTypeList");
      print("Count: $listCount");
    });
  }

  /// Facility area
  List facilityIdList = new List();
  int length = 0;
  String status;
  int conStatus;
  String facilityListUrl = 'http://online.bnicl.net/api/insurance-facility/list';
  List facilityPercentageList = new List();
  String capacity;
  Future<String> getFacilityList(
      String planId, String vehiclesTypeId, String capacity) async {
    EasyLoading.show();
    await http.post(facilityListUrl, body: {
      'plan_id': planId,
      'type_id': '1',
      'sub_type_id': '2',
      'vehicle_type_id': vehiclesTypeId,
      'cc': capacity,
    }).then((response) {
      EasyLoading.dismiss();
      var decode = json.decode(response.body);
      print("response: " + decode.toString());
      setState(() {
        facilityPercentageList = decode['list'];
        status = decode['status'].toString();
        conStatus = int.parse(status);
        //length = facilityPercentageList.length;
        print("status: $status and length: $length");
        print("status after convert status: $conStatus");

        if (conStatus == 1) {
          facilityListVisibility = true;
        } else {
          facilityListVisibility = false;
          customToast("No data found.");
          print("Data not found");
        }
      });
      print("Facility area: $facilityPercentageList");
    });
  }

  /// Get Quote area
  int priceStatus;
  List<int> passengerNo, passengerId;
  List terrifList;
  String totalCast;
  String getQuotePostUrl = 'http://online.bnicl.net/api/motor/price-quote';
  int trLength = 0;
  Future<String> getQuotePost(String planId, String typeId, String subTypeId, String vehiclesTypeId,
      String passengerId, String passengerNo, String capacity, String carPrice, String facilityList) async {
    terrifList = new List();
    await http.post(getQuotePostUrl, body: {
      'plan_id': planId,
      'type_id': typeId,
      'sub_type_id': subTypeId,
      'vtype': vehiclesTypeId,
      'passenger_id': passengerId.toString(),
      'passenger_no': passengerNo.toString(),
      'cc': capacity,
      'asset_value': carPrice,
      'facility': facilityList.toString(),
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        EasyLoading.dismiss();
        priceStatus = decode['status'];
        if(priceStatus == 0){
          customDialog(context, "No Terrif Plan Available");
        } else{
          terrifList = decode['terrif'];
          totalCast = decode['total_cost'];

          print("priceStatus is: $priceStatus and type is: ${priceStatus.runtimeType}");
          trLength = terrifList.length == null ? 0 : terrifList.length;

          saveDataSP();
          if (trLength > 0) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Motor Insurance Quotation',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),

                    content: Container(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: trLength,
                        itemBuilder: (ctx, index) {
                          return Container(
                            child: Row(
                              children: <Widget>[

                                Container(
                                  height: 40.0,
                                  width: 110.0,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),

                                  child: Text(
                                    terrifList[index]['title'].toString() == null ? "null" : terrifList[index]['title'].toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 2.0,),

                                Container(
                                  height: 40.0,
                                  width: 110.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                                  child: Text(
                                    terrifList[index]['total_cost'].toString() == null ? "null" : terrifList[index]['total_cost'].toString(),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    actions: <Widget>[
                      Container(
                        width: 300.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Container(
                              width: 120.0,
                              child: RaisedButton(
                                color: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.red)
                                ),
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),

                            SizedBox(width: 5.0,),

                            Container(
                              width: 120.0,
                              child: RaisedButton(
                                color: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.red)
                                ),
                                child: Text(
                                  "Buy Insurance",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarInfoEntry()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          } else {
            EasyLoading.dismiss();
            customToast("length null");
          }
        }
        
        print("trLength is: $trLength");
      });
      print("get Quote area: $terrifList and total cast: $totalCast");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPlanList();
    super.initState();
  }

  var mediaQueryWidth;
  double mainContainerWidth, mainContainerWidthWP, stackFirstContainer, stackSecondContainer, containerHalfWidth, containerHalfWidthWP,
      stackHalfContainer, stackHalfContainer1;
  Orientation orientation;
  double landStackContainer, landStackContainer1, landStackHalfContainer, landStackHalfContainer1, facilityContainer, facilityContainerWidth;

  @override
  Widget build(BuildContext context) {
    mediaQueryWidth = MediaQuery.of(context).size.width;
    mainContainerWidth = ((mediaQueryWidth / 100.0) * 90.0);
    mainContainerWidthWP = mainContainerWidth - 18.0;

    facilityContainer = (mainContainerWidthWP / 10);
    facilityContainerWidth = (facilityContainer * 4);

    stackFirstContainer = ((mainContainerWidthWP / 100.0) * 87.0);
    stackSecondContainer = ((mainContainerWidthWP / 100.0) * 13.0);
    containerHalfWidth = ((mainContainerWidthWP / 2) - 4);
    containerHalfWidthWP = (containerHalfWidth - 2);

    stackHalfContainer = ((containerHalfWidthWP / 100.0) * 75.00);
    stackHalfContainer1 = ((containerHalfWidthWP / 100.0) * 25.00);

    landStackHalfContainer = ((containerHalfWidthWP / 100.0) * 87.00);
    landStackHalfContainer1 = ((containerHalfWidthWP / 100.0) * 13.00);

    landStackContainer = ((mainContainerWidthWP / 100.0) * 93.0);
    landStackContainer1 = ((mainContainerWidthWP / 100.0) * 07.0);
    orientation = MediaQuery.of(context).orientation;

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
              elevation: 5.0,
              child: Container(
                width: mainContainerWidth,
                color: HexColor("#f2f2f2"),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: Text("Please Enter Vehicle Information",
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
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (landStackContainer),
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: landStackContainer1,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (stackFirstContainer),
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: stackSecondContainer,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        Positioned(
                          child: Container(
                            height: 45.0,
                            child: Row(children: <Widget>[
                              Container(
                                width: mainContainerWidthWP,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Plan Name"),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    value: planListItem,
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
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
                                        onTap: () {
                                          planId = _item['id'].toString();
                                          print("PlanId $planId");
                                          if (planId == 1.toString()) {
                                            carPriceVisibility = false;
                                            facilityVisibility = false;
                                            facilityListVisibility = false;
                                          } else {
                                            carPriceVisibility = true;
                                            facilityVisibility = true;
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
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (landStackContainer),
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: landStackContainer1,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (stackFirstContainer),
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: stackSecondContainer,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        Positioned(
                          child: Container(
                            height: 45.0,
                            child: Row(children: <Widget>[
                              Container(
                                width: mainContainerWidthWP,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Sub Type"),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
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
                                        child: Text(
                                          _item,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                        value: _item,
                                        onTap: () {
                                          vehiclesTypeListItem = "Vehicle Type";
                                          subTypeFlag++;
                                          print("value is: $_item");
                                          int _index = subTypeList.indexOf(_item);
                                          print("index is: $_index");
                                          if (_index == 1) {
                                            subTypeId = 9.toString();
                                            EasyLoading.show();
                                            getVehiclesTypeList();
                                          } else {
                                            subTypeId = 2.toString();
                                            EasyLoading.show();
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
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: (landStackContainer),
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      vehiclesTypeListItem == null ? "Vehicle Type" : vehiclesTypeListItem,
                                    ),
                                  ),
                                  Container(
                                    width: landStackContainer1,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: (stackFirstContainer),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      vehiclesTypeListItem == null ? "Vehicle Type" : vehiclesTypeListItem,
                                    ),
                                  ),
                                  Container(
                                    width: stackSecondContainer,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        Positioned(
                          child: Container(
                            height: 45.0,
                            child: Row(children: <Widget>[
                              Container(
                                width: mainContainerWidthWP,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        vehiclesTypeListItem = _newSelected;
                                        print("Selected: $_newSelected");
                                      });
                                    },
                                    items: vehiclesTypeList?.map<DropdownMenuItem<String>>((_item) {
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item.name.toString(),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        value: _item.name.toString(),
                                        onTap: () {
                                          vehiclesTypeId = _item.id.toString();
                                          print("vehicles Type Id: $vehiclesTypeId");
                                          vehiclesSeatList = _item.seat;
                                          EasyLoading.show();
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

                    /// Visibility Car Price Text Field
                    Visibility(
                      visible: carPriceVisibility,
                      child: Container(
                        width: mainContainerWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("Car Price", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                            SizedBox(height: 2.0,),

                            Container(
                              height: 45.0,
                              child: TextField(
                                maxLines: 1,
                                autocorrect: false,
                                controller: carPriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Car Price',
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey[400]),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey[400]),
                                  ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: containerHalfWidth,
                            child: Text(
                              "Driver",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )
                        ),
                        Container(
                            width: containerHalfWidth,
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Capacity(cc/ton)",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 2.0,),

                    /// Driver and Capacity(cc/ton) spinner in row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 45.0,
                          width: containerHalfWidth,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                          child: Stack(
                            children: <Widget>[

                              Builder(builder: (context) {
                                if (orientation.index == Orientation.landscape.index) {
                                  return Container(
                                    height: 45.0,
                                    width: containerHalfWidthWP,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: landStackHalfContainer,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          width: landStackHalfContainer1,
                                          color: HexColor("#f2f2f2"),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    height: 45.0,
                                    width: containerHalfWidthWP,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: stackHalfContainer,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          width: stackHalfContainer1,
                                          color: HexColor("#f2f2f2"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),

                              Positioned(
                                child: Container(
                                  height: 45.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: containerHalfWidthWP,
                                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                        alignment: Alignment.centerRight,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            hint: Text("Select Driver"),
                                            icon: Icon(Icons.keyboard_arrow_down),
                                            iconSize: 18,
                                            elevation: 16,
                                            iconEnabledColor: Colors.amber[900],
                                            value: driverSelectItem,
                                            style: TextStyle(color: Colors.black),
                                            onChanged: (_newSelected) {
                                              setState(() {
                                                driverSelectItem = _newSelected;
                                                print("Select: $_newSelected");
                                              });
                                            },
                                            items: customDriverList?.map<DropdownMenuItem<String>>((_item) {
                                              return DropdownMenuItem<String>(
                                                child: Text(
                                                  _item.maxCapacity,
                                                  style: TextStyle(
                                                      fontSize: 12.0),
                                                ),
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
                          height: 45.0,
                          width: containerHalfWidth,
                          child: TextField(
                            maxLines: 1,
                            autocorrect: false,
                            controller: capacityController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Capacity',
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10.0,),

                    Text("Helper", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                    SizedBox(height: 2.0,),

                    /// select Helper spinner(dropdown list)
                    Container(
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: (landStackContainer),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      helperSelectItem == null ? "Helper" : helperSelectItem,
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: landStackContainer1,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: (stackFirstContainer),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      helperSelectItem == null ? "Helper" : helperSelectItem,
                                      style: TextStyle(
                                        fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: stackSecondContainer,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        Positioned(
                          child: Container(
                            height: 45.0,
                            child: Row(children: <Widget>[
                              Container(
                                width: mainContainerWidthWP,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        helperSelectItem = _newSelected;
                                        print("Select: $_newSelected");
                                      });
                                    },
                                    items: customHelperList?.map<DropdownMenuItem<String>>((_item) {
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          _item.maxCapacity,
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                        value: _item.maxCapacity,
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

                    /// Visibility Facility button
                    Visibility(
                      visible: facilityVisibility,
                      child: TextButton(
                        child: Text("Facility",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HexColor("#008577"),
                            )
                        ),
                        onPressed: () {
                          setState(() {
                            if (capacityController.text.isEmpty) {
                              customToast("Enter Capacity");
                            } else if (vehiclesTypeId == null) {
                              customToast("Select Vehicles");
                            } else {
                              getFacilityList(planId, vehiclesTypeId, capacityController.text);
                              print("matcher: $planId , $vehiclesTypeId , ${capacityController.text}");
                            }
                          });
                        },
                      ),
                    ),

                    /// Visibility Facility list
                    Visibility(
                      visible: facilityListVisibility,
                      child: Container(
                        height: 150.0,
                        width: mainContainerWidthWP,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: facilityPercentageList != null ? facilityPercentageList.length : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Checkbox(
                                      checkColor: Colors.greenAccent,
                                      activeColor: HexColor("#F9A825"),
                                      value: check,
                                      onChanged: (bool value) {
                                        setState(() {
                                          check = value;
                                          facilityIdList.add(facilityPercentageList[index]['id'].toString());
                                          print("Check Box value: $check");
                                        });
                                      },
                                    ),

                                    Container(
                                      height: 40.0,
                                      width: facilityContainerWidth,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                      child: Text(
                                        facilityPercentageList[index]['name'].toString() == null ? "null" : facilityPercentageList[index]['name'].toString(),
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 2.0,),

                                    Container(
                                      height: 40.0,
                                      width: facilityContainerWidth,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                      child: Text(
                                        facilityPercentageList[index]['cost'].toString() == null ? "null" : facilityPercentageList[index]['cost'].toString(),
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
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: (landStackContainer),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      passengerSelectItem == null ? "Select Passenger" : passengerSelectItem,
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: landStackContainer1,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              height: 45.0,
                              width: mainContainerWidthWP,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45.0,
                                    width: (stackFirstContainer),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      passengerSelectItem == null ? "Select Passenger" : passengerSelectItem,
                                      style: TextStyle(
                                          fontSize: 12.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: stackSecondContainer,
                                    color: HexColor("#f2f2f2"),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),

                        Positioned(
                          child: Container(
                            height: 45.0,
                            child: Row(children: <Widget>[
                              Container(
                                width: mainContainerWidthWP,
                                padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                alignment: Alignment.centerRight,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        passengerSelectItem = _newSelected;
                                        print("Select: $_newSelected");
                                      });
                                    },
                                    items: passengerSeatList?.map((_item) {
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
                            width: containerHalfWidth,
                            child: Text(
                              "Policy Start Date",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )
                        ),
                        Container(
                            width: containerHalfWidth,
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Policy End Date",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: HexColor("#008577"),
                              ),
                            )
                        ),
                      ],
                    ),

                    SizedBox(height: 2.0,),

                    /// Data picker start and end
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        GestureDetector(
                          child: Container(
                            height: 45.0,
                            width: containerHalfWidth,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                            child: Container(
                              height: 45.0,
                              width: containerHalfWidth,
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 45.0,
                                      width: 40.0,
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        color: HexColor("#f2f2f2"),
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          size: 15.0,
                                        ),
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2222)
                                          ).then((date) {
                                            setState(() {
                                              formattedDate = dateFormat.format(date);
                                              print("Formatted date is: $formattedDate");
                                              newDate = new DateTime(date.year + 1, date.month, date.day);
                                              newDateFormat = dateFormat.format(newDate);
                                              print("new Date is: $newDate");
                                            });
                                          });
                                        },
                                      ),
                                    ),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),

                                      child: Text(formattedDate == null ? "Picked Date" : formattedDate.toString(),
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),

                                  ]),
                            ),
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2222)
                            ).then((date) {
                              setState(() {
                                formattedDate = dateFormat.format(date);
                                print("Formatted date is: $formattedDate");
                                newDate = new DateTime(date.year + 1, date.month, date.day);
                                newDateFormat = dateFormat.format(newDate);
                                print("new Date is: $newDate");
                              });
                            });
                          },
                        ),

                        SizedBox(width: 10.0,),

                        Container(
                          height: 45.0,
                          width: containerHalfWidth,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Text(newDateFormat == null ? "Select Date" : newDateFormat),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.0,),

                    /// Button Get Quote
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: containerHalfWidth,
                              child: RaisedButton(
                                  color: HexColor("#F9A825"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)),
                                  child: Text(
                                    "Get Quote",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      checkValidity();
                                    });
                                  })
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

  void checkValidity() {
    if (planListItem == null) {
      customToast("Select Plan");
    } else if (subTypeListItem == null) {
      customToast("Select Sub Type");
    } else if (vehiclesTypeListItem == null) {
      customToast("Select Vehicles Type");
    } else if (driverSelectItem == null) {
      customToast("Select Driver");
    } else if (capacityController.text.toString() == '') {
      customToast("Enter Capacity");
    } else if (formattedDate == null) {
      customToast("Select Date");
    } else if (helperFlag > 0 &&
        passengerFlag > 0 &&
        helperSelectItem == null &&
        passengerSelectItem == null) {
      customToast("Select Helper and Passenger");
    } else if (helperFlag == 0 &&
        passengerFlag > 0 &&
        passengerSelectItem == null) {
      customToast("Select Passenger");
    } else if (helperFlag > 0 &&
        passengerFlag == 0 &&
        helperSelectItem == null) {
      customToast("Select Helper");
    } else {
      getQuote();
    }
  }

  void getQuote() {
    EasyLoading.show();
    String _typeId = '1', _subTypeId = '2';
    passengerId = new List();
    passengerNo = new List();
    for (int i = 1; i < 5; i++) {
      passengerId.add(i);
    }
    int conDriver, conPassenger, conHelper, conContactor;
    conDriver = int.parse(driverSelectId);
    conPassenger = int.parse(passengerSelectId);
    conHelper = int.parse(helperSelectId);
    conContactor = int.parse(contactorSelectId);
    passengerNo.add(conDriver);
    passengerNo.add(conHelper);
    passengerNo.add(conContactor);
    passengerNo.add(conPassenger);

    setState(() {
      print(
          "planId: $planId, typeId: $_typeId, subTypeId: $_subTypeId, vehiclesId: $vehiclesTypeId, passengerId: ${passengerId.toString()}, "
          "passengerNo: ${passengerNo.toString()}, cc: ${capacityController.text.toString()}, carPrice: "
          "${carPriceController.text.toString()}, facility: ${facilityIdList.toString()}");

      getQuotePost(planId, _typeId, _subTypeId, vehiclesTypeId, passengerId.toString(), passengerNo.toString(),
          capacityController.text.toString(), carPriceController.text.toString(), facilityIdList.toString());
    });
  }

  void customList(List<Seat> vehiclesSeatList) {
    customDriverList = new List();
    customHelperList = new List();
    customPassengerList = new List();
    passengerSeatList = new List();

    for (Seat s in vehiclesSeatList) {
      if (s.name.toString() == "Name.DRIVER") {
        print("name: ${s.name.toString()}");
        driverSelectId = s.id.toString();
        print("helperSelectId is: $helperSelectId");
        setState(() {
          EasyLoading.dismiss();
          customDriverList.add(s);
        });
      } else if (s.name.toString() == "Name.HELPER") {
        helperFlag++;
        print("name: ${s.name.toString()}");
        helperSelectId = s.id.toString();
        print("helperSelectId is: $helperSelectId");
        setState(() {
          EasyLoading.dismiss();
          customHelperList.add(s);
        });
      } else if (s.name.toString() == "Name.PASSENGER") {
        passengerFlag++;
        print("name: ${s.name.toString()}");
        passengerSelectId = s.id.toString();
        print("passengerSelectId is: $passengerSelectId");
        String itemlength;
        setState(() {
          EasyLoading.dismiss();
          customPassengerList.add(s);
          // ignore: missing_return
          customPassengerList.map<String>((_item) {
            itemlength = _item.maxCapacity;
            print("Passenger item: $itemlength");
          }).toString();
          for (int i = 1; i <= int.parse(itemlength); i++) {
            passengerSeatList.add(i);
          }
        });
      }
    }
  }

  void saveDataSP() async {
    /// EVI (Enter Vehicles Information)
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("EVI_plan_type", planListItem.toString());
    preferences.setString("EVI_plan_sub_type", subTypeListItem.toString());
    preferences.setString("EVI_vehicles_type", vehiclesTypeListItem.toString());
    preferences.setString("EVI_driver", driverSelectItem.toString());
    preferences.setString("EVI_capacity", capacityController.text.toString());

    if (helperSelectItem == null) {
      helperSelectItem = "0";
      print("pass helper zero: $helperSelectItem");
    } else {
      preferences.setString("EVI_helper", helperSelectItem.toString());
      print("pass helper: $helperSelectItem");
    }
    if (passengerSelectItem == null) {
      passengerSelectItem = "0";
      print("pass helper: $passengerSelectItem");
    } else {
      preferences.setString("EVI_passenger", passengerSelectItem.toString());
      print("pass helper: $passengerSelectItem");
    }
    preferences.setString("EVI_start_date", formattedDate.toString());
    preferences.setString("EVI_end_date", newDateFormat.toString());
    preferences.setString("EVI_car_price", carPriceController.text.toString());
    preferences.setString("EVI_total_cast", totalCast.toString());
    print("pass Amount $totalCast");
    preferences.commit();
  }
}
