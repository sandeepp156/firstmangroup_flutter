import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'customcolor.dart';

void main() {
  runApp(AdsScreen());
}

class AdsScreen extends StatefulWidget {
  String text;
  AdsScreen({this.text});
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length,name_length,pname_length;
var j,pj;
List<String> gotItems = new List<String>();


class _AdsScreenState extends State<AdsScreen> {
  String text;
  _AdsScreenState({this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // appbar
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
                      'News',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Html(data: widget.text,),
               /*   Text(parseHtmlString(widget.text),   style: TextStyle(
                      color: GlobalVariable.text_colors_black,
                      fontFamily:
                      GlobalVariable.Gotham),),*/
                ),
              ),
            )



          ],
        ),
      ),
    );
  }

}
