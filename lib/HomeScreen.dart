// import 'dart:html';

// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstmangroup_flutter/AboutUsScreen.dart';
import 'package:firstmangroup_flutter/AccountDetScreen.dart';
import 'package:firstmangroup_flutter/BankAccountScreen.dart';
import 'package:firstmangroup_flutter/CitySelectScreen.dart';
import 'package:firstmangroup_flutter/EmiCalScreen.dart';
import 'package:firstmangroup_flutter/FAQScreen.dart';
import 'package:firstmangroup_flutter/InsuranceScreen.dart';
import 'package:firstmangroup_flutter/NotifyScreen.dart';
import 'package:firstmangroup_flutter/PayoutsScreen.dart';
import 'package:firstmangroup_flutter/PointsLineChart.dart';
import 'package:firstmangroup_flutter/TACScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
import 'package:shimmer/shimmer.dart';

import 'AddListingScreen.dart';
import 'AdsScreen.dart';
import 'AnimatedFlipCounter.dart';
import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'DataBannersText.dart';
import 'DataHome.dart';
import 'DataMemberDetails.dart';
import 'DataTopper.dart';
import 'EventDetailsScreen.dart';
import 'EventsScreen.dart';
import 'LoansScreen.dart';
import 'MyAssistantScreen.dart';
import 'MyCreditsScreen.dart';
import 'MyFmNw.dart';
import 'MyOfficeScreen.dart';
import 'OffersScreen.dart';
import 'RealEstateScreen.dart';
import 'SalesListScreen.dart';
import 'SiteVisitScreen.dart';
import 'initialpage.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

// import 'package:charts_flutter/flutter.dart' as charts;

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
String terms = '', phone = '';
var cityId = '0';
var cityName = 'CityName';
var bannerDes = 'test';
int countInt = 0;
int bottomMenu = 0;
bool showShimmerr = true;
String countText = '0';
String offersCountt = '0';
String notifyCountt = '0';
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

List<String> countTextt = ['0', '0', '0', '0'];
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
final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();
final List<DataBanners> dataBanners = new List<DataBanners>();
final List<DataToppers> dataToppers = new List<DataToppers>();
final List<DataBannersText> dataBannersText = new List<DataBannersText>();
String devType;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _miles = 0;
  bool dispo = false;

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    showShimmer();
    saveDetails();
    // getHome();
    getHomeData_();
    getCityAds();
    getSettings();
    setOneSignal();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = _controller;
    if (Platform.isAndroid) {
      devType = 'android';
    } else if (Platform.isIOS) {
      devType = 'iphone';
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (bottomMenu != 0) {
      setState(() {
        bottomMenu = 0;
      });
    } else {
      super.dispose();
    }
  }

  Future<bool> _onWillPop() async {
    return (await bottomMenu == 0
            ? showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to exit?'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text('No'),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: new Text('Yes'),
                    ),
                  ],
                ),
              )
            : false) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: bottomMenu == 0
                            ? appBar()
                            : bottomMenu == 1
                                ? payOutAppBar()
                                : bottomMenu == 2
                                    ? salesListAppBar()
                                    : myOffAppBar()),
                    Expanded(
                      child: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: bottomMenu == 0
                              ? HomePage()
                              : bottomMenu == 1
                                  ? PayoutsScreen(id: '-1')
                                  : bottomMenu == 2
                                      ? SalesListScreen()
                                      : MyOfficeScreen()), //fragments
                    ),
                    Visibility(
                        visible: dataMemDe.length == 0
                            ? false
                            : dataMemDe[0].type == '3'
                                ? false
                                : true,
                        child: bottommenu()),
                  ],
                ),
                //menus
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showId = false;
                    });
                  },
                  child: Visibility(
                    visible: showId,
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        alignment: Alignment.topRight,
                        color:
                            GlobalVariable.text_colors_black.withOpacity(0.4),
                        child: Wrap(
                          children: [
                            DelayedDisplay(
                              delay: Duration(milliseconds: 50),
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
                                            dataMemDe.length == 0
                                                ? 'FM000'
                                                : dataMemDe[0].code,
                                            style: TextStyle(
                                                color:
                                                    GlobalVariable.yellow_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham),
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
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            showId = false;
                                          });
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return AccountDetScreen();
                                          }));
                                        },
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
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: dataMemDe.length == 0
                                          ? true
                                          : dataMemDe[0].type == '3'
                                              ? false
                                              : true,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 5, left: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily: GlobalVariable
                                                          .GothamMedium),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 7, left: 2),
                                                  child: dataMemDe.length != 0
                                                      ? dataMemDe[0].kyc ==
                                                              'Approved'
                                                          ? Image.asset(
                                                              'drawable/green_on.png',
                                                              height: 7,
                                                              width: 10,
                                                              // color: dataMemDe[0].kyc=='Approved'?GlobalVariable.text_colors_green:Colors.transparent,
                                                            )
                                                          : Image.asset(
                                                              'drawable/green_on.png',
                                                              height: 7,
                                                              width: 10,
                                                              color: Colors
                                                                  .transparent,
                                                            )
                                                      : Container(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 3, left: 5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showId = false;
                                                });
                                                Navigator.push(context,
                                                    CupertinoPageRoute(
                                                        builder: (context) {
                                                  return BankAccScreen();
                                                }));
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
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
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 7, left: 3),
                                                    child: Text(
                                                      dataMemDe.length != 0
                                                          ? dataMemDe[0]
                                                                      .bank
                                                                      .length ==
                                                                  0
                                                              ? 'Not Submitted'
                                                              : 'Submitted'
                                                          : '',
                                                      // 'Not Submitted',
                                                      style: TextStyle(
                                                          fontSize: 7,
                                                          color: Colors.red,
                                                          fontFamily:
                                                              GlobalVariable
                                                                  .GothamMedium),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 3, left: 5),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  new CupertinoPageRoute(
                                                      builder: (context) =>
                                                          MyAssistantScreen()),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
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
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 4, left: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily: GlobalVariable
                                                          .GothamMedium),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 3, left: 5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showId = false;
                                                  bottomMenu = 3;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
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
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // MyCreditsScreen
                                              showId = false;
                                              Navigator.push(
                                                context,
                                                new CupertinoPageRoute(
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
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
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (Platform.isIOS) {
                                        } else if (Platform.isAndroid) {
                                          clearUser();
                                        }
                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Initial()));
                                      },
                                      child: Container(
                                        color: GlobalVariable.grey_main,
                                        padding: const EdgeInsets.only(
                                            bottom: 5, top: 5),
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
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
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
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showMenu = false;
                    });
                  },
                  child: Visibility(
                    visible: showMenu,
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        color:
                            GlobalVariable.text_colors_black.withOpacity(0.4),
                        child: Wrap(
                          children: [
                            DelayedDisplay(
                              delay: Duration(milliseconds: 50),
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
                                                fontFamily: GlobalVariable
                                                    .GothamMedium),
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
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) =>
                                                  TrackLeadsScreen()),
                                        );
                                      },
                                      child: Padding(
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
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, top: 5, left: 5),
                                      child: InkWell(
                                        onTap: () {
                                          // SiteVisitScreen//
                                          setState(() {
                                            showMenu = false;
                                          });
                                          Navigator.push(
                                            context,
                                            new CupertinoPageRoute(
                                                builder: (context) =>
                                                    SiteVisitScreen()),
                                          );
                                        },
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
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(bottom: 7,left: 2),
                                            //   child: Image.asset('drawable/green_on.png',height: 7,width: 10,),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //SalesListScreen
                                        // Navigator.pop(context);
                                        setState(() {
                                          showMenu = false;
                                          bottomMenu = 2;
                                        });
                                        // asdfsadfdd

                                        /* Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  SalesListScreen()),
                                        );*/
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
                                                'drawable/sales_list_act.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'Sales List',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
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
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
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
                                                'drawable/inventory.png',
                                                height: 17,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'Add Listings',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
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
                                                fontFamily: GlobalVariable
                                                    .GothamMedium),
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
                                                fontFamily: GlobalVariable
                                                    .GothamMedium),
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
                                                fontFamily: GlobalVariable
                                                    .GothamMedium),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) =>
                                                  InviteFMScreen()),
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
                                                'drawable/inviteba.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'Invite FM',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
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
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            showMenu = false;
                                          });
                                          print('menu==events');
                                          Navigator.push(
                                              context,
                                              new CupertinoPageRoute(
                                                builder: (context) =>
                                                    EventsScreen(),
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Image.asset(
                                                'drawable/event_icon.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'Events',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) =>
                                                  NotifyScreen()),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 3, left: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new CupertinoPageRoute(
                                                  builder: (context) =>
                                                      NotifyScreen(),
                                                ));
                                          },
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
                                                    color: GlobalVariable
                                                        .blue_main,
                                                    fontFamily: GlobalVariable
                                                        .GothamMedium),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) =>
                                                  AboutUsScreen()), //
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
                                                'drawable/my_listingss.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'About Us',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        print('parseHtmlString::::::' +
                                            parseHtmlString(terms));
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) => TACScreen(
                                                  s: parseHtmlString(
                                                      terms))), //
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
                                                'drawable/terms.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'Terms And Service',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showMenu = false;
                                        });
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                              builder: (context) =>
                                                  FAQScreen()), //
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
                                                'drawable/faq.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                            Text(
                                              'FAQ\'s',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily: GlobalVariable
                                                      .GothamMedium),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: GlobalVariable.grey_main,
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
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
                                            phone,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: GlobalVariable.blue_main,
                                                fontFamily: GlobalVariable
                                                    .GothamMedium),
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
                ),
              ],
            ),
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
            Visibility(
              // visible: true,
              visible: dataMemDe.length == 0
                  ? false
                  : dataMemDe[0].type == '3'
                      ? false
                      : true,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showMenu = true;
                    // clearUser();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Image.asset(
                    'drawable/menu.png',
                    height: 35,
                    width: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                'drawable/app_new_icon.png',
                height: 30,
                width: 30,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(
                          builder: (context) => CitySelectScreen(from: '0')),
                    );
                  },
                  child: Image.asset(
                    'drawable/select_city.png',
                    height: 17,
                    width: 30,
                  ),
                ),
                Text(
                  cityName,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    dataMemDe.length != 0 ? dataMemDe[0].image : '',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget payOutAppBar() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Navigator.pop(context);
              setState(() {
                bottomMenu = 0;
              });
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
              'Payouts management',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  fontSize: 18),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Hero(
              tag: 'userImg',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  dataMemDe.length != 0 ? dataMemDe[0].image : '',
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget salesListAppBar() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // // Navigator.pop(context);
              setState(() {
                // bottomMenu=0;
                bottomMenu = 0;
              });
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
              'Sales List',
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

  Widget myOffAppBar() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Navigator.pop(context);
              setState(() {
                bottomMenu = 0;
              });
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
              'My Office',
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

  Widget bottommenu() {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Container(
            height: 2,
            color: GlobalVariable.grey_main_,
            margin: EdgeInsets.only(bottom: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    bottomMenu = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      bottomMenu == 0
                          ? 'drawable/home_act.png'
                          : 'drawable/home.png',
                      height: 20,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 12,
                          color: bottomMenu == 0
                              ? GlobalVariable.blue_main
                              : GlobalVariable.grey_main_,
                          fontFamily: GlobalVariable.GothamMedium),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    bottomMenu = 1;
                  });
                  // Navigator.push(
                  //   context,
                  //   new MaterialPageRoute(builder: (context) => PayoutsScreen()),
                  // );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      bottomMenu == 1
                          ? 'drawable/commission_act.png'
                          : 'drawable/commission.png',
                      height: 20,
                    ),
                    Text(
                      'Payouts',
                      style: TextStyle(
                          fontSize: 12,
                          color: bottomMenu == 1
                              ? GlobalVariable.blue_main
                              : GlobalVariable.grey_main_,
                          fontFamily: GlobalVariable.GothamMedium),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    bottomMenu = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      bottomMenu == 2
                          ? 'drawable/sales_list_act.png'
                          : 'drawable/sales_list.png',
                      height: 20,
                    ),
                    Text(
                      'Sale List',
                      style: TextStyle(
                          fontSize: 12,
                          color: bottomMenu == 2
                              ? GlobalVariable.blue_main
                              : GlobalVariable.grey_main_,
                          fontFamily: GlobalVariable.GothamMedium),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    bottomMenu = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      bottomMenu == 3
                          ? 'drawable/my_office_act.png'
                          : 'drawable/my_office.png',
                      height: 20,
                    ),
                    Text(
                      'My Office',
                      style: TextStyle(
                          fontSize: 12,
                          color: bottomMenu == 3
                              ? GlobalVariable.blue_main
                              : GlobalVariable.grey_main_,
                          fontFamily: GlobalVariable.GothamMedium),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget HomePage() {
    return RefreshIndicator(
      onRefresh: getHomeData_,
      child: ListView(
        // physics: BouncingScrollPhysics(),
        children: [
          // appBar(),
          SizedBox(
            height: 225,
            child: dataBanners.length == 0
                ? SizedBox(
                    height: 225,
                    child: Shimmer.fromColors(
                        child: Container(
                          height: 90,
                          color: Colors.white,
                        ),
                        // child: Image.asset('drawable/area_one.png',height: 90,),
                        // baseColor: Colors.transparent,
                        // highlightColor: Colors.grey[300],
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white),
                  )
                : Carousel(
                    images: dataBanners.length == 0
                        ? [
                            // Image.asset('drawable/bnner1.png'),
                            Text('Loading..'),

                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 175, right: 175, top: 100, bottom: 100),
                            //   child: CircularProgressIndicator(
                            //     backgroundColor: Colors.white,
                            //   ),
                            // ),
                          ]
                        : dataBanners.map((imgURL) {
                            return Builder(
                              builder: (BuildContext context) {
                                return imgURL.image.length == 0
                                    ? SizedBox(
                                        height: 225,
                                        child: Shimmer.fromColors(
                                            child: Container(
                                              height: 90,
                                              color: Colors.white,
                                            ),
                                            // child: Image.asset('drawable/area_one.png',height: 90,),
                                            // baseColor: Colors.transparent,
                                            // highlightColor: Colors.grey[300],
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.white),
                                      )
                                    : Image.network(
                                        imgURL.image,
                                        fit: BoxFit.fill,
                                      );
                              },
                            );
                          }).toList(),
                    onImageTap: (i) {
                      print('' + i.toString());

                      Navigator.push(
                        context,
                        new CupertinoPageRoute(
                            builder: (context) => BannersScreen(
                                  id: dataBanners[i].typeId,
                                  typeId: dataBanners[i].type,
                                )),
                      );
                      //  Shimmer.fromColors(
                      //                               // period: Duration(milliseconds: 500),
                      //                               child: Container(height: 90,color: Colors.white,),
                      //                               // child: Image.asset('drawable/area_one.png',height: 90,),
                      //                               // baseColor: Colors.transparent,
                      //                               // highlightColor: Colors.grey[300],
                      //                               baseColor:Colors.grey[300],
                      //                               highlightColor: Colors.white,
                      //                             ),
                      //                           ),
                      // Navigator.push(
                      //   context,
                      //   new MaterialPageRoute(
                      //       builder: (context) =>
                      //           PointsLineChart(_createSampleData(), animate: false)),
                      // );
                    },
                    showIndicator: dataBanners.length == 0 ? false : true,
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
      ),
    );
  }

  Widget tradegallery() {
    return SizedBox(
      child: Column(
        children: [
          showShimmerr == true
              ? Shimmer.fromColors(
                  child: Container(
                    height: 25,
                    width: 110,
                    color: Colors.white,
                  ),
                  // child: Image.asset('drawable/area_one.png',height: 90,),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white)
              : Text(
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
                            new CupertinoPageRoute(
                                builder: (context) => RealEstateScreen(
                                    typeId: '1', type_mem: dataMemDe[0].type)),
                          );
                          // Navigator.push(
                          //   context,
                          //   new MaterialPageRoute(
                          //       builder: (context) => BannersScreen()),
                          // );
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
                          child: showShimmerr == true
                              ? Shimmer.fromColors(
                                  child: Container(
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                  // child: Image.asset('drawable/area_one.png',height: 90,),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white)
                              : Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.asset(
                                          'drawable/realestate_back.png',
                                          height: 90,
                                          fit: BoxFit.fill,
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 17),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new CupertinoPageRoute(
                                builder: (context) => LoansScreen(typeId: '1')),
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
                          child: showShimmerr == true
                              ? Shimmer.fromColors(
                                  child: Container(
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                  // child: Image.asset('drawable/area_one.png',height: 90,),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white)
                              : Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.asset(
                                          'drawable/loans.png',
                                          height: 90,
                                          fit: BoxFit.fill,
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new CupertinoPageRoute(
                                builder: (context) =>
                                    InsuranceScreen(typeId: '1')),
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
                          child: showShimmerr == true
                              ? Shimmer.fromColors(
                                  child: Container(
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                  // child: Image.asset('drawable/area_one.png',height: 90,),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white)
                              : Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.asset(
                                          'drawable/insurance_back.png',
                                          height: 90,
                                          fit: BoxFit.fill,
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
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
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget gadgets() {
    return Column(
      children: [
        showShimmerr == true
            ? Shimmer.fromColors(
                child: Container(
                  height: 20,
                  width: 65,
                  color: Colors.white,
                ),
                // child: Image.asset('drawable/area_one.png',height: 90,),
                baseColor: Colors.grey[300],
                highlightColor: Colors.white)
            : Text(
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
                  // onTap: openWidget,
                  onTap: () {
                    //MyFmNwScreen
                    if (dataMemDe[0].type == '3') {
                    } else {
                      Navigator.push(
                        context,
                        new CupertinoPageRoute(
                            builder: (context) => MyFmNwScreen()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showShimmerr == true
                          ? Container(
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20)),
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: 35,
                                    width: 30,
                                    color: Colors.white,
                                  ),
                                  // child: Image.asset('drawable/area_one.png',height: 90,),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            )
                          : Image.asset(
                              'drawable/fmnet.png',
                              height: 45,
                            ),
                      showShimmerr == true
                          ? Shimmer.fromColors(
                              child: Container(
                                height: 7,
                                width: 65,
                                color: Colors.white,
                              ),
                              // child: Image.asset('drawable/area_one.png',height: 90,),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white)
                          : Padding(
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
                )
                    /*  OpenContainer(
                    closedElevation: 0.0,
                    closedColor: Colors.transparent,
                    openColor: Colors.white,
                    transitionDuration: Duration(milliseconds: 500),
                    openBuilder: (context, closeWidget) {
                      return MyFmNwScreen();
                    },
                    closedBuilder: (context, openWidget) {
                      return ;
                    },
                    // child: ,
                  ),*/
                    ),
                Expanded(
                    child: InkWell(
                  // onTap: openWidget,
                  onTap: () {
                    Navigator.push(
                      context,
                      new CupertinoPageRoute(
                          builder: (context) => TrackLeadsScreen()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showShimmerr == true
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Shimmer.fromColors(
                                  child: Container(
                                    height: 35,
                                    width: 30,
                                    color: Colors.white,
                                  ),
                                  // child: Image.asset('drawable/area_one.png',height: 90,),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.white),
                            )
                          : Image.asset(
                              'drawable/tracklead.png',
                              height: 45,
                            ),
                      showShimmerr == true
                          ? Shimmer.fromColors(
                              child: Container(
                                height: 7,
                                width: 65,
                                color: Colors.white,
                              ),
                              // child: Image.asset('drawable/area_one.png',height: 90,),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white)
                          : Padding(
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
                )
                    /*  OpenContainer(
                    closedElevation: 0.0,
                    closedColor: Colors.transparent,
                    openColor: Colors.white,
                    transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (context, openWidget) {
                      return ;
                    },
                    openBuilder: (context, closeWidget) {
                      return TrackLeadsScreen();
                    },
                    // child: ,
                  ),*/
                    ),
                Expanded(
                  child: InkWell(
                    // onTap: openWidget,
                    onTap: () {
                      Navigator.push(
                        context,
                        new CupertinoPageRoute(
                            builder: (context) => MyAssistantScreen()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showShimmerr == true
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: 35,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    // child: Image.asset('drawable/area_one.png',height: 90,),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white),
                              )
                            : Image.asset(
                                'drawable/contactrm.png',
                                height: 45,
                              ),
                        showShimmerr == true
                            ? Shimmer.fromColors(
                                child: Container(
                                  height: 7,
                                  width: 65,
                                  color: Colors.white,
                                ),
                                // child: Image.asset('drawable/area_one.png',height: 90,),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white)
                            : Padding(
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
                  /*  OpenContainer(
                    closedElevation: 0.0,
                    // closedColor: Colors.transparent,
                    // openColor: Colors.white,
                    // transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (context, openWidget) {
                      return InkWell(
                        onTap: openWidget,
                        */ /*   onTap: () {
                        Navigator.push(
                          context,
                          new CupertinoPageRoute(
                              builder: (context) => MyAssistantScreen()),
                        );
                      },*/ /*
                        child: DelayedDisplay(
                          delay: Duration(milliseconds: 250),
                          slidingBeginOffset: Offset(0.90, -0.90),
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
                      );
                    },
                    openBuilder: (context, closeWidget) {
                      return MyAssistantScreen();
                    },

                    // child: ,
                  ),*/
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (dataMemDe[0].type == '3') {
                      } else {
                        Navigator.push(
                          context,
                          new CupertinoPageRoute(
                              builder: (context) => InviteFMScreen()),
                        );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showShimmerr == true
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: 35,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    // child: Image.asset('drawable/area_one.png',height: 90,),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white),
                              )
                            : Image.asset(
                                'drawable/invfm.png',
                                height: 45,
                              ),
                        showShimmerr == true
                            ? Shimmer.fromColors(
                                child: Container(
                                  height: 7,
                                  width: 65,
                                  color: Colors.white,
                                ),
                                // child: Image.asset('drawable/area_one.png',height: 90,),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white)
                            : Padding(
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
                  child: Stack(
                    // alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                  builder: (context) => OffersScreen(),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              showShimmerr == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 35,
                                            width: 30,
                                            color: Colors.white,
                                          ),
                                          // child: Image.asset('drawable/area_one.png',height: 90,),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )
                                  : Image.asset(
                                      'drawable/offers.png',
                                      height: 45,
                                    ),
                              showShimmerr == true
                                  ? Shimmer.fromColors(
                                      child: Container(
                                        height: 7,
                                        width: 65,
                                        color: Colors.white,
                                      ),
                                      // child: Image.asset('drawable/area_one.png',height: 90,),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white)
                                  : Padding(
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
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Visibility(
                          // visible: true,
                          visible: offersCountt == '0' ? false : true,
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
                                  offersCountt == '0' ? '0' : offersCountt,
                                  style: TextStyle(
                                      color: GlobalVariable.white,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 10),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // EventDetailsScreen
                      print('menu==events');

                      Navigator.push(
                          context,
                          new CupertinoPageRoute(
                            builder: (context) => EventsScreen(),
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showShimmerr == true
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: 35,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    // child: Image.asset('drawable/area_one.png',height: 90,),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white),
                              )
                            : Image.asset(
                                'drawable/eventss.png',
                                height: 45,
                              ),
                        showShimmerr == true
                            ? Shimmer.fromColors(
                                child: Container(
                                  height: 7,
                                  width: 65,
                                  color: Colors.white,
                                ),
                                // child: Image.asset('drawable/area_one.png',height: 90,),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white)
                            : Padding(
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                  builder: (context) => NotifyScreen(),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              showShimmerr == true
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Shimmer.fromColors(
                                          child: Container(
                                            height: 35,
                                            width: 30,
                                            color: Colors.white,
                                          ),
                                          // child: Image.asset('drawable/area_one.png',height: 90,),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white),
                                    )
                                  : Image.asset(
                                      'drawable/notification_new.png',
                                      height: 45,
                                    ),
                              showShimmerr == true
                                  ? Shimmer.fromColors(
                                      child: Container(
                                        height: 7,
                                        width: 65,
                                        color: Colors.white,
                                      ),
                                      // child: Image.asset('drawable/area_one.png',height: 90,),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white)
                                  : Padding(
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
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Visibility(
                          visible: notifyCountt == '0' ? false : true,
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
                                  notifyCountt == '0' ? '0' : notifyCountt,
                                  style: TextStyle(
                                      color: GlobalVariable.white,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 10),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new CupertinoPageRoute(
                            builder: (context) => EmiCalScreen(),
                          ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showShimmerr == true
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Shimmer.fromColors(
                                    child: Container(
                                      height: 35,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    // child: Image.asset('drawable/area_one.png',height: 90,),
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white),
                              )
                            : Image.asset(
                                'drawable/emi_calcu.png',
                                height: 45,
                              ),
                        showShimmerr == true
                            ? Shimmer.fromColors(
                                child: Container(
                                  height: 7,
                                  width: 65,
                                  color: Colors.white,
                                ),
                                // child: Image.asset('drawable/area_one.png',height: 90,),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.white)
                            : Padding(
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
      child:showShimmerr == true
          ? Shimmer.fromColors(
          child: Container(
            height: 125,
            color: Colors.white,
          ),
          // child: Image.asset('drawable/area_one.png',height: 90,),
          baseColor: Colors.grey[300],
          highlightColor: Colors.white)
          : Stack(
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
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                              child: Text(
                                '0',
                                style: TextStyle(
                                    color: GlobalVariable.white,
                                    fontSize: 18,
                                    fontFamily: GlobalVariable.Gotham),
                              )),
                        ),
                      ),
                      Container(
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
                              child: Text(
                                '0',
                                style: TextStyle(
                                    color: GlobalVariable.white,
                                    fontSize: 18,
                                    fontFamily: GlobalVariable.Gotham),
                              )),
                        ),
                      ),
                      ListView.builder(
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
                                      /*Countup(
                                      begin: 0,
                                      end: double.parse(countTextt[pos]),
                                      duration: Duration(seconds: 5),
                                      // separator: ' ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: GlobalVariable.Gotham,
                                          color: GlobalVariable.white,
                                          backgroundColor: GlobalVariable.blue_main),
                                    ),*/
                                      TweenAnimationBuilder(
                                    curve: Curves.decelerate,
                                    tween: IntTween(
                                        begin: 0,
                                        end: int.parse(countTextt[pos])),

                                    builder: (BuildContext context, int angle,
                                        Widget child) {
                                      return Container(
                                          // color:Colors.black,
                                          child: Text(
                                        '' + angle.toString(),
                                        // _animation.value.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: GlobalVariable.white,
                                            fontSize: 18,
                                            fontFamily: GlobalVariable.Gotham),
                                      ));
                                    },
                                    duration: Duration(seconds: 6),
                                    // child:
                                  ),

                                  /* AnimatedFlipCounter(
                                      duration: Duration(seconds: 2),
                                      value: int.parse(countTextt[pos]),
                                      */ /* pass in a number like 2014 */ /*
                                      color: GlobalVariable.white,
                                      size: 18,
                                    )*/
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
                                  /* AnimatedBuilder(
                                animation: _animation,
                                builder: (BuildContext context, Widget child) {
                                  return new Text(
                                    // '' + countTextt[pos],
                                    _animation.value.toStringAsFixed(1),
                                    style: TextStyle(
                                        color: GlobalVariable.white,
                                        fontSize: 18,
                                        fontFamily: GlobalVariable.Gotham),
                                  );
                                },
                                // child:,
                              ),*/
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget ads() {
    return SizedBox(
      height: 175,
      child: showShimmerr == true
          ? Shimmer.fromColors(
              child: Container(
                height: 175,
                color: Colors.white,
              ),
              // child: Image.asset('drawable/area_one.png',height: 90,),
              baseColor: Colors.grey[300],
              highlightColor: Colors.white)
          : Stack(
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
                    // print('' + dataToppers[2].id);
                    if (dataBannersText[i].link == '') {
                      Navigator.push(
                        context,
                        new CupertinoPageRoute(
                            builder: (context) => AdsScreen(
                                  text: dataBannersText[i].big_description,
                                )),
                      );
                    } else {
                      UrlLauncher.launch(dataBannersText[i].link);
                    }
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
                          style: TextStyle(
                              color: GlobalVariable.white, fontSize: 16),
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
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[1].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 7)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5),
                                        child: SizedBox(
                                          // width: 60,
                                          child: Text(
                                              dataToppers.length == 0
                                                  ? ''
                                                  : dataToppers[1]
                                                      .member_code,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
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
                                      const EdgeInsets.only(top: 3, left: 3),
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
                                        padding:
                                            const EdgeInsets.only(top: 5),
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
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[2].name,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: GlobalVariable.white,
                                              fontSize: 7,
                                            )),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5),
                                        child: Text(
                                            dataToppers.length == 0
                                                ? ''
                                                : dataToppers[2].member_code,
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

  Future<void> getHomeData_() async {
    dataBanners.clear();
    dataMemDe.clear();
    dataHome.clear();
    dataToppers.clear();
    dataBannersText.clear();
    countTextt.clear();
    _miles = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    // await pr.show();

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/home.php?city=1&announce_id=0&offers_id=0");

    if (response.statusCode == 200) {
      // await pr.hide();

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
        countText = '0';
        cityId = prefs.getString('cityId');
        print("saveDetails" + prefs.getString('cityId'));
        cityName = prefs.getString('cityName');
        String json = prefs.get('memberJson');
        for (Map i in jsonDecode(json)) {
          dataMemDe.add(DataMemberDetails.fromJson(i));
        }
        for (Map i in map['banners']) {
          dataBanners.add(DataBanners.fromJson(i));
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
        print("instList");
        print(j);
        for (int y = 0; y < j.length; y++) {
          // countTextt.add(j[y]);
          countTextt.add('0');
        }

        Timer(Duration(seconds: 3), () {
          countTextt.clear();

          for (int y = 0; y < j.length; y++) {
            countTextt.add(j[y]);
            // countTextt.add('0');
          }
        });

        _miles += int.parse(j[0]);
        print('miles==' + _miles.toString());
        _animation = new Tween<double>(
          begin: _animation.value,
          end: _miles,
        ).animate(new CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: _controller,
        ));
        notifyCountt = map['announces'].toString();
        offersCountt = map['offers'].toString();
      });
      _controller.forward(from: 0.0);
    } else {
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getHome->error');

      throw Exception('Failed to load album');
    }
    getCityAds();
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
    setState(() {
      // prefs.setString('member_id', '4');
      cityId = prefs.getString('cityId');
      print("Details" + prefs.getString('memberJson'));
      cityName = prefs.getString('cityName');
      String json = prefs.get('memberJson');
      for (Map i in jsonDecode(json)) {
        dataMemDe.add(DataMemberDetails.fromJson(i));
      }
    });
  }

  Future<bool> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Logout?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  prefs.clear();
                  Navigator.pushReplacement(
                    context,
                    new CupertinoPageRoute(builder: (context) => MyApp()), //
                  );
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> clearUser_ios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (await showDialog(
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            title: new Text("Are you sure?"),
            content: new Text("Do you want to Logout?"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Yes"),
                onPressed: () {
                  prefs.clear();
                  Navigator.pushReplacement(
                    context,
                    new CupertinoPageRoute(builder: (context) => MyApp()), //
                  );
                },
              ),
              CupertinoDialogAction(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        )) ??
        false;
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      new CupertinoPageRoute(builder: (context) => MyApp()), //
    );*/
    // Navigator.pop(context);
  }

  Future<void> getCityAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    // await pr.show();

    print("cityIdddd" + prefs.getString('cityId'));
    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/adds.php?city=" +
        prefs.getString('cityId'));

    if (response.statusCode == 200) {
      // await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('CityAdsData->' + data.toString());
      setState(() {
        prefs.setString("cityJson", json);
      });
    } else {
      // await pr.hide();
      print('CityAdsData->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    // await pr.show();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/settings.php");

    if (response.statusCode == 200) {
      // await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getSettings->' + data.toString());
      setState(() {
        // prefs.setString("cityJson", json);
        terms = map["privacy_policy"].toString();
        phone = map["phone"].toString();
        print('getSettingsds->' + terms);
      });
    } else {
      // await pr.hide();
      print('getSettings->error');
      throw Exception('Failed to load album');
    }
    /*  _launchURL(int i) async {
      const url = dataBannersText[i].link.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }*/
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("token->" + token);
      tokenId = token;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<void> setOneSignal() async {
    // OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);

    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("af474584-8ddb-48a5-81ed-c366f1bbabae", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: false
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    playerId = status.subscriptionStatus.userId;

    print('playerId==' + playerId);
    callTokenRegAPI(context);

    /*  OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });


    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });*/

    // _handleSetExternalUserId();
  }

  Future<String> getUserToken() async {
    if (Platform.isIOS) checkforIosPermission();
    await _firebaseMessaging.getToken().then((token) {
      return token;
    });
  }

  void checkforIosPermission() async {
    await _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    await _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<String> getToken() async {
    // tokenId = await getUserToken();
    print('token:' + tokenId);
    return tokenId;
  }

  Future<void> callTokenRegAPI(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('member_id'));
    var queryParameters = {
      'device_token': '' + tokenId,
      'member_id': '' + prefs.getString('member_id'),
      'player_id': '' + playerId,
      'city_id': '' + prefs.getString('cityId'),
      'device_type': devType,
    };
    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/token-register.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String json = response.body;
    print('' + json.toString());
    Map<String, dynamic> map = jsonDecode(json);
    if (statusCode == 200) {
      if (map['status'] == 'Success') {
        /*   Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => OTPVScreen(text: phCntrl.text.toString(),otp: map['OTP'],)),
        );*/
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
        // showMyDialog(context, map['message']);
      }
    }
  }

  void showShimmer() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        showShimmerr = false;
      });
    });
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

///usertype = bottom menu disable(!customer) id = 3
///gadgets  = my fm,invite fm disable
///close
///!profile ,logout only visible
///
//DelayedDisplay(
//                             delay: Duration(milliseconds: 50),
//                             slidingBeginOffset: Offset(0.60, -0.60),
