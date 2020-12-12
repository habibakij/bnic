
import 'dart:async';
/// CREATED BY AK IJ
/// 25-11-2020

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Management extends StatefulWidget {
  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: _willPopCallback,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#F9A825"),
          title: Text(
            "Management",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: ("https://bnicl.net/management-list/"),
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
