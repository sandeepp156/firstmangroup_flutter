// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/NewPropertyGalleyScreen.dart';
import 'package:firstmangroup_flutter/PartnershipDetails.dart';
import 'package:firstmangroup_flutter/ShortListPropScreen.dart';
import 'package:firstmangroup_flutter/SiteVisitScreen.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AddListingScreen.dart';
import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'DataMemberDetails.dart';
import 'ListingsScreen.dart';
import 'MyFmNw.dart';
import 'ProjectPartnerScreen.dart';
import 'PropertyGalleryScreen.dart';
import 'initialpage.dart';

void main() {
  runApp(RealEstateScreen());
}

class RealEstateScreen extends StatefulWidget {
  final String typeId, type_mem;

  RealEstateScreen({this.typeId, this.type_mem});

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

final List<DataBanners> dataBanners = new List<DataBanners>();
final List<DataAds> dataAds = new List<DataAds>();
final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

final controller = PageController(
  initialPage: 0,
);
String cityId = '0';
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
  final String typeId, type_mem;

  _RealEstateScreenState({this.typeId, this.type_mem});

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
    getDetails();
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
      height: 175,
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
                itemCount: dataAds.length != 0 ? dataAds.length : 0,
                itemBuilder: (context, pos) {
                  return Container(
                    margin: EdgeInsets.only(left: 7),
                    width: 215,
                    height: 200,
                    // color: GlobalVariable.light_blue,
                    child: Image.network(
                      dataAds.length != 0 ? dataAds[pos].image : '',
                      height: 200,
                      width: 215,
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
          height: 225,
          child: Carousel(
            images: dataBanners.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Center(child: Text('Loading')),
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
                    builder: (context) => BannersScreen(
                          id: dataBanners[i].typeId,
                          typeId: dataBanners[i].type,
                        )),
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
                      child: InkWell(
                        onTap: () {
                          // PropertyGalleryScreen
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PropertyGalleryScreen()),
                          );
                        },
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    NewPropertyGalleyScreen()),
                          );
                        },
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
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ))),
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
                            new MaterialPageRoute(
                                builder: (context) => ListingScreen(
                                      typeId: widget.typeId,
                                    )),
                          );
                        },
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
                        Navigator.push(
                          context,
                          new CupertinoPageRoute(
                              builder: (context) => TrackLeadsScreen()),
                        );
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

                        if (dataMemDe.length != 0) {
                          if (dataMemDe[0].kyc == '' ||
                              dataMemDe[0].kyc == null) {
                            print('kyc not done');
                            // _onWillPop();
                            if (Platform.isAndroid) {
                              _onWillPop();
                            } else if (Platform.isIOS) {
                              displayDialog();
                            }
                          } else {
                            print('kyc  done');
                            Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                  builder: (context) => SiteVisitScreen()),
                            );
                          }
                        } else {
                          print('kyc checking');
                        }
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
                        if (dataMemDe.length != 0) {
                          if (dataMemDe[0].kyc == '' ||
                              dataMemDe[0].kyc == null) {
                            print('kyc not done');
                            // _onWillPop();
                            if (Platform.isAndroid) {
                              _onWillPop();
                            } else if (Platform.isIOS) {
                              displayDialog();
                            }
                          } else {
                            print('kyc done');
                            Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                  builder: (context) => AddLisitingScreen()),
                            );
                          }
                        } else {
                          print('kyc checking');
                        }
                        /*  Navigator.push(
                          context,
                          new CupertinoPageRoute(
                              builder: (context) => AddLisitingScreen()),
                        );*/
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
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ShortListPropScreen()),
                        );
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
                  Visibility(
                    visible: true,
                    // visible: widget.type_mem == '3' ? false : true,
                    child: Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            new CupertinoPageRoute(
                                builder: (context) => ProjectPartnerScreen()),
                          );
                          //MyFmNwScreen
                          // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  MyFmNwScreen()),);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
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
                                'Project\nPartner',
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Alert !'),
            content: new Text('KYC not completed'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('OK'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Alert !"),
        content: new Text("\nKYC not done"),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDefaultAction: true,
              child: new Text("Close"))
        ],
      ),
    );
  }

  Future<void> getData() async {
    dataAds.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonAds = prefs.getString("cityJson");
    print("jsonAds" + jsonAds);
    Map<String, dynamic> map = jsonDecode(jsonAds);

    setState(() {
      if (map.containsKey('realestate_gallery')) {
        for (Map i in map["realestate_gallery"]) {
          dataAds.add(DataAds.fromJson(i));
        }
      } else {}
    });
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
        "/api/banners.php?city_id=1&type=" +
        widget.typeId);
    print('/api/banners.php?city_id=' + cityId + '&type=' + widget.typeId);

    if (response.statusCode == 200) {
      await pr.hide();

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

  Future<void> getDetails() async {
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
}

class DataAds {
  String description;
  String id;
  String image;
  String ref_id;
  String title;
  String type;

  DataAds(
      {this.description,
      this.id,
      this.image,
      this.ref_id,
      this.title,
      this.type});

  factory DataAds.fromJson(Map<String, dynamic> json) {
    return DataAds(
      description: json['description'],
      id: json['id'],
      image: json['image'],
      ref_id: json['ref_id'],
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['ref_id'] = this.ref_id;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}

// // Future<void> showProg() async {
//   //   ProgressDialog pr = ProgressDialog(context);
//   //   pr = ProgressDialog(context,
//   //       type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
//   //   pr.style(
//   //     message: 'Please wait',
//   //     progressWidget: Platform.isIOS
//   //         ? CupertinoActivityIndicator()
//   //         : Padding(
//   //             padding: const EdgeInsets.all(10.0),
//   //             child: CircularProgressIndicator(),
//   //           ),
//   //   );
//   //   await pr.show();
//   //   Future.delayed(Duration(seconds: 3)).whenComplete(() {
//   //     pr.hide();
//   //   });
//   // }

//project disable if id =3
