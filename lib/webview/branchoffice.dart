import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BranchOffice extends StatefulWidget {
  @override
  _BranchOfficeState createState() => _BranchOfficeState();
}

class _BranchOfficeState extends State<BranchOffice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Branch Office",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: ("https://bnicl.net/branches-office/"),
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
