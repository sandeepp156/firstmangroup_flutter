import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firstmangroup_flutter/DataEvents.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CitySelectScreen.dart';
import 'DataCities.dart';
import 'ReferralCodeScreen.dart';

void main() {
  runApp(EnterDetailsScreen());
}

class EnterDetailsScreen extends StatefulWidget {
  @override
  _EnterDetailsScreenState createState() => _EnterDetailsScreenState();
}

bool oneStar = true, twoStar = true, threeStar = true, fourStar = true;
bool advisor = false,
    builder = false,
    dev = false,
    emp = false,
    freel = false,
    othres = false,
    terms = false,
    popup = false;
bool popup_usrType = false;
final List<DataCities> dataCities = new List<DataCities>();
final List<DataUserType> dataUserType = new List<DataUserType>();

TextEditingController fname_ctrl = new TextEditingController();
TextEditingController lname_ctrl = new TextEditingController();

String city = ' Select City',
    cityID = '',
    usrtype = ' Select User type',
    usr_id = '';

class _EnterDetailsScreenState extends State<EnterDetailsScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    getCitiesData();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    // _controller = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    // animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fname_ctrl.clear();
    lname_ctrl.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.light_blue,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset(
                  'drawable/personal_page.png',
                  // height: MediaQuery.of(context).size.height/2.75,
                ),
                enterdetials(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                  color: Colors.transparent,
                  child: Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        splashColor: GlobalVariable.white,
                        onTap: () {
                          if(terms){
                            sendDetails(context);
                          }
                          else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                Text('Please accept Terms & Conditions')));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          decoration: BoxDecoration(
                            color: GlobalVariable.blue_main,
                            // borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "SUBMIT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: GlobalVariable.GothamMedium,
                                color: GlobalVariable.yellow_main,
                                fontSize: 16),
                          ),
                        ),
                      );
                    },
                  )),
            ),
            // cityPopup(),
            Visibility(
              visible: popup == true ? true : false,
              child: AnimatedOpacity(
                  opacity: popup == true ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: cityPopup()),
            ),
            Visibility(
              visible: popup_usrType == true ? true : false,
              child: AnimatedOpacity(
                  opacity: popup_usrType == true ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: usrtypePopup()),
            ),
            // SlideTransition(position: _animation, child: cityPopup())
          ],
        ),
      ),
    );
  }

  Widget enterdetials() {
    return Container(
      color: GlobalVariable.light_blue,
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          firstname(),
          lastname(),
          selectcity(),
          selectusertype(),
          // gridview(),
          accept(),
        ],
      ),
    );
  }

  Widget accept() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                terms = terms ? false : true;
              });
            },
            child: Image.asset(
              terms
                  ? 'drawable/terms_checked.png'
                  : 'drawable/checkoff1.png', //checkoff1
              height: 20, width: 15,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'By logging in I agree to First Man Group ',
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamLight,
                          fontSize: 10)),
                  TextSpan(
                      text: 'Terms of service.',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: '\nPrivacy Policy',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        // decoration: TextDecoration.underline,
                        // decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: 'Content Policies',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                ]),
              )
              // Text(
              //   'By logging in I agree to First Man Group Terms of service.\nPrivacy Policy and Content Policies',
              //   style: TextStyle(color: GlobalVariable.white,fontSize: 10),
              // ),
              ),
        ],
      ),
    );
  }

  Widget firstname() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Visibility(
            visible: oneStar,
            child: Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextField(
            onChanged: (c) {
              if (c.length == null || c.length == 0) {
                setState(() {
                  oneStar = true;
                });
              } else {
                setState(() {
                  oneStar = false;
                });
              }
            },
            controller: fname_ctrl,
            style: TextStyle(color: GlobalVariable.white),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                hintText: '  First name',
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                disabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                hintStyle: TextStyle(
                    color: GlobalVariable.white,
                    fontFamily: GlobalVariable.Gotham,
                    fontSize: 15)),
          )
        ],
      ),
    );
  }

  Widget lastname() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Visibility(
            visible: twoStar,
            child: Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextField(
            onChanged: (c) {
              if (c.length == null || c.length == 0) {
                setState(() {
                  twoStar = true;
                });
              } else {
                setState(() {
                  twoStar = false;
                });
              }
            },
            controller: lname_ctrl,
            style: TextStyle(color: GlobalVariable.white),

            // cursorColor: GlobalVariable.white,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                hintText: '  Last name',
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                disabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                hintStyle: TextStyle(
                    color: GlobalVariable.white,
                    fontSize: 15,
                    fontFamily: GlobalVariable.Gotham)),
          )
        ],
      ),
    );
  }

  Widget selectcity() {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          setState(() {
            popup = popup == true ? false : true;

            // _controller.forward();
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: 30,
          width: double.infinity,
          child: Stack(
            children: [
              Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
              TextField(
                onChanged: (c) {
                  if (city == ' Select City') {
                    setState(() {
                      threeStar = true;
                    });
                  } else {
                    setState(() {
                      threeStar = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                    hintText: city,
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.text_colors_black,
                    )),
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.white,
                    )),
                    disabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.text_colors_black,
                    )),
                    hintStyle: TextStyle(
                        color: GlobalVariable.white,
                        fontSize: 15,
                        fontFamily: GlobalVariable.Gotham)),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'drawable/down_arr.png',
                    height: 7,
                    width: 15,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectusertype() {
    return GestureDetector(
      onTap: () {
        getUsrTypeData();
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 30,
        width: double.infinity,
        child: Stack(
          children: [
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
            TextField(
              onChanged: (c) {
                if (usrtype == ' Select User type') {
                  setState(() {
                    fourStar = true;
                  });
                } else {
                  setState(() {
                    fourStar = false;
                  });
                }
              },
              decoration: InputDecoration(
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                  hintText: usrtype,
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                    color: GlobalVariable.text_colors_black,
                  )),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                    color: GlobalVariable.text_colors_black,
                  )),
                  disabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                    color: GlobalVariable.text_colors_black,
                  )),
                  hintStyle: TextStyle(
                      color: GlobalVariable.white,
                      fontSize: 15,
                      fontFamily: GlobalVariable.Gotham)),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'drawable/down_arr.png',
                  height: 7,
                  width: 15,
                )),
          ],
        ),
      ),
    );
  }

  Widget gridview() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png', ////terms_checked//checkoff1
                      height: 20, width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Advisor',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Builder',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Developer',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Employee',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'FreeLancer',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Others',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cityPopup() {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            margin: EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text('Select City'),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataCities.length == 0 ? 0 : dataCities.length,
                    itemBuilder: (BuildContext context, int pos) {
                      return Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  // print('clicked');
                                  popup = popup == true ? false : true;
                                  city = dataCities[pos].title;
                                  cityID = dataCities[pos].id;

                                  // _controller.reverse();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  dataCities[pos].title,
                                ),
                              )));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usrtypePopup() {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            margin: EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text('Select User Type'),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        dataUserType.length == 0 ? 0 : dataUserType.length,
                    itemBuilder: (BuildContext context, int pos) {
                      return Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  // print('clicked');
                                  popup_usrType =
                                      popup_usrType == true ? false : true;
                                  usrtype = dataUserType[pos].title;
                                  usr_id = dataUserType[pos].id;

                                  // _controller.reverse();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  dataUserType[pos].title,
                                ),
                              )));
                    },
                  ),
                ),
              ],
            ),
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

  Future<void> getUsrTypeData() async {
    setState(() {
      popup_usrType = popup_usrType == true ? false : true;
    });
    dataUserType.clear();
    final response = await http.get(
        "https://" + GlobalVariable.BASE_URL + "/api/members_types.php",
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
          dataUserType.add(DataUserType.fromJson(i));
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

  Future<void> sendDetails(BuildContext context) async {
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
      'member_id': '' + prefs.getString('member_id'),
      'fname': '' + fname_ctrl.text.toString(),
      'lname': '' + lname_ctrl.text.toString(),
      'city': '' + cityID,
      'type': '' + usr_id,
    };
    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/member-profile.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String json = response.body;
    print('' + json.toString());
    Map<String, dynamic> map = jsonDecode(json);
    if (statusCode == 200) {
      await pr.hide();
      if (map['status'] == 'Success') {
        if(usr_id=='3'){
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                builder: (context) => CitySelectScreen(from:'0'),
              ));
        }
        else{
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                builder: (context) => ReferralCodeScreen(),
              ));
        }

          // sendDetails(context);
      /*  Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => CitySelectScreen()),
        );*/
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
        // showMyDialog(context, map['message']);
      }
    }
  }
}

class DataUserType {
  String id;
  String title;

  DataUserType({this.id, this.title});

  factory DataUserType.fromJson(Map<String, dynamic> json) {
    return DataUserType(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
//cities dynamic,usertype dynamic
//send member-profile.php
