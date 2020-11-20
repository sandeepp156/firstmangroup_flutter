import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataMemberDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(InviteFMScreen());
}

class InviteFMScreen extends StatefulWidget {
  @override
  _InviteFMScreenState createState() => _InviteFMScreenState();
}
final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

class _InviteFMScreenState extends State<InviteFMScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getMemberData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.white,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
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
                          // color: GlobalVariable.white,
                          height: 30,
                          width: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 10),
                      child: Text(
                        'Invite FM',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                  elevation: 5,
                  child: Image.asset(
                    'drawable/invitebanner.png',
                    height: 175,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                height: 5,
              ),
              Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your Referral Code is',
                            style: TextStyle(
                                fontSize: 18,
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'FM181002004',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.Gotham),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                elevation: 5,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 14,
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  // FlutterOpenWhatsapp.sendSingleMessage('', );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: GlobalVariable.blue_main,
                  child: Center(
                    child: Text(
                      'INVITE',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  getMemberData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.get('memberJson');
    // String decodedString = jsonDecode(json);
    setState(() {
      for (Map i in jsonDecode(json)) {
        dataMemDe.add(DataMemberDetails.fromJson(i));
      }
    });
    print(json);
  }
}
