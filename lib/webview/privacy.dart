
/// CREATED BY AK IJ
/// 25-11-2020

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  Completer<WebViewController> _controller = Completer<WebViewController>();

  String webViewPrivacyUrl= "https://drive.google.com/file/d/1y3FvlJwrdU1RGsdKX9g0tbPrZsL0WFX1/view";
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: _willPopCallback,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#F9A825"),
          title: Text(
            "Privacy Policy",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: (webViewPrivacyUrl),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

}
