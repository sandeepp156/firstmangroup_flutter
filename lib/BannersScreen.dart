import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/DataNewProperty.dart';
import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'MyFmNw.dart';
import 'customcolor.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(BannersScreen());
}

class BannersScreen extends StatefulWidget {
  final String id, typeId;

  BannersScreen({this.id, this.typeId});

  @override
  _BannersScreenState createState() => _BannersScreenState();
}

YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: dataNewProp.length == 0 ? '' : dataNewProp[0].video_link,
  flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: true,
  ),
);
int contentTabs = 0;

final List<DataNewProperty> dataNewProp = new List<DataNewProperty>();

class _BannersScreenState extends State<BannersScreen>
    with SingleTickerProviderStateMixin {
  //https://firstmangroup.in/api/properties_new.php?property_id=102&member=4
  final String id, typeId;

  _BannersScreenState({this.id, this.typeId});

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
    _tabController = new TabController(vsync: this, length: 3);
    // getNewPropData();
    getHomeData_();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ImageVieW(
                                                  image: dataNewProp[0].image1,
                                                  tag: dataNewProp[0].id),
                                              fullscreenDialog: true),
                                        );
                                      },
                                      child: Image.network(
                                        dataNewProp[0].image1,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ImageVieW(
                                                  image: dataNewProp[0].image2,
                                                  tag: dataNewProp[0].id),
                                              fullscreenDialog: true),
                                        );
                                      },
                                      child: Image.network(
                                        dataNewProp[0].image2,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ImageVieW(
                                                  image: dataNewProp[0].image3,
                                                  tag: dataNewProp[0].id),
                                              fullscreenDialog: true),
                                        );
                                      },
                                      child: Image.network(
                                        dataNewProp[0].image3,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ImageVieW(
                                                  image: dataNewProp[0].image4,
                                                  tag: dataNewProp[0].id),
                                              fullscreenDialog: true),
                                        );
                                      },
                                      child: Image.network(
                                        dataNewProp[0].image4,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ]
                                : [
                                    Image.asset(
                                      // dataNewProp[0].image4,
                                      'drawable/bnner1.png',
                                      fit: BoxFit.fill,
                                    )
                                  ],
                            // onImageTap: (j){
                            //
                            //   Navigator.push(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (context) =>
                            //             ImageVieW(
                            //                 image: dataNewProp[j]
                            //                     .image1,
                            //                 tag: dataNewProp[j]
                            //                     .id),
                            //         fullscreenDialog: true),
                            //   );
                            // },
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
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    dataNewProp.length == 0
                                        ? 'd'
                                        : dataNewProp[0].area.title +
                                            ',' +
                                            dataNewProp[0].city.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.blue_main),
                                  ),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                                child: SizedBox(
                                  width: 90,
                                  child: Text(
                                    dataNewProp.length == 0
                                        ? 'Bhk'
                                        : dataNewProp[0].bhk_str,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.blue_main),
                                  ),
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
                                      : dataNewProp[0].units_left +
                                          ' Units Left',
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                                      : dataNewProp[0].area_disp,
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
                                      : dataNewProp[0].floors + ' Floors',
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                          child: Visibility(
                            visible: dataNewProp.length != 0
                                ? dataNewProp[0].stage == 'Completed'
                                    ? true
                                    : false
                                : false,
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
                                  width: 50,
                                  color: GlobalVariable.red,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Construction',
                                    // maxLines: 2,

                                    style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.white),
                                  ),
                                ),
                              ],
                            ),
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
                    duration: Duration(milliseconds: 500),
                    child: tab == 0
                        ? propertyoptions()
                        : tab == 1
                            ? amenities()
                            : nearby(),
                  ),
                  Visibility(
                    visible: dataNewProp.length == 0 ? false : true,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        // color: Colors.black,
                        height: 200,
                        child: YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        )
                        // YoutubePlayer(
                        //   controller: _controller,
                        //   showVideoProgressIndicator: true,
                        //   videoProgressIndicatorColor: Colors.amber,
                        //   progressColors: ProgressColors(
                        //     playedColor: Colors.amber,
                        //     handleColor: Colors.amberAccent,
                        //   ),
                        //   onReady () {
                        // _controller.addListener(listener);
                        // },
                        // ),
                        ),
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
                        dataNewProp.length == 0 ? '' : dataNewProp[0].title,
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
                      parseHtmlString(dataNewProp.length == 0
                          ? ''
                          : dataNewProp[0].description),
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontSize: 12,
                          fontFamily: GlobalVariable.Gotham),
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    color: GlobalVariable.grey_main_,
                  ),
                  Container(
                      alignment: Alignment.center, height: 200, child: riders()
                      //ratings
                      // Text(
                      //   'ListView',
                      //   style: TextStyle(color: Colors.black),
                      // ),
                      ),
                  Container(
                    alignment: Alignment.center,
                    color: GlobalVariable.grey_main,
                    height: 300,
                    child:
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ),
                        ),

                    //     Text(
                    //   'MapView',
                    //   style: TextStyle(color: Colors.black),
                    // ),
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
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        'drawable/share_new.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Image.asset(
                      'drawable/offers_new.png',
                      height: 40,
                      width: 40,
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
        Visibility(
          // visible:true,
          visible: widget.typeId == '4' ? false : true,
          child: Column(
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

  Widget propertyoptions_() {
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

  Widget propertyoptions() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 50, child: listItem()),
          SizedBox(
              height: 150,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      dataNewProp.length != 0 ? dataNewProp[0].flats.length : 0,
                  shrinkWrap: true,
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
                  })),
        ],
      ),
    );
  }

  Widget amenities() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        // mainAxisSize: MainAxisSize.,
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
                        'Welfare',
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
                        'Safety',
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
                        'Leisure',
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
          SizedBox(
            height: 120,
            child: AnimatedList(
                initialItemCount: dataNewProp[0]
                    .amenities[_amenities]
                    .amenities_values
                    .length,
                // shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, pos, anim) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset(0, 0),
                    ).animate(anim),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Image.network(
                              dataNewProp[0]
                                  .amenities[_amenities]
                                  .amenities_values[pos]
                                  .image,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Text(
                            dataNewProp[0]
                                .amenities[_amenities]
                                .amenities_values[pos]
                                .title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: GlobalVariable.GothamMedium,
                                color: GlobalVariable.blue_main,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
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
            visible: widget.typeId == '4' ? true : false,
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
        "/api/properties_new.php?property_id=" +
        widget.id +
        "&member=" +
        GlobalVariable.member_id);

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);

      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getNewPropData->' + data.toString());
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

  Future<void> getHomeData_() async {
    dataNewProp.clear();
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
    print(widget.id + "," + widget.typeId);

    //https://firstmangroup.in/api/properties_new.php?property_id=137&member=4
    //3= //https://firstmangroup.in/api/properties.php?property_id=133&member_id=4
    //4= //https://firstmangroup.in/api/properties_new.php?property_id=133&member=4
    final response = widget.typeId == '4'
        ? await http.get("https://" +
            GlobalVariable.BASE_URL +
            "/api/properties_new.php?property_id=" +
            widget.id +
            "&member=" +
            GlobalVariable.member_id) .timeout(Duration(seconds: 3), onTimeout: () {
      return null;
    })
        : await http
            .get("https://" +
                GlobalVariable.BASE_URL +
                "/api/properties.php?property_id=" +
                widget.id +
                "&member_id=" +
                GlobalVariable.member_id)
            .timeout(Duration(seconds: 3), onTimeout: () {
            return null;
          });

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getHome->' + data.toString());
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
      print('getHome->error');

      throw Exception('Failed to load album');
    }
  }

  Widget nearby() {
    return Container();
  }

  Widget riders() {
    return Container(
      child: Row(
        children: [
          Text(
            'R\nI\nD\nE\nR\nS',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: GlobalVariable.blue_main,
                fontFamily: GlobalVariable.Gotham,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
