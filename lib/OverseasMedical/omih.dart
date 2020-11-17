import 'package:bnic/Network/omihmodel.dart';
import 'package:bnic/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OMIH extends StatefulWidget {
  @override
  _OMIHState createState() => _OMIHState();
}

Future<TypeModel> postType() async{
  String postTypeUrl= Constant.TYPE_LIST;

  final response= await http.post(postTypeUrl, body: {
    "type_id","4",
  });
  if(response.statusCode == 201){
    final String allDate= response.body;
    print(allDate);
    return typeModelFromJson(allDate);
  } else{
    return null;
  }
}


class _OMIHState extends State<OMIH> {
  Future<TypeModel> _future;
  var list;
  var _list= ["one","two","tree"];
  var _selectItem = "one";
  DateTime _dateTime;
  var date = DateTime.parse("2019-04-16 12:18:06.018950");
  var formattedDate;
  var years;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future= postType();
  }

  Future<void> getJsonTypeData () async {
    list.add("select type");
    TypeModel typeModel= await postType();
    int length= typeModel.list.length;
    for(int i=0; i<length; i++){
      list.add([i]);
    }
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
            padding: EdgeInsets.all(8.0),
            width: 320.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /*FutureBuilder<TypeModel>(
                  future: _future,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      int len= snapshot.data.list.length;
                      print(snapshot.data);
                      for(int i=0; i<len; i++){
                        list.add(snapshot.data.list[i].name);
                      }
                    }
                    return CircularProgressIndicator();
                  },
                ),*/

                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Text(
                    "Please Enter OMP Information",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Text(
                  "Type",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),

                SizedBox(
                  height: 2.0,
                ),

                /// select type spinner(dropdown list)
                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                  child: Row(children: <Widget>[

                    Container(
                        width: 257.0,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(_selectItem)),

                    Container(
                      width: 40.0,
                      color: Colors.amberAccent,
                      alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _list.map((String _currentSelected) {
                          return DropdownMenuItem<String>(
                            value: _currentSelected,
                            child: Text(
                              _currentSelected,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          );
                        }).toList(),

                        onChanged: (String _newSelected) {
                          setState(() {
                            this._selectItem = _newSelected;
                          });
                        },
                        //value: _selectItem,
                      ),
                    ),
                  ]),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),

                SizedBox(
                  height: 2.0,
                ),

                /// select category type spinner(dropdown list)
                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Row(
                      children: <Widget>[
                    Container(
                        width: 257.0,
                        color: Colors.white,
                        child: Text(_selectItem)),
                    Container(
                      width: 40.0,
                      color: Colors.amberAccent,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _list.map((String _currentSelected) {
                          return DropdownMenuItem<String>(
                            value: _currentSelected,
                            child: Text(
                              _currentSelected,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          );
                        }).toList(),
                        onChanged: (String _newSelected) {
                          setState(() {
                            this._selectItem = _newSelected;
                          });
                        },
                        //value: _selectItem,
                      ),
                    ),
                  ]),
                ),

                SizedBox(
                  height: 10.0,
                ),

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

                SizedBox(
                  height: 2.0,
                ),

                /// birth date picker and age calculate in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// Date Picker
                    Container(
                      height: 40.0,
                      width: 145.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              height: 39.0, width: 40.0,
                              child: RaisedButton(
                                child: Icon(Icons.calendar_today, size: 15.0,),
                                onPressed: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                      .then((date) {
                                        setState(() {
                                          formattedDate = "${date.day}-${date.month}-${date.year}";
                                          DateTime dob = DateTime.parse('1967-10-22');
                                          Duration dur =  DateTime.now().difference(dob);
                                          years= (dur.inDays/365).floor().toString();
                                        });
                                      });
                                  },
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                formattedDate == null ? "Picked Date":formattedDate.toString(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),

                      ]),
                    ),

                    SizedBox(
                      width: 10.0,
                    ),
                    /// Calculate year
                    Container(
                      height: 40.0,
                      width: 145.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Text(
                        years == null ? "select date":years.toString(),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Text(
                  "Stay Period (in day's)",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),

                SizedBox(
                  height: 2.0,
                ),

                /// select type spinner(dropdown list)
                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Row(children: <Widget>[
                    Container(
                        width: 257.0,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(_selectItem)),
                    Container(
                      width: 40.0,
                      color: Colors.amberAccent,
                      alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _list.map((String _currentSelected) {
                          return DropdownMenuItem<String>(
                            value: _currentSelected,
                            child: Text(
                              _currentSelected,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          );
                        }).toList(),
                        onChanged: (String _newSelected) {
                          setState(() {
                            this._selectItem = _newSelected;
                          });
                        },
                        //value: _selectItem,
                      ),
                    ),
                  ]),
                ),

                SizedBox(
                  height: 15.0,
                ),

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
                      onPressed: (){},
                    ),
                  ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
