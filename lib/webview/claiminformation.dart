import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClaimInformation extends StatefulWidget {
  @override
  _ClaimInformationState createState() => _ClaimInformationState();
}

class _ClaimInformationState extends State<ClaimInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Claim Information",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: ("https://bnicl.net/claim-information/"),
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
