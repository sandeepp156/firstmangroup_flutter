import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:firstmangroup_flutter/MyCreditsScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firstmangroup_flutter/DataAges.dart';
import 'package:firstmangroup_flutter/DataFacings.dart';
import 'package:firstmangroup_flutter/DataPackages.dart';
import 'package:firstmangroup_flutter/DataPosse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'BannersScreen.dart';
import 'DataCategory.dart';
import 'DataCities.dart';
import 'DataFurnished.dart'; //
import 'DataPropGallery.dart';
import 'customcolor.dart';

void main() {
  runApp(FilterScreen());
}

class FilterScreen extends StatefulWidget {
  final String type;

  FilterScreen({this.type});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

final List<DataCities> dataCities = new List<DataCities>();
final List<DataAreas> dataAreas = new List<DataAreas>();
final List<DataCategory> dataCategory = new List<DataCategory>();
final List<DataPackages> dataPackages = new List<DataPackages>();
final List<DataFurnished> dataFurnished = new List<DataFurnished>();
final List<DataFacings> dataFacings = new List<DataFacings>();
final List<DataAges> dataAges = new List<DataAges>();
final List<DataPosse> dataPosse = new List<DataPosse>();
final List<String> areaIDList = new List<String>();
final List<String> areaNames = new List<String>();
final List<String> ids = new List<String>();

final List<DataPropGallery> dataPropGallery = new List<DataPropGallery>();
final List<String> dataBhk = [
  '1BHK',
  '2BHK',
  '3BHK',
  '4BHK',
];
final List<String> dataParking = [
  'Yes',
  'No',
];

GlobalKey sliderKey;

int isSelected = -1;
int isSelected_bhk = -1;
int isSelected_pose = -1;
int isSelected_propAge = -1;
int isSelected_faceing = -1;
int isSelected_furnished = -1;
int isSelected_parking = -1;
int isSelected_packages = -1;
int areaa;

bool cityPopup = false, citysList = true, imagePopup = false;
bool checkBox = false;
var cityId, city = 'City';
var areaId, area = 'Select Area';
var ext = '';
String img_id;
bool submit = true;
int areaInt;
RangeValues _priceRange = RangeValues(500000, 50000000);
RangeValues _areaRange = RangeValues(0, 10);
var pricerangeValue_Start = 0, pricerangeValue_end = 0;
var areaRangeValue_start = 0, areaRangeValue_end = 0;

TextEditingController areaController = new TextEditingController(),
    sellingPriceCtrl = new TextEditingController(),
    commPiceCntrl = new TextEditingController(),
    propCtrl = new TextEditingController(),
    desCntrl = new TextEditingController();

class _FilterScreenState extends State<FilterScreen> {
  final String type;

  _FilterScreenState({this.type});

  double _value = 1;
  File _image;
  List<File> usrImgs = [];
  List<String> usrImgsPath = [];
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    getCategoryData();
    getCitiesData();
    getFacingsData();
    getFurnishedData();
    getPossesData();
    getAgesData();
    getPackagesData();
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
                Container(
                  alignment: Alignment.centerLeft,
                  // height: 45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Filter',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            submit = true;
                          });
                          clearAllFilters();
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Image.asset(
                            'drawable/app_new_icon.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.text_colors_black,
                ),
                Expanded(
                  child: submit
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 15, bottom: 5),
                              child: Text(
                                'Location',
                                style: TextStyle(
                                    fontSize: 18,
                                    // color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        cityPopup = true;
                                        citysList = true;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 25),
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 2, bottom: 2),
                                      color: GlobalVariable.blue_main,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            city,
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontFamily:
                                                    GlobalVariable.Gotham),
                                          ),
                                          Image.asset(
                                            'drawable/down_arr.png',
                                            height: 10,
                                            width: 10,
                                            color: GlobalVariable.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        cityPopup = true;
                                        citysList = false;
                                      });
                                    },
                                    child: Container(
                                      height: 20,
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 3, bottom: 3),
                                      margin: EdgeInsets.only(
                                          left: 5, bottom: 25, right: 10),
                                      color: GlobalVariable.blue_main,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: TextField(
                                              controller: areaController,
                                              enabled: false,
                                              maxLength: 15,
                                              // keyboardType: TextInputType.phone,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  color: GlobalVariable.white,
                                                  fontSize: 14),
                                              decoration: InputDecoration(
                                                counterText: "",
                                                contentPadding:
                                                    EdgeInsets.only(top: -15.0,bottom: 18),
                                                enabledBorder: InputBorder.none,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          // Text(
                                          //   area,
                                          //   overflow: TextOverflow.ellipsis,
                                          //
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //       color: GlobalVariable.blue_main,
                                          //       fontFamily: GlobalVariable.Gotham),
                                          // ),
                                          Image.asset(
                                            'drawable/down_arr.png',
                                            height: 10,
                                            width: 10,
                                            color: GlobalVariable.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Property Type',
                                style: TextStyle(
                                    fontSize: 18,
                                    // color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 5, left: 15),
                                    height: 125,
                                    width: 300,
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 5,
                                          // childAspectRatio: MediaQuery.of(context)
                                          //     .size
                                          //     .width /
                                          // (MediaQuery.of(context).size.height / 8),
                                        ),
                                        itemCount: dataCategory.length == 0
                                            ? 0
                                            : dataCategory.length,
                                        itemBuilder: (context, pos) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelected = pos;
                                              });
                                            },
                                            child: Container(
                                              // color: Colors.blueAccent,
                                              margin: EdgeInsets.only(
                                                  left: 10, bottom: 10),
                                              height: 10,
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    isSelected != null &&
                                                            isSelected == pos
                                                        ? 'drawable/tiechecked.png'
                                                        : 'drawable/tieunchecked.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        dataCategory[pos].title,
                                                        maxLines: 3,
                                                        // 'Open Plots',
                                                        style: TextStyle(
                                                            color:
                                                                GlobalVariable
                                                                    .blue_main,
                                                            fontFamily:
                                                                GlobalVariable
                                                                    .Gotham,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            //PRICE
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 18,
                                        // color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'drawable/rupee.png',
                                          height: 10,
                                        ),
                                        Text(
                                          '' + pricerangeValue_Start.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(
                                          '' + pricerangeValue_end.toString(),
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable
                                                  .text_colors_black),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /*     Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium),
                            ),
                            // SizedBox(width: 200,),

                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset('drawable/rupee.png',height: 10,),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.text_colors_black),
                                  ),
                                  Text(
                                    ' - ',
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.text_colors_black),
                                  ),
                                  Text(
                                    isSelected == 0
                                        ? '$_value'
                                        : isSelected == 3
                                        ? '$_value'
                                        : '$_value' ,
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.text_colors_black),
                                  )
                                ],
                              ),
                            ),



                          ],
                        ),
                      ),*/
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),

                                    // color: GlobalVariable.grey_main,
                                    child: Column(
                                      children: [
                                        RangeSlider(
                                            // key: sliderKey,
                                            min: 0,
                                            max: 50000000,
                                            values: _priceRange,
                                            divisions: 500000,
                                            activeColor:
                                                GlobalVariable.yellow_main,
                                            labels: RangeLabels(
                                                _priceRange.start.toString(),
                                                _priceRange.end.toString()),
                                            onChanged: (values) {
                                              print('PricerangeValues:' +
                                                  values.toString());
                                              setState(() {
                                                pricerangeValue_Start =
                                                    values.start.toInt();
                                                pricerangeValue_end =
                                                    values.end.toInt();
                                                _priceRange = values;
                                                if (values.end - values.start >=
                                                    10000) {
                                                  _priceRange = values;
                                                } else {
                                                  if (_priceRange.start ==
                                                      values.start) {
                                                    _priceRange = RangeValues(
                                                        _priceRange.start,
                                                        _priceRange.start +
                                                            10000);
                                                  } else {
                                                    _priceRange = RangeValues(
                                                        _priceRange.end - 10000,
                                                        _priceRange.end);
                                                  }
                                                }
                                              });
                                            }),
                                        // Slider(
                                        //   min: 0,
                                        //   max: 1000,
                                        //   value: _value,
                                        //   divisions: 1000,
                                        //   activeColor: GlobalVariable.yellow_main,
                                        //   // inactiveColor: GlobalVariable.yellow_main,
                                        //   label: '$_value',
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       _value = value;
                                        //       // print('sliderValue'+value.toString());
                                        //     });
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Visibility(
                              visible: isSelected == 0 ? false : true,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, top: 20),
                                child: Text(
                                  'Bedrooms',
                                  style: TextStyle(
                                      fontSize: 18,

                                      // color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isSelected == 0 ? false : true,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                // padding: EdgeInsets.all(10),
                                // height: 80,
                                // width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalVariable.text_colors_black),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          20.0) //                 <--- border radius here
                                      ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = 1;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: isSelected_bhk == 1
                                                  ? GlobalVariable.yellow_main
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topLeft:
                                                      Radius.circular(20))),
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              '1BHK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected_bhk == 1
                                                      ? GlobalVariable.white
                                                      : GlobalVariable
                                                          .text_colors_black,
                                                  fontFamily:
                                                      GlobalVariable.Gotham),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 1,
                                      color: GlobalVariable.text_colors_black,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = 2;
                                          });
                                        },
                                        child: Container(
                                          color: isSelected_bhk == 2
                                              ? GlobalVariable.yellow_main
                                              : Colors.transparent,
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              '2BHK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected_bhk == 2
                                                      ? GlobalVariable.white
                                                      : GlobalVariable
                                                          .text_colors_black,
                                                  fontFamily:
                                                      GlobalVariable.Gotham),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 1,
                                      color: GlobalVariable.text_colors_black,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = 3;
                                          });
                                        },
                                        child: Container(
                                          color: isSelected_bhk == 3
                                              ? GlobalVariable.yellow_main
                                              : Colors.transparent,
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              '3BHK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected_bhk == 3
                                                      ? GlobalVariable.white
                                                      : GlobalVariable
                                                          .text_colors_black,
                                                  fontFamily:
                                                      GlobalVariable.Gotham),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 1,
                                      color: GlobalVariable.text_colors_black,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = 4;
                                          });
                                        },
                                        child: Container(
                                          color: isSelected_bhk == 4
                                              ? GlobalVariable.yellow_main
                                              : Colors.transparent,
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              '4BHK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected_bhk == 4
                                                      ? GlobalVariable.white
                                                      : GlobalVariable
                                                          .text_colors_black,
                                                  fontFamily:
                                                      GlobalVariable.Gotham),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 1,
                                      color: GlobalVariable.text_colors_black,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = 5;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: isSelected_bhk == 5
                                                  ? GlobalVariable.yellow_main
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          height: 35,
                                          child: Center(
                                            child: Text(
                                              '5BHK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: isSelected_bhk == 5
                                                      ? GlobalVariable.white
                                                      : GlobalVariable
                                                          .text_colors_black,
                                                  fontFamily:
                                                      GlobalVariable.Gotham),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //AREA
                            /*   Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15,
                        bottom: 10),
                        child: Text(
                          'Area',
                          style: TextStyle(
                              fontSize: 18,
                              // color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                      ),*/
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    'Area',
                                    style: TextStyle(
                                        fontSize: 18,
                                        // color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Sqft ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(
                                          '' + areaRangeValue_start.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(
                                          '' + areaRangeValue_end.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),

                                    // color: GlobalVariable.grey_main,
                                    child: Column(
                                      children: [
                                        RangeSlider(
                                          min: 0,
                                          max: 10000,
                                          // values: _priceRange,
                                          divisions: 100,
                                          values: _areaRange,
                                          onChanged: (RangeValues value) {
                                            setState(() {
                                              areaRangeValue_start =
                                                  value.start.toInt();
                                              areaRangeValue_end =
                                                  value.end.toInt();
                                            });
                                            if (value.end - value.start >= 20) {
                                              _areaRange = value;
                                            } else {
                                              if (_areaRange.start ==
                                                  value.start) {
                                                _areaRange = RangeValues(
                                                    _areaRange.start,
                                                    _areaRange.start + 20);
                                              } else {
                                                _areaRange = RangeValues(
                                                    _areaRange.end - 20,
                                                    _areaRange.end);
                                              }
                                            }
                                          },
                                          activeColor:
                                              GlobalVariable.yellow_main,

                                          labels: RangeLabels(
                                              _areaRange.start.toString(),
                                              _areaRange.end.toString()),
                                          // divisions: 1000,
                                        ),

                                        /* RangeSlider(
                                      min: 0,
                                      max: 50000000,
                                      // values: _priceRange,
                                      values: _areaRange,
                                      // divisions: 1000,
                                      activeColor: GlobalVariable.yellow_main,
                                      labels: RangeLabels(
                                          _areaRange.start.toString(),
                                          _areaRange.end.toString()),
                                      onChanged: (values) {
                                        // print('newrange');
                                        setState(() {
                                          areaRangeValue_start = values.start.toInt();
                                          areaRangeValue_end = values.end.toInt();
                                          _areaRange = values;
                                          if (values.end - values.start >=
                                              200) {
                                            _areaRange = values;
                                          } else {
                                            if (_areaRange.start ==
                                                values.start) {
                                              _areaRange = RangeValues(
                                                  _areaRange.start,
                                                  _areaRange.start + 200);
                                            } else {
                                              _areaRange = RangeValues(
                                                  _areaRange.end - 200,
                                                  _areaRange.end);
                                            }
                                          }
                                        });
                                      }),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //POSSESSION
                            Visibility(
                              visible: isSelected == 0 ? false : true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 13, top: 20),
                                child: Text(
                                  'Posession',
                                  style: TextStyle(
                                      fontSize: 18,
                                      // color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isSelected == 0 ? false : true,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 15, bottom: 5, left: 20),
                                      height: 125,
                                      width: 300,
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 5,
                                            // childAspectRatio: MediaQuery.of(context)
                                            //     .size
                                            //     .width /
                                            // (MediaQuery.of(context).size.height / 8),
                                          ),
                                          itemCount: dataPosse.length == 0
                                              ? 0
                                              : dataPosse.length,
                                          itemBuilder: (context, pos) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isSelected_pose = pos;
                                                });
                                              },
                                              child: Container(
                                                // color: Colors.blueAccent,
                                                margin: EdgeInsets.only(
                                                    left: 10, bottom: 10),
                                                height: 10,
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                      isSelected_pose != null &&
                                                              isSelected_pose ==
                                                                  pos
                                                          ? 'drawable/tiechecked.png'
                                                          : 'drawable/tieunchecked.png',
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                          dataPosse[pos].title,
                                                          maxLines: 3,
                                                          // 'Open Plots',
                                                          style: TextStyle(
                                                              color:
                                                                  GlobalVariable
                                                                      .blue_main,
                                                              fontFamily:
                                                                  GlobalVariable
                                                                      .Gotham,
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*











                     */
                          ],
                        )
                      : dataPropGallery.length == 0
                          ? Center(
                              child: Text('No data'),
                            )
                          : ListView.builder(
                              itemCount: dataPropGallery.length == 0
                                  ? 0
                                  : dataPropGallery.length,
                              itemBuilder: (context, pos) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => BannersScreen(
                                                id: dataPropGallery[pos].id,
                                                typeId: '0',
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: GlobalVariable.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: GlobalVariable.grey_main_,
                                              offset: Offset(3, 3),
                                              blurRadius: 5)
                                        ]),
                                    margin: EdgeInsets.only(
                                        bottom: 10, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 180,
                                          child: Stack(
                                            children: [
                                              Visibility(
                                                  visible:
                                                      dataPropGallery.length ==
                                                              0
                                                          ? false
                                                          : true,
                                                  child: Image.network(
                                                    dataPropGallery[pos].image1,
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                  )),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 25, right: 20),
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                                  color: GlobalVariable.white,
                                                  child: Text(
                                                    dataPropGallery.length !=
                                                            null
                                                        ? dataPropGallery[pos]
                                                            .title
                                                            .toString()
                                                        : 'title',
                                                    // 'asdfdsfds',

                                                    // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium,
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Image.asset(
                                                      'drawable/rupee.png',
                                                      height: 15,
                                                      width: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    dataPropGallery[pos]
                                                        .priceDisp,
                                                    style: TextStyle(
                                                        color: GlobalVariable
                                                            .blue_main,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .Gotham,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    child: Image.asset(
                                                      'drawable/location.png',
                                                      height: 15,
                                                      width: 10,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      dataPropGallery[pos]
                                                              .area
                                                              .title +
                                                          ',' +
                                                          dataPropGallery[pos]
                                                              .city
                                                              .title,
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .blue_main,
                                                          fontFamily:
                                                              GlobalVariable
                                                                  .Gotham,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                ),
                Visibility(
                  visible: submit,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: GlobalVariable.blue_main,
                      // borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            submit = false;
                          });
                          getFilterData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Text(
                            "SUBMIT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: GlobalVariable.GothamMedium,
                                color: GlobalVariable.yellow_main,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            //popup
            Visibility(
              visible: cityPopup,
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cityPopup = false;
                    });
                  },
                  child: Container(
                    color: GlobalVariable.grey_main.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        top: 50, bottom: 50, left: 15, right: 15),
                    child: Center(
                      child: dataCities.length == 0
                          ? Text('Please wait..')
                          : citysList == true
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: dataCities.length,
                                    itemBuilder: (context, pos) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            city = dataCities[pos].title;
                                            cityId = dataCities[pos].id;
                                            area = 'Area';
                                            areaController.text = 'Area';
                                            areaId = '-1';
                                            getAreasData(cityId);
                                            cityPopup = false;
                                            ids.clear();
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: GlobalVariable.white,
                                          margin: EdgeInsets.only(
                                              left: 25, right: 25),
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Text(
                                            dataCities[pos].title,
                                            style: TextStyle(
                                                fontFamily:
                                                    GlobalVariable.Gotham,
                                                fontSize: 16,
                                                color:
                                                    GlobalVariable.blue_main),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30),
                                        height: 1,
                                        color: GlobalVariable.grey_main,
                                      );
                                    },
                                  ),
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        itemCount: dataAreas.length,
                                        itemBuilder: (context, pos) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  area = dataAreas[pos].title;
                                                  // areaController.text =
                                                  //     dataAreas[pos].title;

                                                  areaId = dataAreas[pos].id;
                                                  // cityPopup = false;
                                                  areaInt = pos;

                                                  // getAreasData(cityId);
                                                  if(ids.contains(dataAreas[pos].id)){
                                                    ids.remove(dataAreas[pos].id);
                                                    areaIDList
                                                        .remove(dataAreas[pos].id);
                                                    areaNames
                                                        .remove(dataAreas[pos].title);
                                                  }
                                                  else{
                                                    ids.add(dataAreas[pos].id);
                                                    areaIDList
                                                        .add(dataAreas[pos].id);
                                                    areaNames
                                                        .add(dataAreas[pos].title);
                                                  }
                                                });



                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: GlobalVariable.white,
                                                margin: EdgeInsets.only(
                                                    left: 25, right: 25),
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        dataAreas[pos].title,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                GlobalVariable
                                                                    .Gotham,
                                                            fontSize: 14,
                                                            color: GlobalVariable
                                                                .blue_main),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    //isSelected != null &&isSelected == pos
                                                    Image.asset(
                                                      ids.length == 0
                                                          ? 'drawable/checkoff.png'
                                                          : ids.contains(
                                                                  dataAreas[pos]
                                                                      .id)
                                                              ? 'drawable/checkon.png'
                                                              : 'drawable/checkoff.png',
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 30, right: 30),
                                            height: 1,
                                            color: GlobalVariable.grey_main,
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      color: GlobalVariable.white,
                                      margin:
                                          EdgeInsets.only(left: 25, right: 25),
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  cityPopup = false;
                                                  /* for(int i = 0;i<=areaIDList.length;i++){
                                                    areaController.text = areaNames[i];
                                                  }*/
                                                  print('AreaNames==' +
                                                      areaNames
                                                          .toString()
                                                          .split('[')[1]);
                                                  areaController.text =
                                                      areaNames.toString();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 5),
                                                decoration: BoxDecoration(
                                                    color: GlobalVariable
                                                        .yellow_main,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'Apply',
                                                  textAlign: TextAlign.center,

                                                  // 'Open Plots',
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  cityPopup = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.only(
                                                    right: 10, left: 5),
                                                decoration: BoxDecoration(
                                                    color: GlobalVariable
                                                        .yellow_main,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  'Cancel',
                                                  textAlign: TextAlign.center,
                                                  // 'Open Plots',
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCitiesData() async {
    dataCities.clear();
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/cities.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCities.add(DataCities.fromJson(i));
        }
      });
      print('getCities->' + data.toString());
    } else {
      print('getCities->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getAreasData(String cityID) async {
    dataAreas.clear();
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
    final response = await http.get(
        "https://" + GlobalVariable.BASE_URL + "/api/areas.php?city=" + cityID);
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataAreas.add(DataAreas.fromJson(i));
        }
      });
      //countInt
    } else {
      await pr.hide();
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getCategoryData() async {
    dataCategory.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/category.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCategory.add(DataCategory.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getPossesData() async {
    dataPosse.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/possessions.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPosse.add(DataPosse.fromJson(i));
        }
      });
      print('getPossesData->' + data.toString());
      //countInt
    } else {
      print('getPossesData->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getAgesData() async {
    dataAges.clear();

    final response =
        await http.get("https://" + GlobalVariable.BASE_URL + "/api/ages.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataAges.add(DataAges.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
      //countInt
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getFacingsData() async {
    dataFacings.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/facings.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataFacings.add(DataFacings.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
      //countInt
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getFurnishedData() async {
    dataFurnished.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/furnished.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataFurnished.add(DataFurnished.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
      //countInt
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getPackagesData() async {
    dataPackages.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/packages.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPackages.add(DataPackages.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
      //countInt
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      /* if (imagePopup == true) {
        print("imagePopup==true");
        imagePopup = false;
      } else {
        print("imagePopup==false");
        super.dispose();
      }*/
      clearAllFilters();
    });
  }

  Future<void> getFilterData() async {
    dataPropGallery.clear();
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

    print('AREAIDS');
    print(areaIDList.join(","));

    var queryPrams = {
      'category': dataCategory[isSelected].id,
      'page': '0',
      'sorting': '',
      'bhk': isSelected_bhk == -1 ? '' : isSelected_bhk.toString(),
      'sqft': _areaRange.start.toInt().toString() +
          '-' +
          _areaRange.end.toInt().toString(),
      'from': _priceRange.start.toInt().toString() +
          '-' +
          _priceRange.end.toInt().toString(),
      'possession': isSelected_pose == -1 ? '' : isSelected_pose.toString(),
      'city': prefs.getString('cityId'),
      'area': areaIDList.length == 0 ? '' : areaIDList.join(",").toString(),
    };
    print(queryPrams);
    var uri = Uri.https(
        GlobalVariable.BASE_URL,
        widget.type == '0' ? '/api/properties.php' : '/api/properties_new.php',
        queryPrams);
    print(uri);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPropGallery.add(DataPropGallery.fromJson(i));
        }
      });
    } else {
      print('data->error');
      throw Exception('Failed to load album');
    }
  }

  void clearAllFilters() {
    setState(() {
      submit = true;
      city = 'City';
      cityId = '';
      area = 'Select Area';
      areaId = '';
      isSelected = -1;
      isSelected_bhk = -1;
      areaIDList.clear();
      areaNames.clear();
      areaController.clear();
      isSelected_pose = -1;
      // _areaRange.start 0.0;
    });
  }
}

class DataAreas {
  String id;
  String image;
  String title;

  DataAreas({this.id, this.image, this.title});

  factory DataAreas.fromJson(Map<String, dynamic> json) {
    return DataAreas(
      id: json['id'],
      image: json['image'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

//parking 0 and 1
//bhk 1 to 4
//flutter: https://firstmangroup.in/api/inventory_sale.php?member_id=4&title=Test+Ios&category=2&city=1&area=2&location=Benz+Circle%2CVijayawada&sqft=269.0&price=300000&commission=10000&possession=Ready+to+Move&age=Less+than+1+Year&facing=East&furnishing=Semi+Furnished&package=GOLD+%2845DAYS%29&parking=Yes&bhk=3BHK&description=Testing+Ios+
// flutter: sendInventDetails->{status: Success, sale_id: 872, message: Upload Images}//
//<key>NSPhotoLibraryUsageDescription</key>
// 	<key>NSCameraUsageDescription</key>
// 	<key>NSMicrophoneUsageDescription</key>
