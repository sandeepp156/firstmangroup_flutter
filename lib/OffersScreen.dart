import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(OffersScreen());
}

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length,name_length,pname_length;
var j,pj;
List<String> gotItems = new List<String>();


class _OffersScreenState extends State<OffersScreen> {
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
                      'Offers',
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
              height: 1,
              color: GlobalVariable.grey_main_,
            ),

            Expanded(child: Container(
              alignment: Alignment.center,
              child:  Text(
                'No Offers Present Here',
                style: TextStyle(
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium,
                    fontSize: 18),
              ),
            ))


          ],
        ),
      ),
    );
  }

}
