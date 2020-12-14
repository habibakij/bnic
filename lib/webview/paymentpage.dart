
///CREATED BY AK IJ
///25-11-2020

import 'dart:async';
import 'dart:io';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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

  Completer<WebViewController> _controller = new Completer<WebViewController>();
  var _done;
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    _done = false;
    // TODO: implement initState
    print("check comcplete ${_controller.isCompleted}");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        actions: <Widget>[
          Container(
            width: 70.0,
            child: Center(
              child: CountdownFormatted(
                duration: Duration(minutes: 5),
                onFinish: () {
                  _done = true;
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

      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: Container(
            child: Column(children: <Widget>[

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0 ? LinearProgressIndicator(
                      value: progress, backgroundColor: Colors.amberAccent) : Container()
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: InAppWebView(
                    initialUrl: widget.paymentPageUrl,
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                        )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller,
                        String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller,
                        String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged: (InAppWebViewController controller,
                        int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),

            ])
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    bool canNavigate = await webView.canGoBack();
    if (canNavigate) {
      webView.goBack();
      return false;
    } else {
      return true;
    }
  }
}
