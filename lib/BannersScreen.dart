import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firstmangroup_flutter/DataNewProperty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'customcolor.dart';

void main() {
  runApp(BannersScreen());
}

class BannersScreen extends StatefulWidget {
  final String id;

  BannersScreen({this.id});

  @override
  _BannersScreenState createState() => _BannersScreenState();
}

final List<DataNewProperty> dataNewProp = new List<DataNewProperty>();

class _BannersScreenState extends State<BannersScreen>
    with SingleTickerProviderStateMixin {
  //https://firstmangroup.in/api/properties_new.php?property_id=102&member=4
  final String id;

  _BannersScreenState({this.id});

  int tab = 0;
  int _amenities = 0;
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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    getNewPropData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                children: [
                  Visibility(
                    visible: true,
                    child: SizedBox(
                      height: 175,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Carousel(
                            images: dataNewProp.length != 0
                                ? [
                                    Image.network(
                                      dataNewProp[0].image1,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      dataNewProp[0].image2,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      dataNewProp[0].image3,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      dataNewProp[0].image4,
                                      fit: BoxFit.fill,
                                    ),
                                  ]
                                : [
                                    Image.asset(
                                      // dataNewProp[0].image4,
                                      'drawable/bnner1.png',
                                      fit: BoxFit.fill,
                                    )
                                  ],
                            showIndicator: true,
                            borderRadius: false,
                            dotSize: 3.0,
                            dotSpacing: 5.0,
                            autoplay: false,
                            dotIncreasedColor: GlobalVariable.white,
                            dotColor: GlobalVariable.grey_main,
                            // indicatorBgPadding: 5.0,
                            dotBgColor: Colors.transparent,

                            // moveIndicatorFromBottom: 180.0,
                            noRadiusForIndicator: true,
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
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium,
                                                  fontSize: 12,
                                                  color: GlobalVariable
                                                      .blue_main)),
                                          TextSpan(
                                              text: 'Request on Call',
                                              style: TextStyle(
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10,bottom: 5),
                    child: Text(
                      dataNewProp.length == 0 ? 'Title' : dataNewProp[0].title,
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      dataNewProp.length == 0
                          ? 'Cons Company'
                          : dataNewProp[0].construction_company,
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
                                  dataNewProp.length == 0
                                      ? 'd'
                                      : dataNewProp[0].area.title +
                                          ',' +
                                          dataNewProp[0].city.title,
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
                                'drawable/price.png',
                                width: 15,
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Cons Company'
                                      : dataNewProp[0].price_disp,
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
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/bhk.png',
                                width: 15,
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Bhk'
                                      : dataNewProp[0].bhk_str ,
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
                                'drawable/floorsbuilding.png',
                                width: 15,
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Floors'
                                      : dataNewProp[0].units_left+' Units Left',
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
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/area.png',
                                width: 15,
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Area_disp'
                                      : dataNewProp[0].area_disp ,
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
                                'drawable/unitsleft.png',
                                width: 15,
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Unitsleft'
                                      : dataNewProp[0].floors +' Floors',
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
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/possession.png',
                                width: 15,
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Possession'
                                      : dataNewProp[0].possession,
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
                                'drawable/mid_stage.png',
                                width: 15,
                                height: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dataNewProp.length == 0
                                      ? 'Stage'
                                      : dataNewProp[0].stage,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main),
                                ),

                              ),
                              Container(
                                color: GlobalVariable.red,
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Construction',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, bottom: 10),
                  //   child: Row(
                  //     children: [
                  //       Image.asset(
                  //         'drawable/bhk.png',
                  //         width: 15,
                  //         height: 15,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text(
                  //           dataNewProp.length == 0
                  //               ? 'bhk_str'
                  //               : dataNewProp[0].bhk_str,
                  //           style: TextStyle(
                  //               fontSize: 12,
                  //               fontFamily: GlobalVariable.Gotham,
                  //               color: GlobalVariable.blue_main),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                                    'Near By',
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
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),child: propertyoptions(),),

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

                  // // Flexible(
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

  Widget propertyoptions() {
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
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
  Widget propertyoptions_() {
    return ListView(
      children: [

      ],
    );
  }

  Widget amenities() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _amenities = 0;
                  });
                },
                child: AnimatedContainer(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  // color: tab == 0
                  //     ? GlobalVariable.blue_main

                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  child: Column(
                    children: [
                      Text(
                        'Fitness',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.blue_main,
                            fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: GlobalVariable.yellow_main,
                        height: _amenities == 0 ? 1 : 0,
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _amenities = 1;
                  });
                },
                child: AnimatedContainer(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  // color: tab == 0
                  //     ? GlobalVariable.blue_main

                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  child: Column(
                    children: [
                      Text(
                        'Fitness',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.blue_main,
                            fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: GlobalVariable.yellow_main,
                        height: _amenities == 1 ? 1 : 0,
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _amenities = 2;
                  });
                },
                child: AnimatedContainer(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  // color: tab == 0
                  //     ? GlobalVariable.blue_main

                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  child: Column(
                    children: [
                      Text(
                        'Fitness',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.blue_main,
                            fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: GlobalVariable.yellow_main,
                        height: _amenities == 2 ? 1 : 0,
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _amenities = 3;
                  });
                },
                child: AnimatedContainer(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  // color: tab == 0
                  //     ? GlobalVariable.blue_main

                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  child: Column(
                    children: [
                      Text(
                        'Fitness',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.blue_main,
                            fontSize: 12),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        color: GlobalVariable.yellow_main,
                        height: _amenities == 3 ? 1 : 0,
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),

              // Container(color: GlobalVariable.grey_main_,height: 2,),
            ],
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (context, pos) {
          //       return Container(
          //         child: Row(
          //           children: [
          //             Image.asset(
          //               'drawable/meals.png',
          //               height: 20,
          //               width: 20,
          //             )
          //           ],
          //         ),
          //       );
          //     })
        ],
      ),
    );
  }

  Widget bottomMenu() {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Visibility(
            // visible: true,
            visible: false,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                color: GlobalVariable.blue_main,
                child: Text(
                  'SUBMIT LEAD',
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
              padding: EdgeInsets.only(top: 15, bottom: 15),
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
              height: 45,
              fit: BoxFit.cover,
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
      ),
    );
  }

  Future<void> getNewPropData() async {
    print('id=' + widget.id);

    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Please wait',
      progressWidget: Platform.isIOS
          ? CupertinoActivityIndicator()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
    );
    await pr.show();

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/properties.php?property_id=" +
        widget.id +
        "&member_id=" +
        GlobalVariable.member_id);

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getNewPropData->' + data.toString() + 'id=' + widget.id);
      //countInt
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataNewProp.add(DataNewProperty.fromJson(i));
          // _imageUrls.add(map[dataBanners][i.length]["image"]);
        }
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getNewPropData->error');

      throw Exception('Failed to load album');
    }
  }
}
