
///CREATED BY AK IJ
///25-11-2020

import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentPage extends StatefulWidget {
  String paymentPageUrl;
  PaymentPage(this.paymentPageUrl);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  var _done;
  @override
  void initState() {
    super.initState();
    _done = false;
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {});
  }

  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.paymentPageUrl,
      withZoom: true,
      hidden: true,

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

    );
  }
}

