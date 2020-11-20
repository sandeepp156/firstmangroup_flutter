// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'MyFmNw.dart';
import 'initialpage.dart';

void main() {
  runApp(RealEstateScreen());
}

class RealEstateScreen extends StatefulWidget {
  final String typeId;

  RealEstateScreen({this.typeId});

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

final List<DataBanners> dataBanners = new List<DataBanners>();

final controller = PageController(
  initialPage: 0,
);
bool tem = true;
bool tem1 = false;
int item_li = 0;
bool showId = false;
bool showMenu = false;
var _scale = 0.0;
List<Widget> pages = [
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.lightBlue,
  ),
  Container(
    color: Colors.lightGreen,
  ),
];

class _RealEstateScreenState extends State<RealEstateScreen> {
  final String typeId;

  _RealEstateScreenState({this.typeId});

  // List<Widget> pages = [
  //  HomePage(),
  //   PayoutsPage(),
  //   SaleListPage(),
  //   MyOfficePage(),
  // ];
  //
  // List<Widget> pages = [
  //   widget.HomePage,
  //   Container(
  //     child: Image.asset(
  //       "assets/in2.png",
  //       fit: BoxFit.fill,
  //     ),
  //   ),
  //   Container(
  //     child: Image.asset(
  //       "assets/in3.png",
  //       fit: BoxFit.fill,
  //     ),
  //   )
  // ];

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    getData();
    // showProg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                appBar(),
                Expanded(
                  child: HomePage(), //fragments
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      // alignment: Alignment.centerLeft,
      // height: 45,
      child: Row(
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
              'Real Estate',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget fragments() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      children: pages,
      controller: controller,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget ads() {
    return SizedBox(
      height: 130,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'PROPERTY EXPO',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  // height: 1.5,
                  // decoration:TextDecoration.underline,
                  fontSize: 12),
            ),
          ),
          Container(
            color: GlobalVariable.yellow_main,
            height: 1,
            width: 110,
            margin: EdgeInsets.only(top: 3, bottom: 10),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, pos) {
                  return Container(
                    margin: EdgeInsets.only(left: 7),
                    width: 200,
                    color: GlobalVariable.light_blue,
                    child: Image.asset(
                      'drawable/bnner1.png',
                      fit: BoxFit.fill,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget HomePage() {
    return ListView(
      children: [
        SizedBox(
          height: 175,
          child: Carousel(
            images: dataBanners.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Text('Loading'),
                  ]
                : dataBanners.map((imgURL) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imgURL.image,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
            onImageTap: (i) {
              print('' + i.toString());

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => BannersScreen(id: dataBanners[i].id)),
              );
            },
            showIndicator: true,
            borderRadius: false,
            dotSize: 3.0,
            dotSpacing: 5.0,
            dotIncreasedColor: GlobalVariable.white,
            dotColor: GlobalVariable.grey_main,
            dotBgColor: Colors.transparent,
            noRadiusForIndicator: true,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        tradegallery(),
        gadgets(),
        ads(),
      ],
    );
  }

  Widget tradegallery() {
    return SizedBox(
      child: Column(
        children: [
          Text(
            'FIND BY CATEGORY',
            style: TextStyle(
                color: GlobalVariable.blue_main,
                fontFamily: GlobalVariable.GothamMedium,
                // height: 1.5,
                // decoration:TextDecoration.underline,
                fontSize: 12),
          ),
          Container(
            color: GlobalVariable.yellow_main,
            height: 1,
            width: 110,
            margin: EdgeInsets.only(top: 3, bottom: 12),
          ),
          SizedBox(
              height: 90,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                        margin: EdgeInsets.only(left: 5),
                        height: 85,
                        // width: 125,
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'drawable/realestate_back.png',
                                  height: 100,
                                  fit: BoxFit.fill,
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child: Image.asset(
                                  'drawable/searchhouse.png',
                                  height: 20,
                                  color: GlobalVariable.white,
                                )),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'FMG Properties',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 12,
                                      color: GlobalVariable.white),
                                )
                              ],
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5)),
                                child: Image.asset(
                                  'drawable/exclusae.png',
                                  width: 30,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                        margin: EdgeInsets.only(left: 7),
                        height: 85,
                        // width: 125,
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'drawable/realestate_back.png',
                                  height: 100,
                                  fit: BoxFit.fill,
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child: Image.asset(
                                  'drawable/new_prop.png',
                                  height: 20,
                                  color: GlobalVariable.white,
                                )),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'New Properties',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 10),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      color: GlobalVariable.red,
                                      padding:
                                          EdgeInsets.only(top: 1, bottom: 1),
                                      child: Text(
                                        ' LATEST ',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: GlobalVariable.white,
                                            fontFamily: GlobalVariable.Gotham),
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                        margin: EdgeInsets.only(left: 7),
                        height: 85,
                        // width: 125,
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'drawable/loans.png',
                                  height: 100,
                                  fit: BoxFit.fill,
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child: Image.asset(
                                  'drawable/house.png',
                                  height: 20,
                                  color: GlobalVariable.white,
                                )),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Resale Properties',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget gadgets() {
    return Container(
      color: GlobalVariable.blue_main,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Text(
            'BUSINESS GADEGTS',
            style: TextStyle(
                color: GlobalVariable.white,
                fontFamily: GlobalVariable.GothamMedium,
                // height: 1.5,
                // decoration:TextDecoration.underline,
                fontSize: 12),
          ),
          Container(
            color: GlobalVariable.yellow_main,
            height: 1,
            width: 125,
            margin: EdgeInsets.only(top: 3, bottom: 5),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //MyFmNwScreen
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'drawable/tracklead_new.png',
                              height: 30,
                              // color: GlobalVariable.text_colors_black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Track Lead',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //MyFmNwScreen
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 7, bottom: 7, left: 3, right: 3),
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'drawable/cartype.png',
                              height: 30,
                              width: 40,
                              fit: BoxFit.fitWidth,
                              // color: GlobalVariable.text_colors_black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Site Visit',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //MyFmNwScreen
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'drawable/extra_add_listing.png',
                              height: 35,
                              // color: GlobalVariable.text_colors_black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Add Lisiting',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //MyFmNwScreen
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                      },
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'drawable/extra_short_list.png',
                              height: 30,
                              // color: GlobalVariable.text_colors_black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Shortlisted\nProperties',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //MyFmNwScreen
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.asset(
                              'drawable/partner.png',
                              height: 40,

                              // fit: BoxFit.fitHeight,
                              // width: 40,
                              // color: GlobalVariable.text_colors_black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Track Lead',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget circleBar_(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 7 : 3,
      width: isActive ? 7 : 3,
      decoration: BoxDecoration(
          color: isActive ? GlobalVariable.yellow_main : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  Future<void> getData() async {
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
        "/api/banners.php?city_id=1&type="+widget.typeId);

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataBanners.add(DataBanners.fromJson(i));
        }
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getData->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> showProg() async {
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
    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      pr.hide();
    });
  }
}
