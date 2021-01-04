
/// CREATED BY AK IJ
/// 30-11-2020

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'commercialconformation.dart';

class CarInfoEntry extends StatefulWidget {
  @override
  _CarInfoEntryState createState() => _CarInfoEntryState();
}

class _CarInfoEntryState extends State<CarInfoEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text("Motor Insurance Information Entry", style: TextStyle(fontSize: 14.0),),
      ),

      body: EnterDetails(),
    );
  }
}

class EnterDetails extends StatefulWidget {
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mailingAddressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController vehiclesBrandController = TextEditingController();
  TextEditingController regNumberController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController chassisController = TextEditingController();

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var formattedDate, newDateFormat, newDate;
  bool check= false;
  bool checkMailingAddress= true;

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

  /// Get City list from JSON
  var getMailingCityListItem;
  var getMailingCityListId;
  var getCityList;
  var getCityListItem;
  var getCityListId;
  String getCityListUrl= 'http://online.bnicl.net/api/city/list';
  Future<String> cityListRequest() async {
    var response = await http.get(getCityListUrl);
    if(response.statusCode == 200){
      var decode = json.decode(response.body);
      setState(() {
        getCityList= decode['list'];
      });
      print("City list are: $getCityList");
    } else{
      customToast("Server Response Error");
    }
  }

  /// Get Year list from JSON
  var getYearList;
  var getYearListItem;
  String getYearListUrl= 'http://online.bnicl.net/api/mfg-year/list';
  Future<String> yearListRequest() async {
    var response = await http.get(getYearListUrl);
    if(response.statusCode == 200){
      var decode = json.decode(response.body);
      setState(() {
        getYearList= decode['list'];
      });
      print("City list are: $getYearList");
    } else{
      customToast("Server Response Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cityListRequest();
    yearListRequest();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    mailingAddressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    vehiclesBrandController.dispose();
    regNumberController.dispose();
    engineController.dispose();
    chassisController.dispose();
  }

  var mediaQueryWidth;
  int checkBoxCount= 0;
  double mainContainerWidth, mainContainerWidthWP, stackFirstContainer, stackSecondContainer, containerHalfWidth, containerHalfWidthWP, stackHalfContainer, stackHalfContainer1;
  Orientation orientation;
  double landStackContainer, landStackContainer1, landStackHalfContainer, landStackHalfContainer1;

  @override
  Widget build(BuildContext context) {

    mediaQueryWidth = MediaQuery.of(context).size.width;
    mainContainerWidth = ((mediaQueryWidth / 100.0) * 90.0);
    mainContainerWidthWP = mainContainerWidth - 18.0;

    stackFirstContainer = ((mainContainerWidthWP / 100.0) * 87.0);
    stackSecondContainer = ((mainContainerWidthWP / 100.0) * 13.0);
    containerHalfWidth = ((mainContainerWidthWP / 2) - 4);
    containerHalfWidthWP = (containerHalfWidth - 2);

    landStackHalfContainer = ((containerHalfWidthWP / 100.0) * 87.00);
    landStackHalfContainer1 = ((containerHalfWidthWP / 100.0) * 13.00);
    stackHalfContainer = ((containerHalfWidthWP / 100.0) * 75.00);
    stackHalfContainer1 = ((containerHalfWidthWP / 100.0) * 25.00);

    landStackContainer = ((mainContainerWidthWP / 100.0) * 93.0);
    landStackContainer1 = ((mainContainerWidthWP / 100.0) * 07.0);
    orientation = MediaQuery.of(context).orientation;

    return SingleChildScrollView(
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
              children: <Widget> [

                /// Title information
                Container(
                  height: 40.0,
                  width: mainContainerWidth,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Text("Personal Information",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HexColor("#008577"),
                      )),
                ),

                SizedBox(height: 15.0,),

                Text("Insured Full Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                SizedBox(height: 5.0,),

                /// Insured name TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Insured name same as brta registration',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Insured Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Insured address TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// City Dropdown List
                Stack(children: <Widget>[

                  Builder(builder: (context) {
                    if (orientation.index == Orientation.landscape.index) {
                      return Container(
                        height: 40.0,
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
                        height: 40.0,
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
                      height: 40.0,
                      child: Row(
                        children: <Widget> [
                          Container(
                            width: mainContainerWidthWP,
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text("Select City"),
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 18,
                                elevation: 16,
                                iconEnabledColor: Colors.amber[900],
                                style: TextStyle(color: Colors.black),
                                value: getCityListItem,

                                onChanged: (_newItem){
                                  setState(() {
                                    getCityListItem= _newItem;
                                    cityListRequest();
                                    print("City item: $getCityListItem");
                                  });
                                },

                                items: getCityList?.map<DropdownMenuItem<String>>((_item){
                                  return DropdownMenuItem<String>(
                                    child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                    value: _item['name'].toString(),
                                    onTap: (){
                                      getCityListId= _item['id'].toString();
                                    },
                                  );
                                })?.toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ]),

                SizedBox(height: 5.0,),

                /// Checkbox and text for same as insured city, address
                Container(
                  height: 40.0,
                  width: mainContainerWidth,
                  child: Row(
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
                              if(check == true){
                                checkMailingAddress= false;
                              } else {
                                checkMailingAddress= true;
                              }
                              print("Check Box value: $check");
                            });
                          },
                        ),
                      ),

                      SizedBox(width: 10.0,),

                      GestureDetector(
                        child: Container(
                          child: Text(
                            "Insured and Mailing Address are same ?",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            checkBoxCount++;
                            print("checkBoxCount: $checkBoxCount");
                            if((checkBoxCount % 2) != 0){
                              check = true;
                              print("checkBoxCount_if: $check");
                            } else {
                              check = false;
                              print("checkBoxCount_else: $check");
                            }
                          });
                        },
                      ),

                    ],
                  ),
                ),

                Visibility(
                  visible: checkMailingAddress,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [

                      Text("Mailing Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                      SizedBox(height: 5.0,),

                      /// Mailing address textField
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                        child: TextField(
                          maxLines: 1,
                          autocorrect: false,
                          controller: mailingAddressController,
                          decoration: InputDecoration(
                            hintText: 'Mailing address',
                            filled: true,
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 15.0,),
                        ),
                      ),

                      SizedBox(height: 15.0,),

                      Text("Mailing City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                      /// Mailing city spinner dropdown
                      Stack(children: <Widget>[

                        Builder(builder: (context) {
                          if (orientation.index == Orientation.landscape.index) {
                            return Container(
                              height: 40.0,
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
                              height: 40.0,
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
                            height: 40.0,
                            child: Row(
                              children: <Widget> [
                                Container(
                                  width: mainContainerWidthWP,
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text("Mailing City"),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      iconSize: 18,
                                      elevation: 16,
                                      iconEnabledColor: Colors.amber[900],
                                      style: TextStyle(color: Colors.black),
                                      value: getMailingCityListItem,
                                      onChanged: (_newItem){
                                        setState(() {
                                          getMailingCityListItem= _newItem;
                                          print("Maling City item: $getMailingCityListItem");
                                        });
                                      },

                                      items: getCityList?.map<DropdownMenuItem<String>>((_item){
                                        return DropdownMenuItem(
                                          child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                          value: _item['name'].toString(),
                                          onTap: (){
                                            getMailingCityListId= _item['id'].toString();
                                          },
                                        );
                                      })?.toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ]),

                    ],
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Mobile", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Mobile TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: '01717 - 722666',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Email", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                ///Email TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Vehicles Brand/Make", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Brand TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: vehiclesBrandController,
                    decoration: InputDecoration(
                      hintText: 'Vehicles brand/make',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                ///Manufacture year Registration Date text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Container(
                        alignment: Alignment.centerLeft,
                        width: containerHalfWidth,
                        child: Text(
                          "Year of Manufacture",
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
                          "Registration Date",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: HexColor("#008577"),
                          ),
                        )
                    ),

                  ],
                ),

                SizedBox(height: 5.0,),

                ///Manufacture year Registration Date Spinner
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [

                    Container(
                      width: containerHalfWidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: Stack(
                        children: <Widget> [

                          Builder(builder: (context) {
                            if (orientation.index == Orientation.landscape.index) {
                              return Container(
                                height: 40.0,
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
                                height: 40.0,
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
                                height: 40.0,
                                child: Row(
                                  children: <Widget> [
                                    Container(
                                      width: containerHalfWidthWP,
                                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                                      alignment: Alignment.centerRight,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("Years"),
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          iconSize: 18,
                                          elevation: 16,
                                          iconEnabledColor: Colors.amber[900],
                                          style: TextStyle(color: Colors.black),
                                          value: getYearListItem,
                                          onChanged: (_newSelected){
                                            setState(() {
                                              getYearListItem= _newSelected;
                                              yearListRequest();
                                              print("year select is: $getYearListItem");
                                            });
                                          },

                                          items: getYearList?.map<DropdownMenuItem<String>>((_item){
                                            return DropdownMenuItem<String>(
                                                child: Text(
                                                  _item['year'].toString(),
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              value: _item['year'].toString(),
                                            );
                                          })?.toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ]
                      ),
                    ),

                    SizedBox(width: 10.0,),

                    Container(
                      width: containerHalfWidth,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                      child: GestureDetector(

                        child: Container(
                          height: 40.0,
                          width: containerHalfWidth,
                          color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  child: RaisedButton(
                                    color: HexColor("#f2f2f2"),
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 15.0,
                                    ),
                                    onPressed: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2222)
                                      ).then((date) {
                                        setState(() {
                                          formattedDate = dateFormat.format(date);
                                          print("Formatted date is: $formattedDate");
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
                                    style: TextStyle(fontSize: 12.0,),
                                  ),
                                ),

                              ]
                          ),
                        ),

                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2222)
                          ).then((date) {
                            setState(() {
                              formattedDate = dateFormat.format(date);
                              print("Formatted date is: $formattedDate");
                            });
                          });
                        },

                      ),
                    ),

                  ],
                ),

                SizedBox(height: 15.0,),

                Text("Registration Number", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Registration number TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: regNumberController,
                    decoration: InputDecoration(
                      hintText: 'Registration number',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Engine Number", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Engine Number TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: engineController,
                    decoration: InputDecoration(
                      hintText: 'Engine number',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 15.0,),

                Text("Chassis No", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 5.0,),

                /// Chassis No TextField
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: chassisController,
                    decoration: InputDecoration(
                      hintText: 'Chassis no',
                      filled: true,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15.0,),
                  ),
                ),

                SizedBox(height: 30.0,),

                /// RaisingButton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      width: containerHalfWidth,
                      child: RaisedButton(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)
                        ),
                        child: Text("Next", style: TextStyle(fontSize: 16.0, color: Colors.black),),
                        onPressed: () {
                          if(checkMailingAddress == false){
                            mailingAddressController.text= addressController.text.toString();
                            getMailingCityListItem= getCityListItem;
                            print("mailingAddress is: ${mailingAddressController.text.toString()} "
                                "and mailingCity is: ${getMailingCityListItem.toString()}");
                          }
                          checkValidity();
                        },
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveDataSP() async {
    /// MIIE = commercial Motor Insurance Information Entry
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("MIIE_name", nameController.text.toString());
    preferences.setString("MIIE_address", addressController.text.toString());
    preferences.setString("MIIE_city", getCityListItem.toString());
    preferences.setString("MIIE_city_id", getCityListId.toString());
    preferences.setString("MIIE_mailing_address", mailingAddressController.text.toString());
    preferences.setString("MIIE_mailing_city", getMailingCityListItem.toString());
    preferences.setString("MIIE_mailing_city_id", getCityListId.toString());
    preferences.setString("MIIE_mobile", mobileController.text.toString());
    preferences.setString("MIIE_email", emailController.text.toString());
    preferences.setString("MIIE_vehicles_brand", vehiclesBrandController.text.toString());
    preferences.setString("MIIE_year", getYearListItem.toString());
    preferences.setString("MIIE_registration_number", regNumberController.text.toString());
    preferences.setString("MIIE_registration_date", formattedDate.toString());
    preferences.setString("MIIE_engine_number", engineController.text.toString());
    preferences.setString("MIIE_chassis_no", chassisController.text.toString());
    preferences.commit();
  }

  void checkValidity(){
    if(nameController.text.toString() == ''){
      customToast("Enter Name");
    } else if(addressController.text.toString() == ''){
      customToast("Enter Address");
    } else if(mailingAddressController.text.toString() == ''){
      customToast("Enter Mailing Address");
    } else if(mobileController.text.toString() == ''){
      customToast("Enter Mobile");
    } else if(mobileController.text.length != 11){
      customToast("Make sure your mobile 11 digit");
    } else if(emailController.text.toString() == ''){
      customToast("Enter Email");
    } else if(vehiclesBrandController.text.toString() == ''){
      customToast("Enter Brand");
    } else if(regNumberController.text.toString() == ''){
      customToast("Enter Registration Number");
    } else if(engineController.text.toString() == ''){
      customToast("Enter Engine Number");
    } else if(chassisController.text.toString() == ''){
      customToast("Enter Chassis No");
    } else if(getCityListItem == null){
      customToast("Select City");
    } else if(getMailingCityListItem == null){
      customToast("Select Mailing City");
    } else if(getYearListItem == null){
      customToast("Select Year");
    } else if(formattedDate == null){
      customToast("Select Date");
    } else {
      saveDataSP();
      print("Data save successfully");
      Navigator.push(context, MaterialPageRoute (builder: (context) => commercialConformation()));
    }
  }

}
