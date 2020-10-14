import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(CitySelectScreen());
}

class CitySelectScreen extends StatefulWidget {
  @override
  _CitySelectScreenState createState() => _CitySelectScreenState();
}

class _CitySelectScreenState extends State<CitySelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.white,
          child: Column(
            children: [
              appBar(),
              Container(
                  color: GlobalVariable.grey_main,
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: Row(
                    children: [
                      Text(
                        '   Popular Cities',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontSize: 13,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child:
                  GridView.builder(
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int pos) {
                        return Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          height: 100,
                          width: 150,
                          // color: GlobalVariable.yellow_main,
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: GlobalVariable.yellow_main,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    'Vijayawada',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontSize: 12,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: saveBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: GlobalVariable.blue_main,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 7),
                child: Image.asset(
                  'drawable/back_black.png',
                  height: 30,
                  width: 25,
                ),
              ),
            ),
          ),
          Text(
            'Select City',
            style: TextStyle(
                color: GlobalVariable.blue_main,
                fontSize: 16,
                fontFamily: GlobalVariable.GothamMedium),
          ),
        ],
      ),
    );
  }

  Widget saveBtn(){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: GlobalVariable.white,
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => HomeScreen(),
              ));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          decoration: BoxDecoration(
            color: GlobalVariable.blue_main,
            // borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: GlobalVariable.GothamMedium,
                color: GlobalVariable.yellow_main,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
