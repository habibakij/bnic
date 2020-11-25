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

import 'confirmation.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  child: Text("Personal Information",
                      style: TextStyle(
                        fontSize: 16.0,
                      )),
                ),

                SizedBox(height: 10.0,),

                Text("Full Name", style: TextStyle(fontSize: 12.0,)),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  child: TextField(
                    maxLines: 1,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("Address", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  child: TextField(
                    maxLines: 1,
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("City", style: TextStyle(fontSize: 12.0,),),

                Stack(children: <Widget>[

                  Container(
                    height: 40.0,
                    width: 304.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 260.0,
                        ),
                        Container(
                          width: 44.0,
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    child: Container(
                      height: 40.0,
                      child: Row(
                        children: <Widget> [
                          Container(
                            width: 304.0,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text("Select City"),
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 18,
                                elevation: 16,
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

                Text("Mobile", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 60.0,
                  child: TextField(
                    maxLines: 1,
                    maxLength: 11,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("Email", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  child: TextField(
                    maxLines: 1,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        width: 160.0,
                        child: Text(
                          "Passport Number",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: 140.0,
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        )),
                  ],
                ),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  width: 300.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        width: 145.0,
                        child: TextField(
                          maxLines: 1,
                          controller: passportController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Passport Number',
                          ),
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),

                      SizedBox(width: 10.0,),

                      Container(
                        width: 145.0,
                        child: Stack(children: <Widget> [

                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 105.0,
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
                              decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 8.0, 0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("Select Category"),
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 18,
                                  elevation: 16,
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

                          ),

                        ]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("Visited Country", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  child: TextField(
                    maxLines: 1,
                    controller: countryController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Visited Country',
                    ),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),

                SizedBox(height: 20.0,),

                Container(
                  height: 40.0,
                  width: 300.0,
                  alignment: Alignment.center,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        width: 120.0,
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
                ),
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> confirmInformation()));
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

