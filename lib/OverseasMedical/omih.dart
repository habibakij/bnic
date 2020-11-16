import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class OMIH extends StatefulWidget {
  @override
  _OMIHState createState() => _OMIHState();
}

class _OMIHState extends State<OMIH> {
  var _selectList = ["5","Type", "one", "two", "three", "four"];
  var _selectItem = "5";

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

                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                  child: Text(
                    "Please Enter OMP Information",
                    style: TextStyle(fontSize: 16.0,),
                  ),
                ),

                SizedBox(height: 10.0,),

                Text("Type", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                  child: Row(
                    children: <Widget>[

                      Container(
                          width: 230.0,
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: Text(_selectItem)
                      ),

                      Container(
                        width: 60.0,
                        color: Colors.amberAccent,
                        alignment: Alignment.centerRight,

                        child: DropdownButton<String>(
                          items: _selectList.map((String _currentSelected) {
                            return DropdownMenuItem<String>(
                              value: _currentSelected,
                              child: Text(_currentSelected, style: TextStyle(fontSize: 12.0),),
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

                    ]
                  ),

                ),

                SizedBox(height: 10.0,),

                Text("Category", style: TextStyle(fontSize: 12.0,),),

                SizedBox(height: 2.0,),

                Container(
                  height: 40.0,
                  width: 320.0,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black26)),

                  child: Row(
                      children: <Widget>[

                        Container(
                            width: 230.0,
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text(_selectItem)
                        ),

                        Container(
                          width: 60.0,
                          color: Colors.amberAccent,
                          alignment: Alignment.centerRight,

                          child: DropdownButton<String>(
                            items: _selectList.map((String _currentSelected) {
                              return DropdownMenuItem<String>(
                                value: _currentSelected,
                                child: Text(_currentSelected, style: TextStyle(fontSize: 12.0),),
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

                      ]
                  ),

                ),

                SizedBox(height: 10.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                    Container(
                        alignment: Alignment.centerLeft,
                        width: 150.0,
                        child: Text("Birth Date", style: TextStyle(fontSize: 12.0,),)
                    ),

                    Container(
                        alignment: Alignment.centerLeft,
                        width: 150.0,
                        child: Text("Age", style: TextStyle(fontSize: 12.0,),)
                    ),
                  ],
                ),

                SizedBox(height: 2.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                    Container(
                      height: 40.0,
                      width: 145.0,
                      color: Colors.amberAccent,
                      alignment: Alignment.centerLeft,
                      child: Text("Birth Date"),
                    ),

                    SizedBox(width: 10.0,),

                    Container(
                      height: 40.0,
                      width: 145.0,
                      color: Colors.amberAccent,
                      alignment: Alignment.centerLeft,
                      child: Text("Age"),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
