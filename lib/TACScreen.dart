import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(TACScreen());
}
class TACScreen extends StatefulWidget {
  final String s;
  TACScreen({this.s});
  @override
  _TACScreenState createState() => _TACScreenState();
}

class _TACScreenState extends State<TACScreen> {
  final String s;
  _TACScreenState({this.s});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                      'Terms And Conditions',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(color: GlobalVariable.text_colors_black,height: 1,),
            Container(
              margin: EdgeInsets.only(left: 5,right: 5,top: 10),
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 10,top: 8),
                  child: Text(
                    widget.s,
                    style: TextStyle(
                        color: GlobalVariable.text_colors_black,
                        fontFamily: GlobalVariable.Gotham,
                        fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
