import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firstmangroup_flutter/AddListingScreen.dart';
import 'package:firstmangroup_flutter/BannersScreen.dart';
import 'package:firstmangroup_flutter/CitySelectScreen.dart';
import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:firstmangroup_flutter/FilterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'DataCategory.dart';
import 'DataPropGallery.dart';
import 'customcolor.dart';

void main() {
  runApp(PropertyGalleryScreen());
}

class PropertyGalleryScreen extends StatefulWidget {
  @override
  _PropertyGalleryScreenState createState() => _PropertyGalleryScreenState();
}

final List<DataCategory> dataCategory = new List<DataCategory>();
final List<DataPropGallery> dataPropGallery = new List<DataPropGallery>();
int isSelected = 0;
bool popupFilter = false;
String category = '', page = '0', sorting = '', city = '';
int sortBy = -1;

class _PropertyGalleryScreenState extends State<PropertyGalleryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getData(context);
    getData_pg_one('All');
    // WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // WidgetsBinding.instance.removeObserver(this);

    super.dispose();
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
                          'Property Gallery',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.asset(
                          'drawable/app_new_icon.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Container(
                  color: GlobalVariable.white,
                  margin: EdgeInsets.only(left: 10),
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          dataCategory.length == 0 ? 0 : dataCategory.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, pos) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = pos;
                            });
                            getData_pg_one(dataCategory[pos].title);
                          },
                          child: Container(
                            // margin: EdgeInsets.only(right: 15),
                            // width: 70,
                            child: Stack(
                              children: [
                                Center(
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    color:
                                        isSelected != null && isSelected == pos
                                            ? GlobalVariable.blue_main
                                            : Colors.transparent,
                                    // child: Text('sdf'),
                                    child: Text(
                                      dataCategory.length != null
                                          ? dataCategory[pos].title.toString()
                                          : 'sdfadsads',
                                      // 'asdfdsfds',

                                      // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily:
                                              GlobalVariable.GothamMedium,
                                          color: isSelected != null &&
                                                  isSelected == pos
                                              ? GlobalVariable.white
                                              : GlobalVariable.blue_main,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible: false,
                                    // visible: isSelected != null && isSelected == pos
                                    //     ? true
                                    //     : false,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 1,
                                      width: 75,
                                      color: GlobalVariable.yellow_main,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Expanded(
                  child: AnimatedContainer(
                    padding: EdgeInsets.only(top: 10),
                    color: GlobalVariable.grey_main,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.fastOutSlowIn,
                    child: dataPropGallery.length == 0
                        ? Center(
                            child: Text(
                              'No Properties',
                              style: TextStyle(
                                  fontFamily: GlobalVariable.Gotham,
                                  color: GlobalVariable.blue_main,
                                  fontSize: 16),
                            ),
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
                                                    dataPropGallery.length == 0
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
                                                  dataPropGallery.length != null
                                                      ? dataPropGallery[pos]
                                                          .title
                                                          .toString()
                                                      : 'title',
                                                  // 'asdfdsfds',

                                                  // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: GlobalVariable
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
                                                          left: 10, right: 10),
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
                                                          GlobalVariable.Gotham,
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
                                                          left: 10, right: 10),
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
                )

                // ListView.builder(itemBuilder: (context, pos) {
                //   return Container();
                // })
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        // print('from:1');
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  CitySelectScreen(from: '1')),
                        ).then((value) {
                          print('returned from navigator' + value.toString());
                          setState(() {
                            dataPropGallery.clear();
                            getData_pg_one('All');
                          });
                          // getData_pg_one(context, 'All');
                        });
                      },
                      child: Image.asset(
                        'drawable/flagcircle.png',
                        height: 45,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        // print('from:1');
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => FilterScreen(type: '0',)),
                        );
                      },
                      child: Image.asset(
                        'drawable/filterfill.png',
                        height: 45,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          popupFilter = true;
                        });
                      },
                      child: Image.asset(
                        'drawable/circlearrows.png',
                        height: 45,
                      )),
                ],
              ),
            ),

            //popup
            Visibility(
              visible: popupFilter,
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                width: double.infinity,
                height: double.infinity,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: double.infinity,
                      color: GlobalVariable.white,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 10, top: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    sortBy = 0;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'A - Z',
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.Gotham,
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        sortBy == 0
                                            ? 'drawable/radio_on.png'
                                            : 'drawable/radio_off.png',
                                        height: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 10, top: 10, bottom: 15),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    sortBy = 1;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Z - A',
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.Gotham,
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        sortBy == 1
                                            ? 'drawable/radio_on.png'
                                            : 'drawable/radio_off.png',
                                        height: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Price',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 10, top: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    sortBy = 2;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Low to High',
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.Gotham,
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        sortBy == 2
                                            ? 'drawable/radio_on.png'
                                            : 'drawable/radio_off.png',
                                        height: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 10, top: 10, bottom: 30),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    sortBy = 3;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'High to Low',
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily: GlobalVariable.Gotham,
                                          fontSize: 14),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        sortBy == 3
                                            ? 'drawable/radio_on.png'
                                            : 'drawable/radio_off.png',
                                        height: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      popupFilter = false;
                                    });
                                  },
                                  child: Text(
                                    '   Cancel   ',
                                    style: TextStyle(
                                        color: GlobalVariable.yellow_main,
                                        fontFamily: GlobalVariable.Gotham,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (sortBy == 0) {
                                        sorting = 'TASC';
                                      } else if (sortBy == 1) {
                                        sorting = 'TDESC';

                                      } else if (sortBy == 2) {
                                        sorting = 'PASC';

                                      } else if (sortBy == 3) {
                                        sorting = 'PDESC';
                                      }
                                      popupFilter = false;
                                    });
                                    getData_pg_one('All');
                                  },
                                  child: Text(
                                    '   OK   ',
                                    style: TextStyle(
                                        color: GlobalVariable.yellow_main,
                                        fontFamily: GlobalVariable.Gotham,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getData(BuildContext context) async {
    dataCategory.clear();
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
//https://firstmangroup.in/api/category.php
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/category.php");

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      // for(Map i in )
      print(data.toString());

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCategory.add(DataCategory.fromJson(i));
        }
        var jj = {'id': '-1', 'title': 'All'};
        var jjk = {'id': '0', 'title': 'Trending'};
        var jjkk = {'id': '0', 'title': 'Luxury'};
        var jjkl = {'id': '0', 'title': 'Budget'};
        dataCategory.insert(0, DataCategory.fromJson(jjkl));
        dataCategory.insert(0, DataCategory.fromJson(jjkk));
        dataCategory.insert(0, DataCategory.fromJson(jjk));
        dataCategory.insert(0, DataCategory.fromJson(jj));
        print('' + dataCategory.length.toString());
        // dataCategory.add(DataCategory());
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getTrackLeadsData->error');

      throw Exception('Failed to load album');
    }
  }

  //https://firstmangroup.in/api/properties.php?category=&page=0&sorting=&city=1
  Future<void> getData_pg_one(String s) async {
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
    // await pr.show();

    var queryPrams = {
      'category': category,
      // 'fil_type': category,
      'page': page,
      'sorting': sorting,
      'city': prefs.getString('cityId'),
    };
    var queryParams_ = {
      // 'category': category,
      'fil_type': s,
      'page': page,
      'sorting': sorting,
      'city': prefs.getString('cityId'),
    };
    /*   print( '/api/properties.php');
        print(s=='All'?queryPrams:queryParams_);

    final response = await http.get(
        'https://' + GlobalVariable.BASE_URL + '/api/properties.php',
        headers: s=='All'?queryPrams:queryParams_);*/

    var uri = Uri.https(GlobalVariable.BASE_URL, '/api/properties.php',
        s == 'All' ? queryPrams : queryParams_);
    print(uri);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      // await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      // for(Map i in )
      // print(data.toString());

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPropGallery.add(DataPropGallery.fromJson(i));
        }
        // print('' + dataCategory.length.toString());
        // dataCategory.add(DataCategory());
      });
    } else {
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('data->error');

      throw Exception('Failed to load album');
    }
  }

//https://firstmangroup.in/api/properties.php?fil_type=trending&page=0&sorting=&city=1
// https://firstmangroup.in/api/category.php
//  https://firstmangroup.in/api/properties.php?category=&page=0&sorting=&city=1
//  https://firstmangroup.in/api/properties.php?fil_type=trending&page=0&sorting=&city=1
}
