import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OmihInfoEntry extends StatefulWidget {
  @override
  _OmihInfoEntryState createState() => _OmihInfoEntryState();
}

class _OmihInfoEntryState extends State<OmihInfoEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Overseas Medical Insurance (Health)",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
