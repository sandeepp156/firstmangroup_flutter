import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(AboutUsScreen());
}
class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      'About Us',
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
              margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
              // height: 200,
              child: Card(
                elevation: 5,

                child: Image.asset('drawable/aboutbg.png',),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              width: double.infinity,
              child: Card(
                elevation: 5,

                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 10,top: 8,bottom: 30),
                  child: Text(
                    'Description....',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
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
