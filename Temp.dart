import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(Temp());
}

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length,name_length,pname_length;
var j,pj;
List<String> gotItems = new List<String>();


class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      'Tracking Leads',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

}
