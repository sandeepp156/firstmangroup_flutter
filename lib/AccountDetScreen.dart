import 'dart:convert';

import 'package:firstmangroup_flutter/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataMemberDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(AccountDetScreen());
}

class AccountDetScreen extends StatefulWidget {
  @override
  _AccountDetScreenState createState() => _AccountDetScreenState();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

class _AccountDetScreenState extends State<AccountDetScreen> {
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
        child: Column(
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
                      'Profile',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 10),
                    child: Text(
                      dataMemDe.length != 0 ? dataMemDe[0].code : '000',
                      style: TextStyle(
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Image.asset('drawable/userbg.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(65),
                                    child: Hero(
                                      tag: 'usrImg',
                                      child: Image.network(
                                        dataMemDe.length != 0
                                            ? dataMemDe[0].image
                                            : '',
                                        fit: BoxFit.cover,
                                        height: 125,
                                        width: 125,
                                      ),
                                    )),
                                InkWell(
                                  onTap: () {
                                    //   RaisedButton(
                                    //               child: Text('Page2'),
                                    //               onPressed: () => Navigator.push(
                                    //                   context,
                                    //                   PageRouteBuilder(
                                    //                       transitionDuration: Duration(seconds: 2),
                                    //                       pageBuilder: (_, __, ___) => Page2())),

                                    //             ),
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration: Duration(seconds: 1),
                                            pageBuilder: (_, __, ___) =>
                                                EditProfileScreen(
                                                  dataMemberDetails:
                                                      dataMemDe[0],
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 100, top: 80),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[600],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    height: 35,
                                    width: 35,
                                    child: Center(
                                      child: Image.asset(
                                        'drawable/edit_blue.png',
                                        color: GlobalVariable.white,
                                        // fit: BoxFit.cover,
                                        height: 20, width: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                dataMemDe.length != 0
                                    ? dataMemDe[0].fname
                                    : 'Name',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium,
                                    fontSize: 22),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 10, top: 20),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'drawable/phone.png',
                                        height: 23,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          dataMemDe.length != 0
                                              ? dataMemDe[0].phone
                                              : 'phone',
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'drawable/email.png',
                                        height: 23,
                                        width: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          dataMemDe.length != 0
                                              ? dataMemDe[0].email
                                              : 'email',
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'drawable/location.png',
                                        height: 23,
                                        width: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          dataMemDe.length != 0
                                              ? dataMemDe[0].address
                                              : 'phone',
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'drawable/realestateagent.png',
                                        height: 25,
                                        width: 20,
                                        color: GlobalVariable.blue_main,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          dataMemDe.length != 0
                                              ? dataMemDe[0].profession
                                              : 'profession',
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Your Bank Details : ',
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontFamily:
                                              GlobalVariable.GothamMedium,
                                          // decoration: TextDecoration.underline,

                                          fontSize: 16),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 1,
                                        width: 150,
                                        color: GlobalVariable.yellow_main,
                                      )),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35, top: 10),
                                      child: Text(
                                        dataMemDe.length != 0
                                            ? dataMemDe[0].bank.length == 0
                                                ? 'Not Submited'
                                                : ''
                                            : 'Sumbited',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            // decoration: TextDecoration.underline,

                                            fontSize: 14),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
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
    // print(json);
    setState(() {});
  }
}
