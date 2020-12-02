
///CREATED BY AK IJ
///25-11-2020

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  String paymentPageUrl;
  PaymentPage(this.paymentPageUrl);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor("#F9A825"),
        title: Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: WebView(
          initialUrl: (widget.paymentPageUrl),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

}
