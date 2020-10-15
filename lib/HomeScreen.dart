// import 'dart:html';

import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            )
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
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 3),
              child: Image.asset(
                'drawable/menu.png',
                height: 30,
                width: 30,
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
            Padding(
              padding: const EdgeInsets.only(right: 7, left: 3),
              child: Image.asset(
                'drawable/app_new_icon.png',
                height: 25,
                width: 30,
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
              child: Text('Read More',style: TextStyle(color: GlobalVariable.yellow_main,fontFamily: GlobalVariable.Gotham),),
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
        Image.asset(
          'drawable/app_icon.png',
          height: 175,
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int pos) {
                return Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
                  margin: EdgeInsets.only(left: 10),
                  height: 85,
                  width: 125,
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
                );
              },
            ),
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
                    onTap: () {},
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
