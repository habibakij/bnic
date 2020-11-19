import 'dart:convert';

import 'package:bnic/Network/omihmodel.dart';
import 'package:bnic/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OMIH extends StatefulWidget {
  @override
  _OMIHState createState() => _OMIHState();
}

class _OMIHState extends State<OMIH> {
  var date = DateTime.parse("2019-04-16 12:18:06.018950");
  var formattedDate;
  var years;

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
  var quoteMax, quoteMin;
  var birthDate;
  String postGetQuoteUrl = 'http://online.bnicl.net/api/omp/price-quote';
  Future<String> postGetQuote(var getTypeID, var getCategoryID, var max, var min) async {
    print("get_type_id: $getTypeID");
    print("get_category_id: $getCategoryID");
    await http.post(postStayPeriodUrl, body: {
      'type_id': '4',
      'sub_type_id': getTypeID,
      'category_id': getCategoryID,
      'dob': birthDate,
      'min_stay': min,
      'max_stay': max,
    }).then((response) {
      var decode = json.decode(response.body);
      setState(() {
        stayPeriodList = decode['list'];
      });
      print("Stay period area: $decode");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    postType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

      body: Center(
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
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Text(
                    "Please Enter OMP Information",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
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
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2001),
                                          lastDate: DateTime(2222))
                                      .then((date) {
                                    setState(() {
                                      formattedDate =
                                          "${date.day}-${date.month}-${date.year}";
                                      DateTime dob =
                                          DateTime.parse('1967-10-22');
                                      Duration dur =
                                          DateTime.now().difference(dob);
                                      years =
                                          (dur.inDays / 365).floor().toString();
                                    });
                                  });
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
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
                        years == null ? "select date" : years.toString(),
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
                                      quoteMax= _item['max_stay'].toString();
                                      quoteMin= _item['min_stay'].toString();
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
                          _showMyDialog();
                        }
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: Text('This is a demo alert dialog.'),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  },
                child: Text("OK")
            ),
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  },
                child: Text("CANCEL")
            ),
          ],
          //shape: CircleBorder(),
          backgroundColor: Colors.amberAccent,
        );
      },
    );
  }
}

