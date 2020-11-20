import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataMemberDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(PayoutsScreen());
}

class PayoutsScreen extends StatefulWidget {
  @override
  _PayoutsScreenState createState() => _PayoutsScreenState();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

class _PayoutsScreenState extends State<PayoutsScreen> {
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
                      'Payouts management',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        dataMemDe.length != 0 ? dataMemDe[0].image : '',
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                dataMemDe.length != 0
                    ? dataMemDe[0].fname + ' ' + dataMemDe[0].lname
                    : '',
                style: TextStyle(
                    color: GlobalVariable.blue_main,
                    fontFamily: GlobalVariable.GothamMedium,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 15),
              child: Text(
                dataMemDe.length != 0 ? dataMemDe[0].code : '',
                style: TextStyle(
                    color: GlobalVariable.yellow_main,
                    fontFamily: GlobalVariable.GothamMedium,
                    fontSize: 16),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 50, right: 50, top: 35, bottom: 35),
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        borderRadius: BorderRadius.circular(125)),
                    child: Column(
                      children: [
                        Image.asset(
                          'drawable/pig.png',
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '1.24 Lac',
                            // dataMemDe.length != 0 ? dataMemDe[0].code : '',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 16),
                          ),
                        ),
                        Text(
                          'Total Payouts',
                          // dataMemDe.length != 0 ? dataMemDe[0].code : '',
                          style: TextStyle(
                              color: GlobalVariable.white,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 37),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: GlobalVariable.white,
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: GlobalVariable
                                              .text_colors_black)),
                                  child: Image.asset(
                                    'drawable/user_circle.png',
                                    height: 30,
                                  )),
                              Text(
                                'Account\nDetails',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 37),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: GlobalVariable.white,
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: GlobalVariable
                                              .text_colors_black)),
                                  child: Image.asset(
                                    'drawable/insurancecom.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              Text(
                                'Insurance\nPayouts',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 37),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: GlobalVariable.white,
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: GlobalVariable
                                              .text_colors_black)),
                                  child: Image.asset(
                                    'drawable/houseblue.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              Text(
                                'Real Estate\nPayouts',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          // Spacer(),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 37),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: GlobalVariable.white,
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                          color: GlobalVariable
                                              .text_colors_black)),
                                  child: Image.asset(
                                    'drawable/budget.png',
                                    height: 30,
                                    width: 30,
                                  )),
                              Text(
                                'Loan\nPayouts',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
              width: double.infinity,
              color: GlobalVariable.blue_main,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset('drawable/tds.png',height: 35,),
                        ),
                        Text(
                          'Download TDS',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: GlobalVariable.yellow_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('drawable/contactrm_white.png',height: 35,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Help Desk',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('drawable/faq_white.png',height: 35,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'FAQ',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.c,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset('drawable/my_list_act.png',
                            color: GlobalVariable.white,
                            height: 35,
                          ),
                        ),
                        Text(
                          'Addon Payouts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: GlobalVariable.yellow_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('drawable/offers_white.png',height: 35,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Offers',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
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

    print(json);
  }
}
