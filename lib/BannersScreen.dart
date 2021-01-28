import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:firstmangroup_flutter/DataNewProperty.dart';
import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:firstmangroup_flutter/LeadDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'DataMemberDetails.dart';
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

// YoutubePlayerController _controller = YoutubePlayerController(
//   initialVideoId: dataNewProp.length == 0 ? '' : dataNewProp[0].video_link,
//   flags: YoutubePlayerFlags(
//     autoPlay: true,
//     mute: true,
//   ),
// );
int contentTabs = 0;

final List<DataNewProperty> dataNewProp = new List<DataNewProperty>();
final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

final List<DataGraphData> dataGraphData = new List<DataGraphData>();
final List<SalesData> salesData = new List<SalesData>();

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

  Set<Marker> markers = {};

  List<String> xValue = [];
  List<String> yValue = [];

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

  // List<charts.Series> seriesList;
  final List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.blue,
      data: [1000 / 1000, 1500 / 1000, 2500 / 1000, 700 / 1000, 900 / 1000],
    ),
    /*  Feature(
      title: "Exercise",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      title: "Study",
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      title: "Water Plants",
      color: Colors.green,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),
    Feature(
      title: "Grocery Shopping",
      color: Colors.amber,
      data: [0.25, 1, 0.3, 0.8, 0.6],
    ),*/
  ];

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    // getNewPropData();
    getHomeData_();
    getDetails();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  GoogleMapController mapController;

  LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // /// Creates a [LineChart] with sample data and no transition.
  // factory PointsLineChart.withSampleData() {
  //   return new PointsLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }
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
                    height: 200,
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
                          onImageTap: (j) {
                            if (j == 0) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ImageVieW(
                                        image: dataNewProp[0].image1,
                                        tag: dataNewProp[0].id),
                                    fullscreenDialog: true),
                              );
                            } else if (j == 1) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ImageVieW(
                                        image: dataNewProp[0].image2,
                                        tag: dataNewProp[0].id),
                                    fullscreenDialog: true),
                              );
                            } else if (j == 2) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ImageVieW(
                                        image: dataNewProp[0].image3,
                                        tag: dataNewProp[0].id),
                                    fullscreenDialog: true),
                              );
                            } else if (j == 3) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ImageVieW(
                                        image: dataNewProp[0].image4,
                                        tag: dataNewProp[0].id),
                                    fullscreenDialog: true),
                              );
                            }
                          },
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
                        // Container(
                        //   height: 200,
                        //   width: double.infinity,
                        //   color: Colors.grey.withOpacity(0.5),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  decoration: BoxDecoration(
                                      color: GlobalVariable.blue_main,
                                      // border:
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: RotatedBox(
                                    quarterTurns: 90,
                                    child: Image.asset(
                                      'assets/right.png',
                                      color: GlobalVariable.white,
                                      scale: 3.5,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  // visible:  true,
                                  visible:  dataMemDe.length == 0
                                      ? true
                                      : dataMemDe[0].type == '3'
                                      ? false
                                      : true,
                                  child: Container(
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
                                              text: dataNewProp.length == 0
                                                  ? ''
                                                  : dataNewProp[0]
                                                              .category
                                                              .category_id ==
                                                          '1'
                                                      ? 'Request on Call'
                                                      : '' +
                                                          dataNewProp[0]
                                                              .commission +
                                                          '/' +
                                                          dataNewProp[0].type,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.GothamMedium,
                                                  fontSize: 12,
                                                  color:
                                                      GlobalVariable.blue_main))
                                        ]),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
                          controller: new YoutubePlayerController(
                            initialVideoId: '_-iQA9ODHUw',
                            // initialVideoId: dataNewProp.length == 0
                            //     ? '_-iQA9ODHUw'
                            //     : dataNewProp[0].video_link,
                            flags: YoutubePlayerFlags(
                              autoPlay: false,
                              mute: true,
                            ),
                          ),
                          // controller: _controller,
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
                      child: SfCartesianChart(
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          // legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                // Bind data source
                                dataSource: salesData,
                                // <SalesData>[
                                //   SalesData('Jan', 2500),
                                //   SalesData('Feb', 4000),
                                //   SalesData('Mar', 1000),
                                //   SalesData('Apr', 3000),
                                //   SalesData('May', 1700)
                                // ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ])

                      /* LineGraph(features: features,
                      size: Size(500, 225),
                      labelX: xValue,
                      // labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5','Day 6'],
                      labelY:['0','1000','2000','3000','4000'],
                      // labelY: ['20%', '40%', '60%', '80%', '100%','70%'],
                      // showDescription: true,
                      graphColor: Colors.black,
                    )*/

                      // child: Center(
                      //   child: Text(
                      //     'Graph',
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // ),
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
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(markers),
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
          visible: dataNewProp.length != 0
              ? dataNewProp[0].category.category_id == '1'
                  ? false
                  : true
              : false,
          // visible: widget.typeId == '4' ? false : true,
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
            ],
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30, left: 30),
              child: Center(
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
            ),
          ],
        ),
        Visibility(
          visible: dataNewProp.length != 0
              ? dataNewProp[0].category.category_id == '1'
                  ? false
                  : true
              : false,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15, left: 1),
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
        ),
        Visibility(
          visible: true,
          // visible: dataNewProp.length != 0
          //     ? dataNewProp[0].category.category_id == '1'
          //         ? true
          //         : false
          //     : true,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
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
        ),
        Visibility(
          visible: dataNewProp.length != 0
              ? dataNewProp[0].category.category_id == '1'
                  ? false
                  : true
              : false,
          child: Column(
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
        ),
        Visibility(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15, left: 30),
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
        ),
        Visibility(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ],
    );
  }

  //visible: dataNewProp.length!=0?dataNewProp[0].category.category_id=='1'?false:true:false,

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
      // scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 50, child: listItem()),
          SizedBox(
              height: 100,
              child: ListView.builder(

                  // physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      dataNewProp.length != 0 ? dataNewProp[0].flats.length : 0,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return Container(
                      height: 20,
                      margin: EdgeInsets.only(bottom: 2),
                      color: GlobalVariable.blue_main,
                      child: ListView(
                        // physics: NeverScrollableScrollPhysics(),

                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Visibility(
                            visible: dataNewProp.length != 0
                                ? dataNewProp[0].category.category_id == '1'
                                    ? false
                                    : true
                                : false,
                            child: Container(
                              margin: EdgeInsets.only(right: 20, left: 20),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  dataNewProp[0].flats[pos].title,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 10,
                                      color: GlobalVariable.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                dataNewProp[0].flats[pos].facing,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 10,
                                    color: GlobalVariable.white),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dataNewProp.length != 0
                                ? dataNewProp[0].category.category_id == '1'
                                    ? false
                                    : true
                                : false,
                            child: Container(
                              margin: EdgeInsets.only(right: 25, left: 30),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  dataNewProp[0].flats[pos].bathrooms,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 10,
                                      color: GlobalVariable.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                dataNewProp[0].flats[pos].area +
                                    '/' +
                                    dataNewProp[0].flats[pos].type,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 10,
                                    color: GlobalVariable.white),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dataNewProp.length != 0
                                ? dataNewProp[0].category.category_id == '1'
                                    ? false
                                    : true
                                : false,
                            child: Container(
                              margin: EdgeInsets.only(right: 20, left: 20),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  dataNewProp[0].flats[pos].parking,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 10,
                                      color: GlobalVariable.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                dataNewProp[0].flats[pos].price,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 10,
                                    color: GlobalVariable.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // image5//

                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => ImageVieW(
                                        image: dataNewProp[0].image5,
                                        tag: dataNewProp[0].id),
                                    fullscreenDialog: true),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, left: 20),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'drawable/eye.png',
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        'View',
                                        style: TextStyle(
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 10,
                                            color: GlobalVariable.white),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          //
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
            visible: dataNewProp.length == 0
                ? true
                : dataNewProp[0].category.category_id == '1'
                    ? true
                    : false,
            child: Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => LeadDetailsScreen(
                                from: 'product',
                                id: '0',
                                loanid: '0',
                                loanTitle: dataNewProp[0].title,
                                bankName: '0',
                                propId: dataNewProp[0].id,
                                propType: dataNewProp[0].type,
                              )));
                },
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    // await pr.show();

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/properties_new.php?property_id=" +
        widget.id +
        "&member=" +
        prefs.getString('member_id'));

    if (response.statusCode == 200) {
      // await pr.hide();

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
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getNewPropData->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> getHomeData_() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataNewProp.clear();
    xValue.clear();
    yValue.clear();
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
    print(widget.id + "," + widget.typeId);

    //https://firstmangroup.in/api/properties_new.php?property_id=137&member=4
    //3= //https://firstmangroup.in/api/properties.php?property_id=133&member_id=4
    //4= //https://firstmangroup.in/api/properties_new.php?property_id=133&member=4
    final response = widget.typeId == '4'
        ? await http
            .get("https://" +
                GlobalVariable.BASE_URL +
                "/api/properties_new.php?property_id=" +
                widget.id +
                "&member=" +
                prefs.getString('member_id'))
            .timeout(Duration(seconds: 5), onTimeout: () {
            return null;
          })
        : await http
            .get("https://" +
                GlobalVariable.BASE_URL +
                "/api/properties.php?property_id=" +
                widget.id +
                "&member_id=" +
                prefs.getString('member_id'))
            .timeout(Duration(seconds: 5), onTimeout: () {
            return null;
          });

    if (response.statusCode == 200) {
      // await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getProduct->' + data.toString());
      //countInt
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataNewProp.add(DataNewProperty.fromJson(i));
          // _imageUrls.add(map[dataBanners][i.length]["image"]);
        }
        // _controller.load(dataNewProp.v)
        double lat = double.parse(dataNewProp[0].latitude);
        double lng = double.parse(dataNewProp[0].longitude);
        _center = LatLng(lat, lng);

        markers.add(Marker(
            markerId: MarkerId('1'),
            position: _center,
            infoWindow: InfoWindow(
                title: dataNewProp[0].title, snippet: dataNewProp[0].longitude)
            // icon: _center
            )); //latitude
      });
      getGraphData();
    } else {
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getProduct->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> getGraphData() async {
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
    dataGraphData.clear();
    salesData.clear();
    print('AREAID===' + dataNewProp[0].area.area_id);

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/graph.php?area_id=" +
        dataNewProp[0].area.area_id);

    if (response.statusCode == 200) {
      // await pr.hide();
      final data = jsonDecode(response.body);

      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getGraphData->' + data.toString());
      //countInt
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataGraphData.add(DataGraphData.fromJson(i));
          // _imageUrls.add(map[dataBanners][i.length]["image"]);

          print(dataGraphData.length.toString());
        }
        for (int j = 0; j < dataGraphData.length; j++) {
          salesData.add(SalesData(dataGraphData[j].year.toString(),
              double.parse(dataGraphData[j].value)));
        }
        print('SalesDATA======');
        print(salesData.length.toString());
      });
    } else {
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getGraphData->error');

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

/*
   List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      // new LinearSales(0, 0),
      new LinearSales(int.parse(dataGraphData[0].year.toString()), int.parse(dataGraphData[0].value)),
      new LinearSales(int.parse(dataGraphData[1].year.toString()), int.parse(dataGraphData[1].value)),
      new LinearSales(int.parse(dataGraphData[2].year.toString()), int.parse(dataGraphData[2].value)),
    ];
    //  var data;
    // for(int i =0 ;i<dataGraphData.length;i++){
    //   setState(() {
    //     data  = [LinearSales( int.parse(dataGraphData[i].value),int.parse(dataGraphData[i].year.toString())),].toList();
    //
    //   });
    // }
    print("LinearSales=="+dataGraphData[1].year.toString());

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
*/

  Future<void> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String json = prefs.get('memberJson');
      // print('getDetails='+json.toString());
      for (Map i in jsonDecode(json)) {
        dataMemDe.add(DataMemberDetails.fromJson(i));
      }
    });
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

//catid==1? only 4 Property options
// (only 4 grid view) when catId =1a
// propertyCommission = 1 appBar = req on call(types=feets or square yards)//or else ReqOnCall
class DataGraphData {
  String id;
  String title;
  String value;
  var year;

  DataGraphData({this.id, this.title, this.value, this.year});

  factory DataGraphData.fromJson(Map<String, dynamic> json) {
    return DataGraphData(
      id: json['id'],
      title: json['title'],
      value: json['value'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    data['year'] = this.year;
    return data;
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
//id = 3
//change title to customer(LEAD DETAILS TO ) details , and lead name to customer name.