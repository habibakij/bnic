/// CREATED BY AK IJ
/// 30-11-2020

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
        child: Container(
          width: 320.0,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [

              Container(
                height: 40.0,
                width: 320.0,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                child: Text("Personal Information",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: HexColor("#008577"),
                    )),
              ),

              SizedBox(height: 10.0,),

              Text("Insured Full Name", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),)),

              SizedBox(height: 2.0,),

              Container(
                height: 40.0,
                child: TextField(
                  maxLines: 1,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insured Name same as BRTA Registration',
                  ),
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              Text("Insured Address", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

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

              Text("City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

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

                              onChanged: (_newItem){
                                setState(() {
                                  /*cityFlag++;
                                  cityListItem= _newItem;
                                  getCityList();
                                  print("City item: $cityListItem");*/
                                });
                              },

                              items: [] /*cityList?.map<DropdownMenuItem<String>>((_item){
                                return DropdownMenuItem(
                                  child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                  value: _item['name'].toString(),
                                );
                              })?.toList(),*/
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ]),

              SizedBox(height: 10.0,),

              Text("Mailing City", style: TextStyle(fontSize: 12.0, color: HexColor("#008577"),),),

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
                                hint: Text("Mailing City"),
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 18,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),

                                onChanged: (_newItem){
                                  setState(() {
                                    /*cityFlag++;
                                  cityListItem= _newItem;
                                  getCityList();
                                  print("City item: $cityListItem");*/
                                  });
                                },

                                items: [] /*cityList?.map<DropdownMenuItem<String>>((_item){
                                return DropdownMenuItem(
                                  child: Text(_item['name'].toString(), style: TextStyle(fontSize: 12.0,),),
                                  value: _item['name'].toString(),
                                );
                              })?.toList(),*/
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ]),

              SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 160.0,
                      child: Text(
                        "Mobile",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: HexColor("#008577"),
                        ),
                      )
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 140.0,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: HexColor("#008577"),
                        ),
                      )
                  ),
                ],
              ),

              SizedBox(height: 2.0,),

              Row(),

            ],
          ),
        ),
      ),
    );
  }
}
