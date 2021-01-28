import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/CitySelectScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:firstmangroup_flutter/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EnterDetailsScreen.dart';
import 'ReferralCodeScreen.dart';

void main() {
  runApp(OTPVScreen());
}

class OTPVScreen extends StatefulWidget {
  final String text, otp;

  OTPVScreen({this.text, this.otp});

  @override
  _OTPVScreenState createState() => _OTPVScreenState();
}

TextEditingController oneCntrl = new TextEditingController(),
    twoCntrl = new TextEditingController(),
    threeCntrl = new TextEditingController(),
    fourCntrl = new TextEditingController(),
    fiveCntrl = new TextEditingController(),
    sixCntrl = new TextEditingController();

class _OTPVScreenState extends State<OTPVScreen> {
  final String text, otp;

  _OTPVScreenState({this.text, this.otp});

  @override
  void dispose() {
    // TODO: implement dispose
    oneCntrl.clear();
    twoCntrl.clear();
    threeCntrl.clear();
    fourCntrl.clear();
    fiveCntrl.clear();
    sixCntrl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  height: 45,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RotatedBox(
                            quarterTurns: 90,
                            child: Image.asset(
                              'assets/right.png',
                              color: GlobalVariable.grey_main_,
                              scale: 3.5,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text("Enter the OTP sent to\n",
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.text_colors_black,
                                fontSize: 13)),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(widget.text.toString(),
                              style: TextStyle(
                                  fontFamily: GlobalVariable.Gotham,
                                  color: GlobalVariable.blue_main,
                                  fontSize: 13)))
                    ],
                  ),
                ),
                Hero(
                  tag: 'bnner1',
                  child: Image.asset(
                    "assets/bnner1.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 20,
                  ),
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(
                        fontFamily: GlobalVariable.Gotham,
                        color: GlobalVariable.text_colors_black,
                        fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // optTextFiled(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: oneCntrl,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        maxLength: 1,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main,
                                fontSize: 14),
                            hintText: '*'),
                      ),
                    ),
                    // optTextFiled1(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: twoCntrl,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        maxLength: 1,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: GlobalVariable.blue_main, fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: GlobalVariable.grey_main, fontSize: 14),
                            hintText: '*'),
                      ),
                    ),
                    // optTextFiled2(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: threeCntrl,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        maxLength: 1,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: GlobalVariable.blue_main, fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: GlobalVariable.grey_main, fontSize: 14),
                            hintText: '*'),
                      ),
                    ),
                    // optTextFiled3(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: fourCntrl,
                        maxLength: 1,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: GlobalVariable.blue_main, fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: GlobalVariable.grey_main, fontSize: 14),
                            hintText: '*'),
                      ),
                    ),
                    // optTextFiled4(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: fiveCntrl,
                        maxLength: 1,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: GlobalVariable.blue_main, fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: GlobalVariable.grey_main, fontSize: 14),
                            hintText: '*'),
                      ),
                    ),
                    // optTextFiled5(),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 27,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: sixCntrl,
                        maxLength: 1,
                        onChanged: (_) {
                          node.nextFocus();
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: GlobalVariable.blue_main, fontSize: 14),
                        decoration: InputDecoration(
                            counterText: "",
                            contentPadding:
                                EdgeInsets.only(bottom: -25, top: 0.0),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                              color: GlobalVariable.blue_main,
                            )),
                            // border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: GlobalVariable.grey_main, fontSize: 14),
                            hintText: '*'),
                      ),
                    )
                    // Expanded(child: Text("")),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 7),
                  child: Text(
                    'Didn\'t get the OTP ?',
                    style: TextStyle(fontFamily: GlobalVariable.Gotham),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>  Registration()),);                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend OTP',
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: Colors.pinkAccent),
                      ),
                      Image.asset(
                        "assets/rightarrow.png",
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
                Spacer(),
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
                        checkOtp(context);
                        /*  Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(builder: (context) => ReferralCodeScreen()),
                        );*/
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
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget optTextFiled() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: oneCntrl,
        onChanged: (_) {},
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            fontFamily: GlobalVariable.Gotham,
            color: GlobalVariable.blue_main,
            fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                fontFamily: GlobalVariable.Gotham,
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Widget optTextFiled1() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: twoCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(color: GlobalVariable.grey_main, fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Widget optTextFiled2() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: threeCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(color: GlobalVariable.grey_main, fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Widget optTextFiled3() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: fourCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(color: GlobalVariable.grey_main, fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Widget optTextFiled4() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: fiveCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(color: GlobalVariable.grey_main, fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Widget optTextFiled5() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: sixCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
              color: GlobalVariable.blue_main,
            )),
            // border: InputBorder.none,
            hintStyle: TextStyle(color: GlobalVariable.grey_main, fontSize: 14),
            hintText: '*'),
      ),
    );
  }

  Future<void> callMember(BuildContext context) async {
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
      'phone': '' + widget.text,
    };
    var uri =
        Uri.https(GlobalVariable.BASE_URL, '/api/member.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String json = response.body;
    print('' + json.toString());
    Map<String, dynamic> map = jsonDecode(json);
    if (statusCode == 200) {
      await pr.hide();
      if (map['status'] == 'Success') {
        if (map['type'] == 'Existing') {
          setState(() {
            prefs.setString('member_id', map['member_id'].toString());
          });
          getDetails(context);

        } else {
          //ReferralCodeScreen
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => EnterDetailsScreen()),
          );

          //code
        }
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
        // showMyDialog(context, map['message']);
      }
    }
  }
  Future<void> getDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/members.php?member_id=" +
        prefs.getString('member_id'))
        ;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getDetails->' + data.toString());
      setState(() {
        prefs.setString('memberJson', json);
      });
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => CitySelectScreen(from:'0')),
      );
    } else {
      print('getDetails->error');
      throw Exception('Failed to load album');
    }
  }

  void checkOtp(BuildContext context) {
    String otp_code = oneCntrl.text.toString() +
        twoCntrl.text.toString() +
        threeCntrl.text.toString() +
        fourCntrl.text.toString() +
        fiveCntrl.text.toString() +
        sixCntrl.text.toString();
    if (widget.otp == otp_code) {
      callMember(context);
    } else {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: Text('OTP did not matched')));
    }
  }

}
//call member.php
//// 20201230151021
// // https://firstmangroup.in/api/member.php?phone=8106519615
//
// {
//   "status": "Success",
//   "member_id": "4991",
//   "name": "Sandeep",
//   "type": "Existing",
//   "cur_status": "Active",
//   "code": "FM201009015",
//   "message": "Created Successfully"
// }
