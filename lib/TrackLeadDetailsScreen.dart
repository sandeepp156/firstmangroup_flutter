import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(TrackLeadDetailsScreen());
}

class TrackLeadDetailsScreen extends StatefulWidget {
  @override
  _TrackLeadDetailsScreenState createState() => _TrackLeadDetailsScreenState();
}

class _TrackLeadDetailsScreenState extends State<TrackLeadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
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

            Container(
              height: 5,
              color: GlobalVariable.grey_main,
            ),
            SizedBox(
              height: 40,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.s,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Image.asset(
                            'drawable/user_pro.png',
                            height: 25,
                            width: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Vijayawada',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Image.asset(
                            'drawable/mobile.png',
                            height: 25,
                            width: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Vijayawada',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
              color: GlobalVariable.grey_main,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: GlobalVariable.grey_main,
                    margin: EdgeInsets.only(left: 114, top: 5),
                    width: 5,
                    height: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.transparent,
                    child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, pos) {
                          return trackleadItem();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trackleadItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      // padding: EdgeInsets.only(top: 10),
      // color: GlobalVariable.blue_main,
      width: double.infinity,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 90),
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: GlobalVariable.blue_main,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                '08 Nov,20',
                style: TextStyle(
                    color: GlobalVariable.white,
                    fontFamily: GlobalVariable.GothamMedium,
                    fontSize: 14),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 30),
                child: Text(
                  '12:00 PM',
                  style: TextStyle(
                      fontSize: 12, fontFamily: GlobalVariable.Gotham),
                ),
              ),
              Image.asset(
                'drawable/trackclock.png',
                height: 15,
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Image.asset(
                  'drawable/tracktick.png',
                  height: 12,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text('LEAD UNDER FOLLOWUP',
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            fontSize: 13,
                            color: Colors.black)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('Lead successfully submitted',
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 12,
                              color: Colors.black)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }


}
