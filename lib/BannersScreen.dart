import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(BannersScreen());
}

class BannersScreen extends StatefulWidget {
  @override
  _BannersScreenState createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  int tab = 0;
  List<String> propertyOptionList = [
    'BKH',
    'Facing',
    'Bathrooms',
    'Area',
    'Parking',
    'Price',
    'Plan',
  ];
  List<String> propertyOptionImgList = [
    'drawable/bhk_one.png',
    'drawable/propery_type_facing.png',
    'drawable/bathrooms.png',
    'drawable/area_one.png',
    'drawable/parking.png',
    'drawable/price_white.png',
    'drawable/plan.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 175,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          'drawable/bnner1.png',
                          fit: BoxFit.fill,
                          height: 175,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RotatedBox(
                                  quarterTurns: 90,
                                  child: Image.asset(
                                    'assets/right.png',
                                    color: GlobalVariable.white,
                                    scale: 3.5,
                                  ),
                                ),
                                Container(
                                    color: GlobalVariable.white,
                                    padding: EdgeInsets.all(5),
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Payouts : ',
                                            style: TextStyle(
                                                fontFamily:
                                                    GlobalVariable.GothamMedium,
                                                fontSize: 12,
                                                color:
                                                    GlobalVariable.blue_main)),
                                        TextSpan(
                                            text: 'Request on Call',
                                            style: TextStyle(
                                                fontFamily:
                                                    GlobalVariable.GothamMedium,
                                                fontSize: 12,
                                                color:
                                                    GlobalVariable.blue_main))
                                      ]),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Chandan Valley',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      'Sarvana\'s',
                      style: TextStyle(
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/map_location.png',
                                width: 15,
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Vijayawada',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/map_location.png',
                                width: 15,
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Vijayawada',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'drawable/map_location.png',
                          width: 15,
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Vijayawada',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      children: [
                        Container(
                          color: GlobalVariable.grey_main_,
                          height: 2,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tab = 0;
                                  });
                                },
                                child: AnimatedContainer(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  color: tab == 0
                                      ? GlobalVariable.blue_main
                                      : GlobalVariable.white,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeOutSine,
                                  child: Text(
                                    'Property Options',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.GothamMedium,
                                        color: tab == 0
                                            ? GlobalVariable.white
                                            : GlobalVariable.blue_main,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: GlobalVariable.grey_main_,
                              width: 2,
                              height: 35,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tab = 1;
                                  });
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeOutSine,
                                  duration: Duration(milliseconds: 500),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  color: tab == 1
                                      ? GlobalVariable.blue_main
                                      : GlobalVariable.white,
                                  child: Text(
                                    'Amenities',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: tab == 1
                                            ? GlobalVariable.white
                                            : GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.GothamMedium,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: GlobalVariable.grey_main_,
                              width: 2,
                              height: 35,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tab = 2;
                                  });
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeOutSine,
                                  duration: Duration(milliseconds: 500),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  color: tab == 2
                                      ? GlobalVariable.blue_main
                                      : GlobalVariable.white,
                                  child: Text(
                                    'Property Options',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: tab == 2
                                            ? GlobalVariable.white
                                            : GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.GothamMedium,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            // Container(color: GlobalVariable.grey_main_,height: 2,),
                          ],
                        ),
                        Container(
                          color: GlobalVariable.grey_main_,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child:propertyoptions(),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.black,
                    height: 200,
                  ),
                  Text(
                    'Price Trends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.Gotham,
                        fontSize: 17),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),

                    // color: Colors.black,
                    height: 225,
                    child: Center(
                      child: Text(
                        'Graph',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(bottom: 10),
                    color: GlobalVariable.grey_main_,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Text(
                          'About',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontSize: 16,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                      ),
                      Text(
                        'Chandan Valley',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontSize: 16,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 7),
                    child: Text(
                      'Description...',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontSize: 14,
                          fontFamily: GlobalVariable.Gotham),
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    color: GlobalVariable.grey_main_,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 225,
                    child: Text(
                      'ListView',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: GlobalVariable.grey_main,
                    height: 300,
                    child: Text(
                      'MapView',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 50,
                  )

                  // Flexible(
                  //   // height: 150,
                  //   child: PageView(
                  //     children: [
                  //       Container(
                  //         height: 100,
                  //         color: GlobalVariable.blue_main,
                  //       ),
                  //       Container(
                  //         height: 150,
                  //         color: GlobalVariable.yellow_main,
                  //       ),
                  //       Container(
                  //         height: 75,
                  //         color: GlobalVariable.light_blue,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Align(alignment: Alignment.bottomCenter, child: bottomMenu()),

              // side menu
              Container(
                width: double.infinity,
                // color: GlobalVariable.grey_main,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'drawable/brochure.png',
                      height: 30,
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        'drawable/share_new.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Image.asset(
                      'drawable/offers_new.png',
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[0],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[0],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
            // Expanded(
            //   child: Container(
            //     width: 100,
            //     child: ListView.builder(
            //       scrollDirection: Axis.vertical,
            //         itemCount: 1,
            //         itemBuilder: (context,pos_){
            //       return Container(
            //         height: 10,width: 10,
            //         margin: EdgeInsets.only(right: 10,left: 10),
            //         color: GlobalVariable.blue_main,
            //         child: Text('2 BHk',
            //             style: TextStyle(
            //             fontFamily: GlobalVariable.Gotham,
            //             fontSize: 10,
            //             color: GlobalVariable.white),
            //         ),
            //       );
            //     }),
            //   ),
            // )
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[1],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[1],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[2],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[2],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[3],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[3],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[4],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[4],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[5],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[5],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      propertyOptionList[6],
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          fontSize: 10,
                          color: GlobalVariable.blue_main),
                    ),
                  ),
                  Image.asset(
                    propertyOptionImgList[6],
                    height: 15,
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget propertyoptions(){
    return Column(
      children: [
        Container(
            height: 50,
            // padding: EdgeInsets.only(left: 30),
            child: listItem()),
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 2,
            itemBuilder: (context, pos) {
              return Container(
                height: 20,
                margin: EdgeInsets.only(bottom: 2),
                color: GlobalVariable.blue_main,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          propertyOptionList[0],
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 10,
                              color: GlobalVariable.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget bottomMenu() {
    return Row(
      children: [
        Visibility(
          visible: false,
          child: Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              color: GlobalVariable.blue_main,
              child: Text(
                'SUMBIT LEAD',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: GlobalVariable.GothamMedium,
                    color: GlobalVariable.yellow_main,
                    fontSize: 13),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            color: GlobalVariable.yellow_main,
            child: Text(
              'CALL',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GlobalVariable.GothamMedium,
                  color: GlobalVariable.blue_main,
                  fontSize: 13),
            ),
          ),
        ),
        Expanded(
          child: Image.asset(
            'drawable/fff.png',
            height: 30,
            fit: BoxFit.fill,
            // scale: 3,
          ),
          //     Container(
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   color: GlobalVariable.light_green,
          //   child: Text(
          //     '',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontFamily: GlobalVariable.GothamMedium, fontSize: 13),
          //   ),
          // ),
        ),
      ],
    );
  }
}
