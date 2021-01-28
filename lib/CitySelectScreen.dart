import 'dart:convert';

import 'package:firstmangroup_flutter/DataCities.dart';
import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:firstmangroup_flutter/PropertyGalleryScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'customcolor.dart';

void main() {
  runApp(CitySelectScreen());
}

class CitySelectScreen extends StatefulWidget {
  final String from;

  CitySelectScreen({this.from});

  @override
  _CitySelectScreenState createState() => _CitySelectScreenState();
}

final List<DataCities> dataCities = new List<DataCities>();

int isSelected = -1;
var cityID = '';

class _CitySelectScreenState extends State<CitySelectScreen> {
  final String from;

  _CitySelectScreenState({this.from});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCitiesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.white,
          child: Column(
            children: [
              appBar(),
              Container(
                  color: GlobalVariable.grey_main,
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: Row(
                    children: [
                      Text(
                        '   Popular Cities',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontSize: 13,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GridView.builder(
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: dataCities.length == 0 ? 0 : dataCities.length,
                      itemBuilder: (BuildContext context, int pos) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = pos;
                              cityID = dataCities[pos].id;
                              print('CITYIDSELECTED:' + cityID);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            height: 100,
                            width: 150,
                            // color: GlobalVariable.yellow_main,
                            child: Container(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(dataCities
                                                              .length ==
                                                          0
                                                      ? 'https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg'
                                                      : dataCities[pos]
                                                          .image))),
                                          // color: GlobalVariable.yellow_main,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Text(
                                          dataCities.length == 0
                                              ? ''
                                              : dataCities[pos].title,
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontSize: 12,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 5),
                                      child: Image.asset(
                                        isSelected != null && isSelected == pos
                                            ? 'drawable/select_city_fill.png'
                                            : 'drawable/select_city.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                      //isSelected != null && isSelected == index //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.
                                      //                              ? Colors.white
                                      //                              : Colors.orange,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: saveBtn(),
              ),
            ],
          ),
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
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: GlobalVariable.blue_main,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 7),
                child: Image.asset(
                  'drawable/back_black.png',
                  height: 30,
                  width: 25,
                ),
              ),
            ),
          ),
          Text(
            'Select City',
            style: TextStyle(
                color: GlobalVariable.blue_main,
                fontSize: 16,
                fontFamily: GlobalVariable.GothamMedium),
          ),
        ],
      ),
    );
  }

  Widget saveBtn() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: GlobalVariable.white,
        onTap: () {
          saveCity();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          decoration: BoxDecoration(
            color: GlobalVariable.blue_main,
            // borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: GlobalVariable.GothamMedium,
                color: GlobalVariable.yellow_main,
                fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<void> getCitiesData() async {
    dataCities.clear();
    final response = await http.get(
        "https://" + GlobalVariable.BASE_URL + "/api/cities.php",
        headers: {
          "Access-Control-Allow-Origin": "*",
          // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true",
          "Accept": "application/json",
          // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        });

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCities.add(DataCities.fromJson(i));
        }
      });
      //call ads.php
      //PropGallery,propFilter,NewProp<--
      //

      print('getCities->' + data.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getHome->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> getCitiesData__() async {
    final res = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/cities.php");

    if (res.statusCode == 200) {
      var v = json.decode(res.body);
      print(v.toString());
      setState(() {
        // imageUrl = v['message'];
      });
    }
  }

  Future<void> saveCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("cityId", "" + cityID);
      prefs.setString("cityName", "" + dataCities[isSelected].title);
    });

    if (widget.from == '1') {
      Navigator.pop(context,'hai');
      /*Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (context) => PropertyGalleryScreen(),
          ));*/
    } else {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }

    //  int isSelected  = -1;
  }
}
