import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DirectorBoard extends StatefulWidget {
  @override
  _DirectorBoardState createState() => _DirectorBoardState();
}

class _DirectorBoardState extends State<DirectorBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Board of Director",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: ("https://bnicl.net/board-of-directors/"),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
}