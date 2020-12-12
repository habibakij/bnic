/// created by AK IJ
/// 22-11-2020
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'overseasconformation.dart';

class OmihInfoEntry extends StatefulWidget {
  @override
  _OmihInfoEntryState createState() => _OmihInfoEntryState();
}

class _OmihInfoEntryState extends State<OmihInfoEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Overseas Medical Insurance (Health)",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),

      body: containerBody(),
    );
  }
}

class containerBody extends StatefulWidget {
  @override
  _containerBodyState createState() => _containerBodyState();
}

class _containerBodyState extends State<containerBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController countryController = TextEditingController();

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

  int cityFlag=0, categoryFlag=0;

  ///select city get request area
  var cityList;
  var cityListItem;
  var getCityListId;
  String getCityListUrl = 'http://online.bnicl.net/api/city/list';
  Future<String> getCityList() async {
    var response = await http.get(getCityListUrl);

    if(response.statusCode == 200){
      var decode = json.decode(response.body);
      setState(() {
        cityList= decode['list'];
      });
      print("City list are: $cityList");
    } else{
      customToast("Server Response Error");
    }

  }

  ///select category area
  var categoryList= ["Select category", "Medical", "Non Medical"];
  var categoryListItem= "Select category";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();
  }

  var mediaQueryWidth;
  double mainContainerWidth, mainContainerWidthWP, stackFirstContainer, stackSecondContainer, containerHalfWidth, containerHalfWidthWP;
  Orientation orientation;
  double landStackContainer, landStackContainer1, landStackHalfContainer, landStackHalfContainer1, stackHalfContainer, stackHalfContainer1;

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
          child: Container(
            color: HexColor("f2f2f2"),
            width: mainContainerWidth,
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  height: 40.0,
                  width: mainContainerWidth,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Text("Personal Information",
                      style: TextStyle(
                        fontSize: 16.0,
                      )
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("Full Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  alignment: Alignment.center,
                  child: TextField(
                    //maxLines: 1,
                    autocorrect: false,
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
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

                SizedBox(height: 10.0,),

                Text("Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
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

                SizedBox(height: 10.0,),

                Text("City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                Stack(children: <Widget>[

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
                              color: HexColor("#ffffff"),
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
                                value: cityListItem,

                                onChanged: (_newItem){
                                  setState(() {
                                    cityFlag++;
                                    cityListItem= _newItem;
                                    getCityList();
                                    print("City item: $cityListItem");
                                  });
                                },

                                items: cityList?.map<DropdownMenuItem<String>>((_item){
                                  return DropdownMenuItem(
                                    child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                    value: _item['name'].toString(),
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

                SizedBox(height: 10.0,),

                Text("Mobile", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: 'Mobile',
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

                SizedBox(height: 10.0,),

                Text("Email", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
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

                SizedBox(height: 10.0,),

                Text("Passport Number", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: passportController,
                    decoration: InputDecoration(
                      hintText: 'Passport',
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

                SizedBox(height: 10.0,),

                Text("Category", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Stack(children: <Widget> [

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
                              color: HexColor("#ffffff"),
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
                                  hint: Text("Select Category"),
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconSize: 18,
                                  elevation: 16,
                                  iconEnabledColor: Colors.amber[900],
                                  style: TextStyle(color: Colors.black, fontSize: 12.0,),
                                  value: categoryListItem,

                                  onChanged: (_newItem){
                                    setState(() {
                                      categoryFlag++;
                                      categoryListItem = _newItem;
                                    });
                                  },

                                  items: categoryList?.map<DropdownMenuItem<String>>((_item){
                                    return DropdownMenuItem(
                                      child: Text(_item),
                                      value: _item,
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

                SizedBox(height: 10.0,),

                Text("Visited Country", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

                SizedBox(height: 2.0,),

                Container(
                  height: 45.0,
                  child: TextField(
                    maxLines: 1,
                    autocorrect: false,
                    controller: countryController,
                    decoration: InputDecoration(
                      hintText: 'Country',
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

                SizedBox(height: 20.0,),

                /// RaisedButton
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
                        onPressed: (){
                          checkValidity();
                        },
                      ),
                    ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkValidity(){
    if(nameController.text.isEmpty){
      customToast("Enter Full Name");
    } else if(addressController.text.isEmpty){
      customToast("Enter Address");
    } else if(mobileController.text.isEmpty){
      customToast("Enter Mobile Number");
    } else if(emailController.text.isEmpty){
      customToast("Enter Email");
    } else if(passportController.text.isEmpty){
      customToast("Enter Password");
    } else if(countryController.text.isEmpty){
      customToast("Enter Visited Country");
    } else if(cityFlag == 0){
      customToast("Select Your City");
    } else if(categoryFlag == 0){
      customToast("Select Category");
    } else{
      saveDate();
      customToast("data saved successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OverseasConformation()));
    }
  }

  saveDate() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString("fullName", nameController.text.toString());
    preferences.setString("address", addressController.text.toString());
    preferences.setString("mobile", mobileController.text.toString());
    preferences.setString("email", emailController.text.toString());
    preferences.setString("password", passportController.text.toString());
    preferences.setString("country", countryController.text.toString());
    preferences.setString("selectedCity", cityListItem.toString());
    preferences.setString("selectedCategory", categoryListItem.toString());
    preferences.commit();
  }
}

