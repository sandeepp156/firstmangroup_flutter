// import 'dart:html';

import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'BannersScreen.dart';
import 'MyFmNw.dart';
import 'initialpage.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
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
                bottommenu(),
              ],
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  showId = false;
                });
              },
              child: Visibility(visible: showId,
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
                          width:MediaQuery.of(context).size.width / 1.7,
                          padding: EdgeInsets.only(top: 10),
                          color: GlobalVariable.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding:
                                    EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                margin: EdgeInsets.only(top: 3),
                                width: double.infinity,
                                color: GlobalVariable.grey_main,
                                child: Text(
                                  'Personal',
                                  // textAlign:TextAlign.left,
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 7,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 5,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 7,left: 2),
                                      child: Image.asset('drawable/green_on.png',height: 7,width: 10,),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 7,left: 3),
                                      child:
                                      Text(
                                        'Not Submitted',
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: Colors.red,
                                            fontFamily: GlobalVariable.GothamMedium),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 4,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: GlobalVariable.grey_main,
                                padding: const EdgeInsets.only(bottom: 5,top: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
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
              onTap: (){
                setState(() {
                  showMenu = false;
                });
              },
              child: Visibility(visible: showMenu,
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
                          width:MediaQuery.of(context).size.width / 1.7,
                          padding: EdgeInsets.only(top: 10),
                          color: GlobalVariable.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                margin: EdgeInsets.only(top: 3),
                                width: double.infinity,
                                color: GlobalVariable.grey_main,
                                child: Text(
                                  'Business Gadget',
                                  // textAlign:TextAlign.left,
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 7,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 5,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(bottom: 7,left: 2),
                                    //   child: Image.asset('drawable/green_on.png',height: 7,width: 10,),
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),

                              ),
                              Container(
                                padding:
                                EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                margin: EdgeInsets.only(top: 3),
                                width: double.infinity,
                                color: GlobalVariable.grey_main,
                                child: Text(
                                  'Tools',
                                  // textAlign:TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 4,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.only(left: 13, top: 5, bottom: 5),
                                margin: EdgeInsets.only(top: 3),
                                width: double.infinity,
                                color: GlobalVariable.grey_main,
                                child: Text(
                                  'Support',
                                  // textAlign:TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 3,left: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                color: GlobalVariable.grey_main,
                                padding: const EdgeInsets.only(bottom: 5,top: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 10),
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
                                          fontFamily: GlobalVariable.GothamMedium),
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
    );
  }

  Widget appBar() {
    return SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  showMenu = true;

                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 7, right: 3),
                child: Image.asset(
                  'drawable/menu.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Image.asset(
              'drawable/app_new_icon.png',
              height: 25,
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
              onTap: (){
                setState(() {
                  showId = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 7, left: 3),
                child: Image.asset(
                  'drawable/app_new_icon.png',
                  height: 25,
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
      height: 150,
      child: Stack(
        children: [
          PageView(
            children: pages,
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) => {
              item_li = index,
              setState(() {
                if (index == 2) {
                  tem = false;
                  tem1 = true;
                } else {
                  tem1 = false;
                  tem = true;
                }
              }),
            },
          ),
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
          Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 3; i++)
                  if (i == item_li) circleBar_(true) else circleBar_(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget HomePage() {
    return ListView(
      children: [
        GestureDetector(
          onTap: (){
            // BannersScreen
            Navigator.push(context, new MaterialPageRoute(builder: (context) =>  BannersScreen()),);

          },
          child: Image.asset(
            'drawable/app_icon.png',
            height: 175,
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
          margin: EdgeInsets.only(top: 13, bottom: 5),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        count(),
        Container(
          margin: EdgeInsets.only(top: 13),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
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
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                        margin: EdgeInsets.only(left: 10),
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
                                Text(
                                  'Real Estate',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                )
                              ],
                            ),
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
                                Text(
                                  'Real Estate',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                )
                              ],
                            ),
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
                                Text(
                                  'Real Estate',
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.white),
                                )
                              ],
                            ),
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);

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
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) =>  TrackLeadsScreen()),);

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
                Expanded(
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
      height: 100,
      child: Stack(
        children: [
          // Image.asset('name'),
          Container(
              // color: Colors.lightBlue,
              ),
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
                child: Center(child: Text('00001234')),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget news() {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          // Image.asset('name'),
          Container(
            color: Colors.indigoAccent,
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
}
