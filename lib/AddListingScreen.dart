import 'dart:convert';
import 'dart:io';
import 'dart:ui';
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

import 'DataCategory.dart';
import 'DataCities.dart';
import 'DataFurnished.dart'; //
import 'customcolor.dart';

void main() {
  runApp(AddLisitingScreen());
}

class AddLisitingScreen extends StatefulWidget {
  @override
  _AddLisitingScreenState createState() => _AddLisitingScreenState();
}

final List<DataCities> dataCities = new List<DataCities>();
final List<DataAreas> dataAreas = new List<DataAreas>();
final List<DataCategory> dataCategory = new List<DataCategory>();
final List<DataPackages> dataPackages = new List<DataPackages>();
final List<DataFurnished> dataFurnished = new List<DataFurnished>();
final List<DataFacings> dataFacings = new List<DataFacings>();
final List<DataAges> dataAges = new List<DataAges>();
final List<DataPosse> dataPosse = new List<DataPosse>();
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


int isSelected = -1;
int isSelected_bhk = -1;
int isSelected_pose = -1;
int isSelected_propAge = -1;
int isSelected_faceing = -1;
int isSelected_furnished = -1;
int isSelected_parking = -1;
int isSelected_packages = -1;

bool cityPopup = false, citysList = true, imagePopup = false;
var cityId, city = 'City';
var areaId, area = 'Area';
var ext = '';
String img_id;

TextEditingController areaController = new TextEditingController(),
    sellingPriceCtrl = new TextEditingController(),
    commPiceCntrl = new TextEditingController(),
    propCtrl = new TextEditingController(),
    desCntrl = new TextEditingController();

class _AddLisitingScreenState extends State<AddLisitingScreen> {
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
                SizedBox(
                  height: 45,
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
                          'Enter Property Details',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: GlobalVariable.grey_main_,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
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
                                margin: EdgeInsets.only(
                                    left: 10, top: 25, bottom: 25),
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 2, bottom: 2),
                                color: GlobalVariable.grey_main,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      city,
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.Gotham),
                                    ),
                                    Image.asset(
                                      'drawable/down_arr.png',
                                      height: 10,
                                      width: 10,
                                      color: GlobalVariable.blue_main,
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
                                    left: 5, top: 25, bottom: 25, right: 10),
                                color: GlobalVariable.grey_main,
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
                                            fontFamily: GlobalVariable.Gotham,
                                            color: GlobalVariable.blue_main,
                                            fontSize: 12),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.only(top: -23.0),
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
                                      color: GlobalVariable.blue_main,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 110,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 20, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              children: [
                                Image.asset(
                                  'drawable/location.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Location',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 25,
                              margin: EdgeInsets.only(
                                  left: 10, top: 25, bottom: 25),
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              color: GlobalVariable.grey_main,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'drawable/propery_type_rupee_syembol.png',
                                    height: 15,
                                    width: 10,
                                    color: GlobalVariable.blue_main,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: sellingPriceCtrl,
                                      // enabled: false,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: GlobalVariable.Gotham,
                                          color: GlobalVariable.blue_main,
                                          fontSize: 12),
                                      decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.only(top: -23.0),
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintText: 'Enter selling price',
                                          hintStyle: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontSize: 10,
                                              fontFamily:
                                                  GlobalVariable.Gotham)),
                                    ),
                                  ),
                                  // Text(
                                  //   'Enter Selling Price',
                                  //   style: TextStyle(
                                  //       color: GlobalVariable.blue_main,
                                  //       fontFamily: GlobalVariable.Gotham,
                                  //       fontSize: 10),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              margin: EdgeInsets.only(
                                  left: 5, top: 25, bottom: 25, right: 10),
                              color: GlobalVariable.grey_main,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: commPiceCntrl,
                                      // enabled: false,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: GlobalVariable.Gotham,
                                          color: GlobalVariable.blue_main,
                                          fontSize: 12),
                                      decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.only(top: -23.0),
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintText: 'Commission at final price',
                                          hintStyle: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontSize: Platform.isIOS ? 8 : 10,
                                              fontFamily:
                                                  GlobalVariable.Gotham)),
                                    ),
                                  ),
                                  // Text(
                                  //   'Commission at final price',
                                  //   style: TextStyle(
                                  //       color: GlobalVariable.blue_main,
                                  //       fontFamily: GlobalVariable.Gotham,
                                  //       fontSize: 10),
                                  // ),
                                  // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 110,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 9, top: 20, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              children: [
                                Image.asset(
                                  'drawable/budget.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Budget',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      //propertyType
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 15, bottom: 5, left: 3),
                              height: 110,
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
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: SizedBox(
                                                width: 100,
                                                child: Text(
                                                  dataCategory[pos].title,
                                                  maxLines: 3,
                                                  // 'Open Plots',
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
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
                          Container(
                            height: 110,
                            width: 80,
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'drawable/propertytype.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Property\nType',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      //bhk
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // height: 80,
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
                                    itemCount: dataBhk.length,
                                    itemBuilder: (context, pos) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_bhk = pos;
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
                                                isSelected_bhk != null &&
                                                        isSelected_bhk == pos
                                                    ? 'drawable/tiechecked.png'
                                                    : 'drawable/tieunchecked.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    dataBhk[pos],
                                                    maxLines: 3,
                                                    // 'Open Plots',
                                                    style: TextStyle(
                                                        color: GlobalVariable
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
                            // Expanded(
                            //   child: Container(
                            //     padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                            //     margin: EdgeInsets.only(left: 5,right: 10),
                            //
                            //     // color: GlobalVariable.grey_main,
                            //     child:  Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 10),
                            //           child: Text('Independent\nHouses/Villas',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 110,
                              width: 80,
                              padding: EdgeInsets.only(
                                  left: 11, right: 10, top: 20, bottom: 20),
                              color: GlobalVariable.yellow_main,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'drawable/bhk_one.png',
                                    height: 35,
                                    width: 50,
                                  ),
                                  Text(
                                    'BHK',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Container(
                          height: 1,
                          color: GlobalVariable.grey_main_,
                        ),
                      ),
                      //area
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
                                  Slider(
                                    min: 0,
                                    max: 1000,
                                    value: _value,
                                    divisions: 1000,
                                    activeColor: GlobalVariable.yellow_main,
                                    // inactiveColor: GlobalVariable.yellow_main,
                                    label: '$_value',
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                        // print('sliderValue'+value.toString());
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          '0',
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main),
                                        ),
                                        Spacer(),
                                        Text(
                                          isSelected == 0
                                              ? '$_value' + 'Sq.Yards'
                                              : isSelected == 3
                                                  ? '$_value' + 'Sq.Yards'
                                                  : '$_value' + ' Sqft',
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 110,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 11, right: 10, top: 20, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'drawable/area_one.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Area',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      //Posession
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 3),
                                height: 110,
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
                                                        isSelected_pose == pos
                                                    ? 'drawable/tiechecked.png'
                                                    : 'drawable/tieunchecked.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    dataPosse[pos].title,
                                                    maxLines: 3,
                                                    // 'Open Plots',
                                                    style: TextStyle(
                                                        color: GlobalVariable
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
                            Container(
                              height: 110,
                              width: 80,
                              padding: EdgeInsets.only(
                                  top: 20, left: 5, right: 5, bottom: 20),
                              color: GlobalVariable.yellow_main,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'drawable/posession_one.png',
                                    height: 35,
                                    width: 50,
                                  ),
                                  Text(
                                    'Posession',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Container(
                          height: 1,
                          color: GlobalVariable.grey_main_,
                        ),
                      ),
                      //Property Age
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 3),
                                height: 110,
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
                                    itemCount: dataAges.length == 0
                                        ? 0
                                        : dataAges.length,
                                    itemBuilder: (context, pos) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_propAge = pos;
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
                                                isSelected_propAge != null &&
                                                        isSelected_propAge ==
                                                            pos
                                                    ? 'drawable/tiechecked.png'
                                                    : 'drawable/tieunchecked.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    dataAges[pos].title,
                                                    maxLines: 3,
                                                    // 'Open Plots',
                                                    style: TextStyle(
                                                        color: GlobalVariable
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
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 9, top: 20, bottom: 20),
                              color: GlobalVariable.yellow_main,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'drawable/purchasedate.png',
                                    height: 35,
                                    width: 50,
                                  ),
                                  Text(
                                    'Property\nAge',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Container(
                          height: 1,
                          color: GlobalVariable.grey_main_,
                        ),
                      ),
                      //Facing
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 15, bottom: 5, left: 3),
                              height: 150,
                              // width: 300,
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
                                  itemCount: dataFacings.length == 0
                                      ? 0
                                      : dataFacings.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSelected_faceing = pos;
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
                                              isSelected_faceing != null &&
                                                      isSelected_faceing == pos
                                                  ? 'drawable/tiechecked.png'
                                                  : 'drawable/tieunchecked.png',
                                              height: 15,
                                              width: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: SizedBox(
                                                width: 100,
                                                child: Text(
                                                  dataFacings[pos].title,
                                                  maxLines: 3,
                                                  // 'Open Plots',
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
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
                          Container(
                            height: 150,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 9, top: 20, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'drawable/propery_type_facing.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Facing',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      //Furnished
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 3),
                                height: 100,
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
                                    itemCount: dataFurnished.length == 0
                                        ? 0
                                        : dataFurnished.length,
                                    itemBuilder: (context, pos) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_furnished = pos;
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
                                                isSelected_furnished != null &&
                                                        isSelected_furnished ==
                                                            pos
                                                    ? 'drawable/tiechecked.png'
                                                    : 'drawable/tieunchecked.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    dataFurnished[pos].title,
                                                    maxLines: 3,
                                                    // 'Open Plots',
                                                    style: TextStyle(
                                                        color: GlobalVariable
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
                            Container(
                              height: 110,
                              width: 80,
                              padding: EdgeInsets.only(
                                  left: 10, right: 9, top: 20, bottom: 20),
                              color: GlobalVariable.yellow_main,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'drawable/budget.png',
                                    height: 35,
                                    width: 50,
                                  ),
                                  Text(
                                    'Furnished',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Container(
                          height: 1,
                          color: GlobalVariable.grey_main_,
                        ),
                      ),
                      //parking
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 3),
                                height: 60,
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
                                    itemCount: dataParking.length == 0
                                        ? 0
                                        : dataParking.length,
                                    itemBuilder: (context, pos) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isSelected_parking = pos;
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
                                                isSelected_parking != null &&
                                                        isSelected_parking ==
                                                            pos
                                                    ? 'drawable/tiechecked.png'
                                                    : 'drawable/tieunchecked.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    dataParking[pos],
                                                    maxLines: 3,
                                                    // 'Open Plots',
                                                    style: TextStyle(
                                                        color: GlobalVariable
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
                            Container(
                              height: 110,
                              width: 80,
                              padding: EdgeInsets.only(
                                  left: 10, right: 9, top: 20, bottom: 20),
                              color: GlobalVariable.yellow_main,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'drawable/parking.png',
                                    height: 35,
                                    width: 50,
                                  ),
                                  Text(
                                    'Parking',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isSelected == 0
                            ? false
                            : isSelected == 3
                                ? false
                                : true,
                        child: Container(
                          height: 1,
                          color: GlobalVariable.grey_main_,
                        ),
                      ),
                      //Packages
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: 15, bottom: 5, left: 3),
                              height: 60,
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
                                  itemCount: dataPackages.length == 0
                                      ? 0
                                      : dataPackages.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSelected_packages = pos;
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
                                              isSelected_packages != null &&
                                                      isSelected_packages == pos
                                                  ? 'drawable/tiechecked.png'
                                                  : 'drawable/tieunchecked.png',
                                              height: 15,
                                              width: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: SizedBox(
                                                width: 100,
                                                child: Text(
                                                  dataPackages[pos].title,
                                                  maxLines: 3,
                                                  // 'Open Plots',
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
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
                          Container(
                            height: 110,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 9, top: 20, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              children: [
                                Image.asset(
                                  'drawable/propery_type_rupee_syembol.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Packages',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: GlobalVariable.grey_main_,
                      ),
                      //Description
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 3),
                                // height: 110,
                                // width: 300,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 25,
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5),
                                      padding: EdgeInsets.only(left: 5),
                                      color: GlobalVariable.grey_main,
                                      child: Flexible(
                                        child: TextField(
                                          controller: propCtrl,
                                          // enabled: false,
                                          maxLength: 15,
                                          // keyboardType: TextInputType.phone,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main,
                                              fontSize: 12),
                                          decoration: InputDecoration(
                                              counterText: "",
                                              contentPadding:
                                                  EdgeInsets.only(top: -20.0),
                                              enabledBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              hintText: 'Property Title',
                                              hintStyle: TextStyle(
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      GlobalVariable.Gotham)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 65,
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      padding: EdgeInsets.only(left: 5),
                                      color: GlobalVariable.grey_main,
                                      child: Flexible(
                                        child: TextField(
                                          controller: desCntrl,
                                          // enabled: false,
                                          maxLength: 15,
                                          // keyboardType: TextInputType.phone,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main,
                                              fontSize: 12),
                                          decoration: InputDecoration(
                                              counterText: "",
                                              contentPadding:
                                                  EdgeInsets.only(top: -20.0),
                                              enabledBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              hintText: 'Write About Property',
                                              hintStyle: TextStyle(
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      GlobalVariable.Gotham)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 9, top: 50, bottom: 20),
                            color: GlobalVariable.yellow_main,
                            child: Column(
                              children: [
                                Image.asset(
                                  'drawable/budget.png',
                                  height: 35,
                                  width: 50,
                                ),
                                Text(
                                  'Budget',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      // Container(height: 1,color: GlobalVariable.grey_main_,),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: GlobalVariable.blue_main,
                    // borderRadius: BorderRadius.circular(10)
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        sendInventDetails();
                        // getImage('872');
                        // Navigator.pushReplacement(
                        //   context,
                        //   new MaterialPageRoute(builder: (context) => ReferralCodeScreen()),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Text(
                          "NEXT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.yellow_main,
                              fontSize: 16),
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
    height: MediaQuery.of(context).size.height/1.2,
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
                                            left: 25, right: 25),
                                        height: 1,
                                        color: GlobalVariable.grey_main,
                                      );
                                    },
                                  ),
                              )
                              : Column(
                                  children: [
                                    Container(
                                      // color: ,
                                      height: 40,

                                      margin: EdgeInsets.only(
                                          left: 25, right: 25),
                                      decoration: BoxDecoration(
                                          color: GlobalVariable.grey_main,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              // controller: fnameCtrl,
                                              // maxLength: 10,
                                              // keyboardType:
                                              //     TextInputType.phone,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  color: GlobalVariable
                                                      .blue_main,
                                                  fontSize: 14),
                                              decoration: InputDecoration(
                                                  // counterText: "",
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: -5.0),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      fontFamily:
                                                          GlobalVariable
                                                              .Gotham,
                                                      color: GlobalVariable
                                                          .blue_main,
                                                      fontSize: 14),
                                                  hintText: 'Search Here'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 500,
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        itemCount: dataAreas.length,
                                        itemBuilder: (context, pos) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                area = dataAreas[pos].title;
                                                areaController.text =
                                                    dataAreas[pos].title;

                                                areaId = dataAreas[pos].id;
                                                cityPopup = false;
                                                // getAreasData(cityId);
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
                                                dataAreas[pos].title,
                                                style: TextStyle(
                                                    fontFamily:
                                                        GlobalVariable.Gotham,
                                                    fontSize: 16,
                                                    color: GlobalVariable
                                                        .blue_main),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context,
                                                int index) {
                                          return Container(
                                            height: 1,
                                            color: GlobalVariable.grey_main,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                ),
              ),
            ),

            //imagepopup
            Visibility(
                visible: imagePopup,
                // visible: true,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePopup = false;
                    });
                  },
                  child: Container(
                    color: GlobalVariable.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'Tap here to upload images',
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 20,
                              color: GlobalVariable.blue_main),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  getImage('892');
                                  setState(() {
                                    img_id = '1';
                                    // usrImgs.add(value)
                                  });
                                },
                                child: usrImgs.length == 0
                                    ? Image.asset(
                                        'drawable/uploadimage.png',
                                        height: 100,
                                        width: 75,
                                      )
                                    : Container(
                                        height: 100,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    FileImage(usrImgs[0]))))),
                            // InkWell(
                            //     onTap: () {
                            //       getImage('892');
                            //       setState(() {
                            //         img_id = '2';
                            //         // usrImgs.add(value)
                            //       });
                            //     },
                            //     child: usrImgs.length == 1
                            //         ? Image.asset(
                            //             'drawable/uploadimage.png',
                            //             height: 100,
                            //             width: 75,
                            //           )
                            //         : Container(
                            //             height: 100,
                            //             width: 75,
                            //             decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                     image:
                            //                         FileImage(usrImgs[1]))))),
                            // InkWell(
                            //     onTap: () {
                            //       getImage('892');
                            //       setState(() {
                            //         img_id = '3';
                            //         // usrImgs.add(value)
                            //       });
                            //     },
                            //     child: usrImgs.length == 2
                            //         ? Image.asset(
                            //             'drawable/uploadimage.png',
                            //             height: 100,
                            //             width: 75,
                            //           )
                            //         : Container(
                            //             height: 100,
                            //             width: 75,
                            //             decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                     image:
                            //                         FileImage(usrImgs[2]))))),
                            // InkWell(
                            //     onTap: () {
                            //       getImage('892');
                            //       setState(() {
                            //         img_id = '4';
                            //         // usrImgs.add(value)
                            //       });
                            //     },
                            //     child: usrImgs.length == 3
                            //         ? Image.asset(
                            //             'drawable/uploadimage.png',
                            //             height: 100,
                            //             width: 75,
                            //           )
                            //         : Container(
                            //             height: 100,
                            //             width: 75,
                            //             decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                     image:
                            //                         FileImage(usrImgs[3]))))),
                          ],
                        ),
                      ],
                    ),
                    // child:
                    // Container(
                    //       decoration: BoxDecoration(image: DecorationImage(image: FileImage(_image))),
                    //     ),
                    /*child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, pos) {
                          return Container(
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image))),
                          );
                        }),*/
                  ),
                ))
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

  Future<void> sendInventDetails() async {
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
    await pr.show();
    var queryParameters = {
      'member_id': '' +prefs.getString('member_id'),
      'title': '' + propCtrl.text.toString(),
      'category': '' + dataCategory[isSelected].id,
      'city': '' + cityId,
      'area': '' + areaId,
      'location': area + ',' + city,
      'sqft': '$_value',
      'price': '' + sellingPriceCtrl.text.toString(),
      'commission': '' + commPiceCntrl.text.toString(),
      'possession': '' + dataPosse[isSelected_pose].title,
      'age': '' + dataAges[isSelected_propAge].title,
      'facing': '' + dataFacings[isSelected_faceing].title,
      'furnishing': '' + dataFurnished[isSelected_furnished].title,
      'package': '' + dataPackages[isSelected_packages].title,
      'parking': '' + dataParking[isSelected_parking],
      'bhk': '' + dataBhk[isSelected_bhk],
      'description': '' + desCntrl.text.toString(),
    };

    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/inventory_sale.php', queryParameters);
    print(uri);
     Response response = await get(uri);

    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('sendInventDetails->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      if (map['status'] == 'Success') {

        setInvetImages(map['sale_id']);
      } else {
        print('sendInventDetails:status' + map['status']);
      }
      // status
      // setInvetImages();

      //countInt
    } else {
      await pr.hide();
      print('sendInventDetails->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> setInvetImages_() async {
    // ProgressDialog pr = ProgressDialog(context);
    // pr = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    // pr.style(
    //   message: 'Please wait',
    //   progressWidget: Platform.isIOS
    //       ? CupertinoActivityIndicator()
    //       : Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: CircularProgressIndicator(),
    //         ),
    // );
    // await pr.show();
    final bytes = File(_image.path).readAsBytesSync();

    var queryParameters = {
      'inventory_id': '866',
      'file1': '' + base64.encode(bytes).toString(),
      'ext': ext.toString(),
    };

    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/inventory_images1.php', queryParameters);
    print(uri);
    Response response = await post(uri);
    // final response = await http
    //     .get("https://" + GlobalVariable.BASE_URL + "/api/inventory_sale.php");
    if (response.statusCode == 200) {
      // await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('setInvetImages->' + data.toString());

      //countInt
    } else {
      // await pr.hide();
      print('setInvetImages->error');
      print(response.statusCode.toString());
      // print(data.toString());
      throw Exception('ErrorImageUpload');
    }
  }

  Future<void> setInvetImages(String id) async {
    // ProgressDialog pr = ProgressDialog(context);
    // pr = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    // pr.style(
    //   message: 'Please wait',
    //   progressWidget: Platform.isIOS
    //       ? CupertinoActivityIndicator()
    //       : Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: CircularProgressIndicator(),
    //         ),
    // );
    // await pr.show();
    final bytes = File(_image.path).readAsBytesSync();
    print('BYTES==' + bytes.length.toString());
    var queryParameters = {
      'inventory_id': id,
      'file1': '' + base64Encode(bytes),
      'ext': ext.toString(),
    };

    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/inventory_images1.php', queryParameters);
    print(uri);
    Response response = await post(uri);
    /*final response = await http
        .post(
            "https://" + GlobalVariable.BASE_URL + "/api/inventory_images1.php",
            headers: queryParameters)
        .then((result) {
          print(result.statusCode);
          print(result.body);
    })
        .catchError((error) {
      print('InvetimageUplad' + error.toString());
    });*/

    // final s = await http.MultipartRequest('POST',uri);
    // var res  = await s.send();
    // print('MultipartRequest');
    // print(res.statusCode);
    // final response = await http
    //     .post(
    //         "https://" + GlobalVariable.BASE_URL + "/api/inventory_images1.php",
    //         headers: queryParameters)
    //     .then((result) {
    //   print(result.statusCode);
    //   print(result.body);
    // }).catchError((error) {
    //   print('InvetimageUplad' + error.toString());
    // });

    if (response.statusCode == 200) {
      // await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('setInvetImages->' + data.toString());

      //countInt
    } else {
      // await pr.hide();
      print('setInvetImages->error');
      print(response.statusCode.toString());
      // print(data.toString());
      throw Exception('ErrorImageUpload');
    }
  }

  Future getImage(String id) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        // maxWidth: 500,
        imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('image' + _image.path);
        var str = _image.path.toString().split('.');
        print('extension = ' + str[3].toString());
        setState(() {
          imagePopup = true;
          ext = str[3].toString();
          usrImgs.add(_image);
          usrImgsPath.add(ext);
        });
        // print(_image.path.split('.'));

        setInvetImages(id);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      if (imagePopup == true) {
        print("imagePopup==true");
        imagePopup = false;
      } else {
        print("imagePopup==false");
        super.dispose();
      }
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


//delete 895 id lisiting in database
//parking 0 and 1
//bhk 1 to 4
//flutter: https://firstmangroup.in/api/inventory_sale.php?member_id=4&title=Test+Ios&category=2&city=1&area=2&location=Benz+Circle%2CVijayawada&sqft=269.0&price=300000&commission=10000&possession=Ready+to+Move&age=Less+than+1+Year&facing=East&furnishing=Semi+Furnished&package=GOLD+%2845DAYS%29&parking=Yes&bhk=3BHK&description=Testing+Ios+
// flutter: sendInventDetails->{status: Success, sale_id: 872, message: Upload Images}//
//<key>NSPhotoLibraryUsageDescription</key>
// 	<key>NSCameraUsageDescription</key>
// 	<key>NSMicrophoneUsageDescription</key>
