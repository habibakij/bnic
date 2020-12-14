
///CREATED BY AK IJ
///25-11-2020

import 'dart:async';
import 'dart:io';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';

class PaymentPage extends StatefulWidget {
  String paymentPageUrl;
  PaymentPage(this.paymentPageUrl);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  Completer<WebViewController> _controller= new Completer<WebViewController>();

  var _done;
  @override
  void initState() {
    _done= false;
    // TODO: implement initState
    print("check comcplete ${_controller.isCompleted}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("check comcplete 22 ${_controller.isCompleted}");
    return WillPopScope(

      onWillPop: _willPopCallback,

      child: Scaffold(

        appBar: AppBar(
          backgroundColor: HexColor("#F9A825"),
          title: Text(
            "Payment",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget> [
            Container(
              width: 70.0,
              child: Center(
                child: CountdownFormatted(
                  duration: Duration(minutes: 5),
                  onFinish: (){
                    _done= true;
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  builder: (BuildContext ctx, String remaining) {
                    return Text(
                      _done ? 'Finish' : "Remain time \n \t \t $remaining",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ); // 01:00:00
                  },
                ),
              ),
            ),
          ],
        ),

        body: SafeArea(
            child: WebView(
              initialUrl: widget.paymentPageUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                setState(() {
                  print("check comcplete ${_controller.isCompleted}");
                });
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

}

