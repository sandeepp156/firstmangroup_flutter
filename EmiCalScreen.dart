import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'customcolor.dart';

void main() {
  runApp(EmiCalScreen());
}

class EmiCalScreen extends StatefulWidget {
  @override
  _EmiCalScreenState createState() => _EmiCalScreenState();
}

class _EmiCalScreenState extends State<EmiCalScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  // height: 45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Hero(
                          tag: 'back_img',
                          child: Image.asset(
                            'drawable/back_black.png',
                            height: 30,
                            width: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 10),
                        child: Text(
                          'EMI Calculator',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // height: double.infinity,

                    child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl:
                      "https://" + GlobalVariable.BASE_URL + "/api/calculator.php",
                ))
              ],
            ),

          ],
        ),
      ),
    );
  }

  Future<void> loadWebView() async {
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/calculator.php");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getHome->' + data.toString());
      //countInt
      setState(() {});
    } else {
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getHome->error');

      throw Exception('Failed to load album');
    }
  }
}
