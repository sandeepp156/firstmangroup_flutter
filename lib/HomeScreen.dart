// import 'dart:html';

// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/InviteFMScreen.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'AddListingScreen.dart';
import 'AnimatedFlipCounter.dart';
import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'DataBannersText.dart';
import 'DataHome.dart';
import 'DataTopper.dart';
import 'EventDetailsScreen.dart';
import 'EventsScreen.dart';
import 'MyAssistantScreen.dart';
import 'MyCreditsScreen.dart';
import 'MyFmNw.dart';
import 'RealEstateScreen.dart';
import 'initialpage.dart';
import 'main.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final controller = PageController(
  initialPage: 0,
);
bool tem = true;
bool tem1 = false;
int item_li = 0;
bool showId = false;
bool showMenu = false;
var bannerTitle = 'test';
var bannerDes = 'test';
var _scale = 0.0;
int countInt = 0;
String countText = '0';
List<String> countTextt = ['0', '0'];
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
final List<DataHome> dataHome = new List<DataHome>();
final List<DataBanners> dataBanners = new List<DataBanners>();
final List<DataToppers> dataToppers = new List<DataToppers>();
final List<DataBannersText> dataBannersText = new List<DataBannersText>();

class _HomeScreenState extends State<HomeScreen> {
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
  final _imageUrls = [
    // "https://png.pngtree.com/thumb_back/fw800/back_pic/00/03/35/09561e11143119b.jpg",
    // "https://png.pngtree.com/thumb_back/fw800/back_pic/04/61/87/28586f2eec77c26.jpg",
    // "https://png.pngtree.com/thumb_back/fh260/back_pic/04/29/70/37583fdf6f4050d.jpg",
    // "https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveDetails();
    // getHome();
    getHomeData_();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  appBar(),
                  Expanded(
                    child: HomePage(), //fragments
                  ),
                  bottommenu(),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showId = false;
                  });
                },
                child: Visibility(
                  visible: showId,
                  child: Container(
                    alignment: Alignment.topRight,
                    color: GlobalVariable.text_colors_black.withOpacity(0.4),
                    child: Wrap(
                      children: [
                        DelayedDisplay(
                          delay: Duration(milliseconds: 100),
                          slidingBeginOffset: Offset(0.35, -0.35),
                          slidingCurve: Curves.fastLinearToSlowEaseIn,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            padding: EdgeInsets.only(top: 10),
                            color: GlobalVariable.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'drawable/app_new_icon.png',
                                        height: 25,
                                        width: 30,
                                      ),
                                      Text(
                                        'FM181002004',
                                        style: TextStyle(
                                            color: GlobalVariable.yellow_main,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 13, top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 3),
                                  width: double.infinity,
                                  color: GlobalVariable.grey_main,
                                  child: Text(
                                    'Personal',
                                    // textAlign:TextAlign.left,
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 7, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/user_pro.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Profile',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 5, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/kyc.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'KYC Update',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, left: 2),
                                        child: Image.asset(
                                          'drawable/green_on.png',
                                          height: 7,
                                          width: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/bank.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Bank Account',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 7, left: 3),
                                        child: Text(
                                          'Not Submitted',
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: Colors.red,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/contact_rm.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'My Assistant (RM)',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 4, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/tpnetwork.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'My FM\'s Network',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/my_listingss.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'My Office',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // MyCreditsScreen
                                    showId = false;
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              MyCreditsScreen()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 3, left: 5),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Image.asset(
                                            'drawable/chips_bag.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        Text(
                                          'My Credits',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: GlobalVariable.grey_main,
                                  padding:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        child: Image.asset(
                                          'drawable/logout.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Logout',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showMenu = false;
                  });
                },
                child: Visibility(
                  visible: showMenu,
                  child: Container(
                    alignment: Alignment.topLeft,
                    color: GlobalVariable.text_colors_black.withOpacity(0.4),
                    child: Wrap(
                      children: [
                        DelayedDisplay(
                          delay: Duration(milliseconds: 100),
                          slidingBeginOffset: Offset(-0.35, -0.35),
                          slidingCurve: Curves.fastLinearToSlowEaseIn,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            padding: EdgeInsets.only(top: 10),
                            color: GlobalVariable.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Image.asset(
                                      //   'drawable/app_new_icon.png',
                                      //   height: 25,
                                      //   width: 30,
                                      // ),
                                      Text(
                                        'Menu',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 13, top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 3),
                                  width: double.infinity,
                                  color: GlobalVariable.grey_main,
                                  child: Text(
                                    'Business Gadget',
                                    // textAlign:TextAlign.left,
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 7, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/ex_track_lead.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Track Lead',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 5, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/extra_site_visit.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Site Visits',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(bottom: 7,left: 2),
                                      //   child: Image.asset('drawable/green_on.png',height: 7,width: 10,),
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/sales_list_act.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Sales List',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(bottom: 7,left: 3),
                                      //   child:
                                      //   Text(
                                      //     'Payouts',
                                      //     style: TextStyle(
                                      //         fontSize: 7,
                                      //         color: Colors.red,
                                      //         fontFamily: GlobalVariable.GothamMedium),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              AddLisitingScreen()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 3, left: 5),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Image.asset(
                                            'drawable/addlisting.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        Text(
                                          'Add Listings',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 13, top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 3),
                                  width: double.infinity,
                                  color: GlobalVariable.grey_main,
                                  child: Text(
                                    'Tools',
                                    // textAlign:TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 4, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/emicalculator.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'EMI Calculator',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/premiumcalculator.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Premium Calculator',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/loaneligibility.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Loan Eligibility',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/inviteba.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Invite FM',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 13, top: 5, bottom: 5),
                                  margin: EdgeInsets.only(top: 3),
                                  width: double.infinity,
                                  color: GlobalVariable.grey_main,
                                  child: Text(
                                    'Support',
                                    // textAlign:TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                builder: (context) =>
                                                    EventsScreen(),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Image.asset(
                                            'drawable/event_icon.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Events',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/annoucements.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Announcements',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/my_listingss.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'About Us',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/terms.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'Terms And Service',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 3, left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Image.asset(
                                          'drawable/faq.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        'FAQ\'s',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: GlobalVariable.grey_main,
                                  padding:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        child: Image.asset(
                                          'drawable/logout.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        '9346999999',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showMenu = true;
                  // clearUser();
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 7, right: 3),
                child: Image.asset(
                  'drawable/menu.png',
                  height: 35,
                  width: 30,
                ),
              ),
            ),
            Image.asset(
              'drawable/app_new_icon.png',
              height: 30,
              width: 30,
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'drawable/select_city.png',
                  height: 17,
                  width: 30,
                ),
                Text(
                  'Vijayawada',
                  style: TextStyle(
                      fontSize: 8,
                      fontFamily: GlobalVariable.GothamMedium,
                      color: GlobalVariable.blue_main),
                )
              ],
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showId = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 7, left: 3),
                child: Image.asset(
                  'drawable/app_new_icon.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ],
        ));
  }

  Widget fragments() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      children: pages,
      controller: controller,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget bottommenu() {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/home_act.png',
                height: 20,
              ),
              Text(
                'Home',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.blue_main,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/commission.png',
                height: 20,
              ),
              Text(
                'Payouts',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/sales_list.png',
                height: 20,
              ),
              Text(
                'Sale List',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/my_office.png',
                height: 20,
              ),
              Text(
                'My Office',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget ads() {
    return SizedBox(
      height: 175,
      child: Stack(
        children: [
          Carousel(
            images: dataBannersText.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 150, right: 150, top: 50, bottom: 50),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ]
                : dataBannersText.map((imgURL) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imgURL.image,
                          fit: BoxFit.fill,
                        );
                      },
                    );
                  }).toList(),
            onImageTap: (i) {
              // print(''+i.toString());
              print('' + dataToppers[2].id);
            },
            onImageChange: (i, j) {
              // print('i='+i.toString()+',j='+j.toString());
              setState(() {
                bannerTitle = '' + dataBannersText[j].title;
                bannerDes = '' + dataBannersText[j].description;
              });
            }
            // images:
            //
            // _imageUrls
            // dataBannersText.length == 0
            //     ? Image.network(
            //         '',
            //         fit: BoxFit.cover,
            //       )
            //     : dataBannersText.map((e) {
            //         return Builder(
            //           builder: (BuildContext context) {
            //             return Image.network(
            //               e.image,
            //               fit: BoxFit.cover,
            //             );
            //             // Container(
            //             //        color: Colors.lightGreen
            //             //      );
            //           },
            //         );
            //       }).toList(),

            // onImageTap:(pos){
            //   Navigator.push(
            //     context,
            //     new MaterialPageRoute(builder: (context) => BannersScreen()),
            //   );
            // } ,
            ,
            showIndicator: true,
            borderRadius: false,
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotIncreasedColor: GlobalVariable.white,
            dotColor: GlobalVariable.grey_main_,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,

            // moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            // overlayShadow: true,
            // overlayShadowColors: Colors.white,
            // overlayShadowSize: 0.7,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '' + bannerTitle,
                    style: TextStyle(color: GlobalVariable.white, fontSize: 16),
                  ),
                ),
                Text(
                  '' + bannerDes,
                  maxLines: 2,
                  style: TextStyle(
                    color: GlobalVariable.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          // PageView(
          //   children: pages,
          //   controller: controller,
          //   scrollDirection: Axis.horizontal,
          //   physics: BouncingScrollPhysics(),
          //   onPageChanged: (index) => {
          //     item_li = index,
          //     setState(() {
          //       if (index == 2) {
          //         tem = false;
          //         tem1 = true;
          //       } else {
          //         tem1 = false;
          //         tem = true;
          //       }
          //     }),
          //   },
          // ),
          // Text("Started",style: TextStyle(color: Colors.green,fontSize: 20),),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Read More',
                style: TextStyle(
                    color: GlobalVariable.yellow_main,
                    fontFamily: GlobalVariable.Gotham),
              ),
              // child: arrows(context),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 10),
          //   alignment: Alignment.bottomCenter,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       for (int i = 0; i < 3; i++)
          //         if (i == item_li) circleBar_(true) else circleBar_(false),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget HomePage() {
    return ListView(
      children: [
        SizedBox(
          height: 225,
          child: Carousel(
            onImageTap: (i) {
              print('' + i.toString());
              sendToScreen(i);
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => BannersScreen(id: dataBanners[i].id)),
              );
            },
            images: dataBanners.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 175, right: 175, top: 100, bottom: 100),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ]
                : dataBanners.map((imgURL) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imgURL.image,
                          fit: BoxFit.fill,
                        );
                      },
                    );
                  }).toList(),

            // dataBanners.map((e) {
            //   return Builder(
            //     builder: (BuildContext context) {
            //       return Image.network(
            //         e.image,
            //         fit: BoxFit.cover,
            //       );
            //       // Container(
            //       //        color: Colors.lightGreen
            //       //      );
            //     },
            //   );
            // }).toList(),

            // images: dataBanners.length == 0
            //     ?NetworkImage('http://via.placeholder.com/350x150')
            //     : dataBanners
            //         .map((e) => NetworkImage(
            //               e.image,
            //               // fit: BoxFit.cover,
            //             ))
            //         .toList(),
            // _imageUrls,
            // [
            //   NetworkImage('' + dataBanners[0].image),
            //   NetworkImage('' + dataBanners[1].image),
            //   // NetworkImage('http://via.placeholder.com/350x150'),
            //   // ExactAssetImage("assets/images/LaunchImage.jpg")
            // ],
            // onImageTap: (pos) {
            //   // Navigator.push(
            //   //   context,
            //   //   new MaterialPageRoute(
            //   //       builder: (context) => BannersScreen()),
            //   // );
            // },

            showIndicator: true,
            borderRadius: false,
            dotSize: 3.0,
            dotSpacing: 5.0,
            dotIncreasedColor: GlobalVariable.white,
            dotColor: GlobalVariable.grey_main,
            // indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,

            // moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            // overlayShadow: true,
            // overlayShadowColors: Colors.white,
            // overlayShadowSize: 0.7,
          ),

          // Swiper(
          //   itemCount: 2,
          //   autoplay: true,
          //   itemBuilder: (context, pos) {
          //     return new Image.network(
          //       "http://via.placeholder.com/350x150",
          //       fit: BoxFit.fill,
          //     );
          //   },
          //   pagination: SwiperPagination.dots,
          // ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        tradegallery(),
        Container(
          margin: EdgeInsets.only(top: 13, bottom: 10),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        gadgets(),
        Container(
          margin: EdgeInsets.only(top: 13, bottom: 2),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        count(),
        // Container(
        //   margin: EdgeInsets.only(top: 13),
        //   height: 1,
        //   color: GlobalVariable.grey_main_,
        // ),
        ads(),
        Container(
          // margin: EdgeInsets.only(top: 13),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        news(),
      ],
    );
  }

  Widget tradegallery() {
    return SizedBox(
      child: Column(
        children: [
          Text(
            'TRADE GALLERY',
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
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => RealEstateScreen()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ]),
                          margin: EdgeInsets.only(left: 10),
                          height: 90,
                          // width: 125,
                          // color: Colors.green,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.asset(
                                    'drawable/realestate_back.png',
                                    height: 90,
                                    fit: BoxFit.fill,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 17),
                                child: Center(
                                    child: Image.asset(
                                  'drawable/searchhouse.png',
                                  fit: BoxFit.fill,
                                  height: 20,
                                  // width: 25,
                                  color: GlobalVariable.white,
                                )),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Text(
                                    'Real Estate',
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.white),
                                  ),
                                ),
                              )
                            ],
                          ),
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
                        margin: EdgeInsets.only(left: 10),
                        height: 90,
                        // width: 125,
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'drawable/loans.png',
                                  height: 90,
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Center(
                                  child: Image.asset(
                                'drawable/loan_icon_act.png',
                                fit: BoxFit.fill,
                                height: 35,
                                // width: 25,
                                color: GlobalVariable.white,
                              )),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  'Loans',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                ),
                              ),
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
                        margin: EdgeInsets.only(left: 10),
                        height: 90,
                        // width: 125,
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  'drawable/insurance_back.png',
                                  height: 90,
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Center(
                                  child: Image.asset(
                                'drawable/insure.png',
                                fit: BoxFit.fill,
                                height: 25,
                                // width: 25,
                                color: GlobalVariable.white,
                              )),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  'Insurance',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 3,
              //   itemBuilder: (BuildContext context, int pos) {
              //     return Container(
              //       decoration: BoxDecoration(boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey,
              //           blurRadius: 5.0,
              //         ),
              //       ]),
              //       margin: EdgeInsets.only(left: 10),
              //       height: 85,
              //       width: 125,
              //       // color: Colors.green,
              //       child: Stack(
              //         children: [
              //           ClipRRect(
              //               borderRadius: BorderRadius.circular(5.0),
              //               child: Image.asset(
              //                 'drawable/realestate_back.png',
              //                 height: 100,
              //                 fit: BoxFit.fill,
              //               )),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Center(
              //                   child: Image.asset(
              //                 'drawable/searchhouse.png',
              //                 height: 20,
              //                 color: GlobalVariable.white,
              //               )),
              //               Text(
              //                 'Real Estate',
              //                 style: TextStyle(
              //                     fontFamily: GlobalVariable.Gotham,
              //                     color: GlobalVariable.white),
              //               )
              //             ],
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  Widget gadgets() {
    return Column(
      children: [
        Text(
          'GADEGTS',
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
          width: 65,
          margin: EdgeInsets.only(top: 3, bottom: 10),
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyFmNwScreen()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'drawable/fmnet.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'My FM\'s Network',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrackLeadsScreen()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'drawable/tracklead.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'Track Lead',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyAssistantScreen()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'drawable/contactrm.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'My Assistant (RM)',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => InviteFMScreen()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'drawable/invfm.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'Invite FM',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'drawable/offers.png',
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          'Offers',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontSize: 10,
                              fontFamily: GlobalVariable.Gotham),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // EventDetailsScreen
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => EventsScreen(),
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'drawable/eventss.png',
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            'Events',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontSize: 10,
                                fontFamily: GlobalVariable.Gotham),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    // alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'drawable/notification_new.png',
                              height: 45,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontSize: 10,
                                    fontFamily: GlobalVariable.Gotham),
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            // padding: EdgeInsets.only(left: 3,right: 3),
                            margin: EdgeInsets.only(left: 35),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 1, bottom: 1),
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: GlobalVariable.white,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 10),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'drawable/emi_calcu.png',
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          'EMI Calculator',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontSize: 10,
                              fontFamily: GlobalVariable.Gotham),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget count() {
    return SizedBox(
      height: 125,
      child: Stack(
        children: [
          Image.asset(
            'drawable/scroll_back.png',
            fit: BoxFit.fitHeight,
            width: double.infinity,
            height: 125,
          ),
          // Container(
          //     // color: Colors.lightBlue,
          //     ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Text(
                      'FIRST MAN',
                      style:
                          TextStyle(color: GlobalVariable.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Text(
                      'NETWORK',
                      style:
                          TextStyle(color: GlobalVariable.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                    child: Container(
                  height: 30,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: countTextt.length,
                      itemBuilder: (context, pos) {
                        return Container(
                          margin: EdgeInsets.only(left: 3),
                          padding: EdgeInsets.only(
                              left: 5, top: 2, bottom: 2, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: GlobalVariable.blue_main),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 3, top: 2, bottom: 2, right: 3),
                              child:
                                  // AnimatedFlipCounter(
                                  //   duration: Duration(seconds: 2),
                                  //   value: int.parse(countTextt[pos]),
                                  //   /* pass in a number like 2014 */
                                  //   color: GlobalVariable.white,
                                  //   size: 18,
                                  // )
                                  // Countup(
                                  //   begin: 0,
                                  //   end: pos.ceilToDouble(),
                                  //   duration: Duration(seconds: 2),
                                  //   // separator: ' ',
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontFamily: GlobalVariable.GothamMedium,
                                  //       color: GlobalVariable.white,
                                  //       backgroundColor: GlobalVariable.blue_main),
                                  // ),
                                  Text(
                                '' + countTextt[pos],
                                style: TextStyle(
                                    color: GlobalVariable.white,
                                    fontSize: 18,
                                    fontFamily: GlobalVariable.Gotham),
                              ),
                            ),
                          ),
                        );
                      }),
                )
                    // Countup(
                    //   begin: 0,
                    //   end: 7500,
                    //   duration: Duration(seconds: 5),
                    //   // separator: ' ',
                    //   style: TextStyle(
                    //       fontSize: 30,
                    //       fontFamily: GlobalVariable.GothamMedium,
                    //       color: GlobalVariable.white,
                    //       backgroundColor: GlobalVariable.blue_main),
                    // ),
                    // Text('00001234')
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget news() {
    return SizedBox(
      height: 125,
      child: Stack(
        children: [
          Image.asset(
            'drawable/winner_back.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          SizedBox(
            height: 125,
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  'drawable/winner_top_per.png',
                  fit: BoxFit.fill,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Image.asset(
                          'drawable/winners_stage.png',
                          fit: BoxFit.fill,
                          // width: 75,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //winner2
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'drawable/winner2.png',
                                  // fit: BoxFit.fill,
                                  width: 75,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 3),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[0].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 7)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                          // width: 60,
                                          child: Text(
                                              dataToppers.length == 0
                                                  ? ''
                                                  : dataToppers[0].member_code,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: GlobalVariable.white,
                                                  fontSize: 7)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // winner1
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'drawable/winner1.png',
                                  fit: BoxFit.fill,
                                  width: 75,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, left: 7),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[0].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 7)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[0].member_code,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 7)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //winner3
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Stack(
                              // alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'drawable/winner3.png',
                                  fit: BoxFit.fill,
                                  width: 75,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 3),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[0].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: GlobalVariable.white,
                                              fontSize: 7,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[0].member_code,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 7)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //userbg
                    ],
                  ),
                )
              ],
            ),
          )
          // Container(
          //   color: GlobalVariable.blue_main,
          // ),
        ],
      ),
    );
  }

  // Future<void> getHome() async {
  //   var uri = Uri.https(GlobalVariable.BASE_URL,
  //       '/api/home.php?city=1&announce_id=0&offers_id=0');
  //   Response response = await get(uri);
  //   print('getHome-->' + uri.toString());
  //   int statusCode = response.statusCode;
  //   String json = response.body;
  //   if (statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //
  //     print('getHome-->' + json);
  //     setState(() {
  //       for (Map i in data) {
  //         // listModel.add(User.fromJson(i));
  //         // homeData.add(HomeScreenData.fromJson(i));
  //         // homeData_temp.add(HomeScreenData_temp.fromJson(i));
  //       }
  //     });
  //   }
  // }

  Future<void> getHomeData_() async {
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
        "/api/home.php?city=1&announce_id=0&offers_id=0");

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getHome->' + data.toString());
      //countInt
      setState(() {
        print('countTextt' + countTextt.length.toString());
        for (Map i in map['banners']) {
          dataBanners.add(DataBanners.fromJson(i));
          // _imageUrls.add(map[dataBanners][i.length]["image"]);
        }
        for (Map i in map['banner_text']) {
          dataBannersText.add(DataBannersText.fromJson(i));
        }
        for (Map i in map['toppers']) {
          dataToppers.add(DataToppers.fromJson(i));
        }
        countText = map['installations'].toString();
        countInt = countText.length;
        var j = countText.split("");
        print(j);

        // for (int i = 0; i <= j.length; i++) {
        //   countTextt.add(j[i]);
        // }
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getHome->error');

      throw Exception('Failed to load album');
    }
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

  Future<void> saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('member_id', '4');
  }

  Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => MyApp()),
    );
    // Navigator.pop(context);
  }

  void sendToScreen(int pos) {
    print(pos);
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => BannersScreen(id: dataBanners[pos].id)),
    );
  }
}
