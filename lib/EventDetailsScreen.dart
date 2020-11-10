import 'dart:async';

import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(EventDetailsScreen());
}

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen>
    with SingleTickerProviderStateMixin {
  bool _show = true;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 700), (_) {
      setState(() => _show = !_show);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                      'Event',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.t,
                        children: [
                          Text(
                            'Attendees',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 8),
                          ),
                          Text(
                            '10 Registrations',
                            style: _show
                                ? TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.GothamMedium,
                                    fontSize: 10)
                                : TextStyle(
                                    color: Colors.transparent,
                                    fontFamily: GlobalVariable.GothamMedium,
                                    fontSize: 10),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 5),
                        child: Image.asset(
                          'drawable/attendes.png',
                          height: 30,
                          width: 30,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            //appbar /**/

            Container(
              padding: EdgeInsets.only(bottom: 5, left: 3, right: 3),
              color: GlobalVariable.white,
              height: 200,
              // color: GlobalVariable.grey_main,
              child: Card(
                  elevation: 5.0,
                  child: Image.asset(
                    'drawable/bnner1.png',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Card(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: Text(
                    'Title',
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium),
                  ),
                ),
              ),
            ),
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'drawable/app_icon.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'drawable/eve_date.png',
                              height: 20,
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '1 Nov 2018 - 01 Dec 2018',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/eve_time.png',
                                height: 20,
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  '10 AM - 01 PM',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: GlobalVariable.text_colors_black,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'drawable/eve_location.png',
                              height: 20,
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Vijayawada',
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: GlobalVariable.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'drawable/app_icon.png',
                      height: 100,
                      width: 75,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment,
                      children: [
                        Text(
                          'Venue',
                          style: TextStyle(
                              color: GlobalVariable.yellow_main,
                              // decoration: TextDecoration.underline,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          height: 1,
                          color: GlobalVariable.yellow_main,
                          width: 50,
                        ),
                        Text(
                          'Inotel',
                          style: TextStyle(
                              color: GlobalVariable.text_colors_black,
                              fontSize: 12,
                              // decoration: TextDecoration.underline,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 10),
                          child: Text(
                            'Near Ramavarpadu IRR',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontSize: 10,
                                // decoration: TextDecoration.underline,
                                fontFamily: GlobalVariable.GothamMedium),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                color: GlobalVariable.yellow_main,
                                child: Row(
                                  children: [
                                    Image.asset('drawable/eve_location.png',height: 20,width: 30,),
                                    Text('Meal\nPreference:',style: TextStyle(color: GlobalVariable.white,fontSize: 10,fontFamily: GlobalVariable.GothamMedium),)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 7,bottom: 7),

                                color: GlobalVariable.yellow_main_thick,
                                child: Row(
                                  children: [
                                    Image.asset('drawable/checkoff1.png',height: 20,width: 30,),
                                    Text('VEG:',style: TextStyle(color: GlobalVariable.white,fontSize: 10,fontFamily: GlobalVariable.GothamMedium),)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 7,bottom: 7),

                                color: GlobalVariable.yellow_main_thick,
                                child: Row(
                                  children: [
                                    Image.asset('drawable/checkoff1.png',height: 20,width: 30,),
                                    Text('NON-VEG',style: TextStyle(color: GlobalVariable.white,fontSize: 10,fontFamily: GlobalVariable.GothamMedium),)
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
