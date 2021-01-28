import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/EnterDetailsScreen.dart';
import 'package:firstmangroup_flutter/OTPVScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CitySelectScreen.dart';

void main() {
  runApp(ReferralCodeScreen());
}

class ReferralCodeScreen extends StatefulWidget {
  @override
  _ReferralCodeScreenState createState() => _ReferralCodeScreenState();
}

TextEditingController phCntrl = new TextEditingController();

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
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
                      left: 10, right: 10, top: 20, bottom: 20),
                  child: Text(
                    "Enter Referral Code",
                    style: TextStyle(
                        fontFamily: GlobalVariable.Gotham,
                        color: GlobalVariable.text_colors_black,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: phCntrl,
                          // maxLength: 10,
                          // keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              color: GlobalVariable.blue_main,
                              fontSize: 20),
                          decoration: InputDecoration(
                              counterText: "",
                              contentPadding:
                                  EdgeInsets.only(bottom: -15, top: 0.0),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                color: GlobalVariable.blue_main,
                              )),
                              // border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontFamily: GlobalVariable.Gotham,
                                  color: GlobalVariable.grey_main_,
                                  fontSize: 18),
                              hintText: 'Enter Referral Code'),
                        ),
                      ),
                      // Expanded(child: Text("")),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: GlobalVariable.blue_main,
                      borderRadius: BorderRadius.circular(35)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        checkRefCode(context);
                        /* Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(builder: (context) => EnterDetailsScreen()),
                          );*/
                      },
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  fontFamily: GlobalVariable.GothamMedium,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ],
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

  checkRefCode(BuildContext context) {
    if (phCntrl.text.toString() == "") {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: Text('Enter Referral Code')));
    } else {
      sendRefCode(context);
      /*  Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => EnterDetailsScreen()),
      );*/
    }
  }

  Future<void> sendRefCode(BuildContext context) async {
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
      'code': '' + phCntrl.text.toString(),
    };
    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/member_reference.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String json = response.body;
    print('' + json.toString());
    Map<String, dynamic> map = jsonDecode(json);
    if (statusCode == 200) {
      await pr.hide();
      if (map['status'] == 'Success') {

        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => CitySelectScreen(from:'0')),
        );
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
        // showMyDialog(context, map['message']);
      }
    }
  }
}
