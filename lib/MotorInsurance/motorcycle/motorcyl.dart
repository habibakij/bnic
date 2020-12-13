
///CREATED BY AK IJ
///25-11-2020

import 'dart:convert';
import 'package:bnic/Network/omihmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'motorinfoentry.dart';

class MotorCycle extends StatefulWidget {
  @override
  _MotorCycleState createState() => _MotorCycleState();
}

class _MotorCycleState extends State<MotorCycle> {
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
    EasyLoading.show();
    var response = await http.get(getPlanListUrl);
    if(response.statusCode == 200){
      var decode = json.decode(response.body);
      setState(() {
        EasyLoading.dismiss();
        planList= decode['list'];
      });
      print("Plan list are: $planList");
    } else{
      customToast("Server Response Error");
    }
  }

  /// Vehicles type area
  List driverList;
  String driverSelectId;
  String driverSelectItem;
  List passengerList;
  String passengerSelectId;
  String passengerSelectItem;
  List passengerSeatList;
  int listCount= 0;
  List<ListElement> vehiclesTypeList;
  List<Seat> vehiclesSeatList;
  String vehiclesTypeListItem;
  String vehiclesTypeListId;
  String getVehiclesTypeListUrl = 'http://online.bnicl.net/api/vehicle-type/list';
  Future<String> getVehiclesTypeList() async {
    await http.post(getVehiclesTypeListUrl, body: {
      'type_id': '1',
      'sub_type_id': '1',
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        OverseasJsonModel.fromJson(decode);
        OverseasJsonModel overseasJsonModel = OverseasJsonModel.fromJson(decode);
        vehiclesTypeList = overseasJsonModel.list.toList();
        listCount = vehiclesTypeList.length;
      });
      print("Vehicles area: $vehiclesTypeList");
      print("Vehicles count: $listCount");
    });
  }

  /// Get Quote area
  List<int> passengerNo, passengerId;
  List terrifList;
  String totalCast;
  String getQuotePostUrl= 'http://online.bnicl.net/api/motor/price-quote';
  int trLength= 0;
  Future<String> getQuotePost(String planId, String typeId, String subTypeId, String vehiclesTypeId, String passengerId,
      String passengerNo, String capacity) async {
    terrifList= new List();
    await http.post(getQuotePostUrl, body: {
      'plan_id': planId,
      'type_id': typeId,
      'sub_type_id': subTypeId,
      'vtype': vehiclesTypeId,
      'passenger_id': passengerId.toString(),
      'passenger_no': passengerNo.toString(),
      'cc': capacity,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        EasyLoading.dismiss();
        terrifList= decode['terrif'];
        totalCast= decode['total_cost'];
        trLength= terrifList.length == null ? 0 : terrifList.length;

        if(trLength > 0){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text(
                'Motor Insurance Quotation',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),

              contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
              //contentPadding: EdgeInsets.all(0.0),

              content: Container(
                height: 200.0,
                child: ListView.builder(
                  itemCount: trLength,
                  itemBuilder: (ctx, index){

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
                              style: TextStyle(fontSize: 12.0,),
                            ),
                          ),
                        ],
                      ),
                    );

                  },
                ),
              ),

              actions: <Widget> [

                Container(
                  width: 300.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [

                      Container(
                        width: 120.0,
                        child: RaisedButton(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.red)
                          ),
                          child: Text("Go Back", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                          onPressed: (){
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
                          child: Text("Buy Insurance", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                          onPressed: (){
                            saveDataSP();
                            print("data save successfully");
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MotorInformationEntry()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            );
          });
        } else{
          EasyLoading.dismiss();
          customToast("length null");
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
                      height: 45.0,
                      width: mainContainerWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: Stack(
                        children: <Widget>[

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
                                      iconSize: 18,
                                      elevation: 16,
                                      iconEnabledColor: Colors.amber[900],
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
                                          onTap: (){
                                            getPlanId= _item['id'].toString();
                                            getVehiclesTypeList();
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
                                    height: 45.0,
                                    width: (landStackContainer),
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      vehiclesTypeListItem == null ? "Vehicle Type" : vehiclesTypeListItem,
                                      style: TextStyle(
                                        fontSize: 12.0,
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
                                      vehiclesTypeListItem == null ? "Vehicle Type" : vehiclesTypeListItem,
                                      style: TextStyle(
                                        fontSize: 12.0,
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
                                        vehiclesTypeListItem= _newSelected;
                                      });
                                    },
                                    items: vehiclesTypeList?.map<DropdownMenuItem<String>>((_item){
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                            _item.name.toString(),
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                        value: _item.name.toString(),
                                        onTap: (){
                                            vehiclesTypeListId= _item.id.toString();
                                            vehiclesSeatList= _item.seat;
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

                    /// Driver and Capacity(cc/ton) text in row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
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
                            alignment: Alignment.centerLeft,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          height: 45.0,
                          width: containerHalfWidth,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                          child: Stack(
                            children: <Widget> [

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
                                    children: <Widget> [
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
                                            style: TextStyle(color: Colors.black),
                                            value: driverSelectItem,
                                            onChanged: (_newSelected) {
                                              setState(() {
                                                driverSelectItem= _newSelected;
                                              });
                                            },
                                            items: driverList?.map<DropdownMenuItem<String>>((_item){
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
                              hintText: 'Capacity (cc/ton)',
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

                    Text("Passenger", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

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
                                    hint: Text("Select Period"),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.amber[900],
                                    style: TextStyle(color: Colors.black),
                                    value: passengerSelectItem,
                                    onChanged: (_newSelected) {
                                      setState(() {
                                        passengerSelectItem= _newSelected;
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
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
                            alignment: Alignment.centerLeft,
                            width: containerHalfWidth,
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [

                        GestureDetector(

                          child: Container(
                            height: 45.0,
                            width: containerHalfWidth,
                            alignment: Alignment.centerLeft,
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
                                          Icons.calendar_today,
                                          size: 15.0,
                                        ),
                                        onPressed: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2225)
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
                                  ]
                              ),
                            ),
                          ),

                          onTap: (){
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2225)
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

                        SizedBox(width: 10.0,),

                        Container(
                          height: 45.0,
                          width: containerHalfWidth,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                          child: Container(
                            height: 45.0,
                            width: containerHalfWidthWP,
                            alignment: Alignment.centerLeft,
                            color: HexColor("#f5f5f5"),
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
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

                    SizedBox(height: 15.0,),

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
                                    side: BorderSide(color: Colors.red)
                                ),
                                child: Text(
                                  "Get Quote",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    validity();
                                  });
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
      ),
    );
  }

  void customList(List<Seat> vehiclesSeatList) {
    driverList= new List();
    passengerList= new List();
    passengerSeatList= new List();

    for(Seat s in vehiclesSeatList){
      if (s.name.toString() == "Name.DRIVER") {
        print("name: ${s.name.toString()}");
        driverSelectId= s.id.toString();
        print("driverSelectId is: $driverSelectId");
        setState(() {
          driverList.add(s);
        });
      } else if (s.name.toString() == "Name.PASSENGER") {
        print("name: ${s.name.toString()}");
        passengerSelectId= s.id.toString();
        print("passengerSelectId is: $passengerSelectId");
        String itemLength;
        setState(() {
          passengerList.add(s);
          // ignore: missing_return
          passengerList.map<String>((_item) {
            itemLength = _item.maxCapacity;
            print("Passenger item length: $itemLength");
          }).toString();
          for (int i = 1; i <= int.parse(itemLength); i++) {
            passengerSeatList.add(i);
          }
        });
      }
    }

  }

  void validity() {
    if(planListItem == null){
      customToast("Select Plan Type");
    } else if(vehiclesTypeListItem == null){
      customToast("Select Vehicles Type");
    } else if(driverSelectItem == null){
      customToast("Select Driver");
    } else if(capacityController.text.toString() == ''){
      customToast("Enter Capacity");
    } else if(passengerSelectItem == null){
      customToast("Select Passenger");
    } else if(formattedDate == null){
      customToast("Select Date Time");
    } else{
      getQuote();
    }
  }

  void getQuote(){
    EasyLoading.show();
    passengerId= new List();
    passengerNo= new List();
    for(int i=1; i<5; i++) {
      passengerId.add(i);
    }
    int conDriver, conPassenger, conHelper= 0, conContactor= 0;
    conDriver= int.parse(driverSelectId);
    conPassenger= int.parse(passengerSelectId);
    passengerNo.add(conDriver);
    passengerNo.add(conHelper);
    passengerNo.add(conContactor);
    passengerNo.add(conPassenger);

    getQuotePost(getPlanId, '1', '1', vehiclesTypeListId, passengerId.toString(),
        passengerNo.toString(), capacityController.text.toString());
  }

  void saveDataSP() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("M_plan_type", planListItem.toString());
    preferences.setString("M_vehicles_type", vehiclesTypeListItem.toString());
    preferences.setString("M_driver", driverSelectItem.toString());
    preferences.setString("M_capacity", capacityController.text.toString());
    preferences.setString("M_passenger", passengerSelectItem.toString());
    preferences.setString("M_po_start_date", formattedDate.toString());
    preferences.setString("M_po_end_date", newDateFormat.toString());
    preferences.setString("M_total_cast", totalCast.toString());
    preferences.commit();
  }

}

