import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import 'customcolor.dart';

void main() {
  runApp(MyCreditsScreen());
}

class MyCreditsScreen extends StatefulWidget {
  @override
  _MyCreditsScreenState createState() => _MyCreditsScreenState();
}

final List<DataCredits> dataCredits = new List<DataCredits>();
final List<DataDebits> dataDebits = new List<DataDebits>();
String expCredits = '';
String totalCredits = '';
var translistCount = 5;
bool popupList=false,transLog=true;

class _MyCreditsScreenState extends State<MyCreditsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyCreditsData();
    getMyDebitsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                //appBar
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
                          'My Credits',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 7, left: 3),
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
                  margin: EdgeInsets.only(bottom: 5),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Anil Kumar',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Code',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontFamily: GlobalVariable.GothamMedium,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 5),
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Expired Credits : ',
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: '' + expCredits,
                                style: TextStyle(
                                    color: GlobalVariable.red,
                                    fontFamily: GlobalVariable.GothamMedium,
                                    fontSize: 16),
                              ),
                            ])),
                          ),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: 'Total Credits : ',
                              style: TextStyle(
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.Gotham,
                                  fontSize: 16),
                            ),
                            TextSpan(
                              text: '' + totalCredits,
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontFamily: GlobalVariable.GothamMedium,
                                  fontSize: 20),
                            ),
                          ])),
                          Container(
                            height: 3,
                            color: GlobalVariable.grey_main_,
                            margin: EdgeInsets.only(top: 10),
                          ),
                          //Tran Log
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    popupList = true;
                                    transLog = true;
                                  });

                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  width: double.infinity,
                                  color: GlobalVariable.blue_main,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Transaction Log',
                                        style: TextStyle(
                                            color: GlobalVariable.white,
                                            fontFamily: GlobalVariable.GothamMedium,
                                            fontSize: 20),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'drawable/down_arr.png',
                                        height: 15,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  color: GlobalVariable.grey_main,
                                  child: dataCredits.length == 0
                                      ? Text('')
                                      : Container(
                                          padding: EdgeInsets.only(bottom: 20),
                                          color: GlobalVariable.white,
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: translistCount,
                                                  itemBuilder: (context, pos) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: 1,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                left: 10,
                                                                right: 10),
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Image.asset(
                                                                      'drawable/cal_imgg.png',
                                                                      height: 40,
                                                                      width: 40,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 4,left: 5),
                                                                      child: Text(
                                                                        ''+dataCredits[pos].date,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .white,
                                                                            fontFamily:
                                                                            GlobalVariable
                                                                                .GothamMedium,
                                                                            fontSize:
                                                                            8),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 18,left: 11),
                                                                      child: Text(
                                                                        ''+dataCredits[pos].day,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .yellow_main,
                                                                            fontFamily:
                                                                            GlobalVariable
                                                                                .GothamMedium,
                                                                            fontSize:
                                                                            16),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets.only(
                                                                          left: 10,
                                                                          right: 7),
                                                                  width: 1,
                                                                  color:
                                                                      GlobalVariable
                                                                          .blue_main,
                                                                  height: 39,
                                                                ),
                                                                Expanded(
                                                                    child: Container(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        'Credits Added',
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .blue_main,
                                                                            fontFamily:
                                                                                GlobalVariable
                                                                                    .GothamMedium,
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                      Text(
                                                                        'Expire By : ' +
                                                                            dataCredits[
                                                                                    pos]
                                                                                .expiry_date,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .blue_main,
                                                                            fontFamily:
                                                                                GlobalVariable
                                                                                    .Gotham,
                                                                            fontSize:
                                                                                9),
                                                                      ),
                                                                      Text(
                                                                        '' +
                                                                            dataCredits[
                                                                                    pos]
                                                                                .remarks,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .yellow_main_thick,
                                                                            fontFamily:
                                                                                GlobalVariable
                                                                                    .Gotham,
                                                                            fontSize:
                                                                                11),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                                RichText(
                                                                    text: TextSpan(
                                                                        children: <
                                                                            TextSpan>[
                                                                      TextSpan(
                                                                        text: '+' +
                                                                            dataCredits[
                                                                                    pos]
                                                                                .points,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .primary,
                                                                            fontFamily:
                                                                                GlobalVariable
                                                                                    .Gotham,
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      TextSpan(
                                                                        text: '\nBal : ' +
                                                                            dataCredits[
                                                                                    pos]
                                                                                .balance,
                                                                        style: TextStyle(
                                                                            color: GlobalVariable
                                                                                .grey_main_,
                                                                            fontFamily:
                                                                                GlobalVariable
                                                                                    .GothamMedium,
                                                                            fontSize:
                                                                                9),
                                                                      ),
                                                                    ])),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 1,
                                                            color: GlobalVariable
                                                                .grey_main,
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: InkWell(
                                                  onTap: (){
                                                    setState(() {

                                                      // translistCount = translistCount==5?dataCredits.length:5;
                                                    });
                                                  },
                                                  child: Text(
                                                    'View more',
                                                    // 'View more',
                                                    style: TextStyle(
                                                      color: GlobalVariable.blue_main,
                                                      fontFamily: GlobalVariable.Gotham,
                                                      decoration:
                                                          TextDecoration.underline,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    popupList = true;
                                    transLog = false;
                                  });

                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 3),
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  width: double.infinity,
                                  color: GlobalVariable.blue_main,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Debit History',
                                        style: TextStyle(
                                            color: GlobalVariable.white,
                                            fontFamily: GlobalVariable.GothamMedium,
                                            fontSize: 20),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'drawable/down_arr.png',
                                        height: 15,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  color: GlobalVariable.grey_main,
                                  child: dataDebits.length == 0
                                      ? Text('Please wait..')
                                      : Container(
                                    padding: EdgeInsets.only(bottom: 20),
                                    color: GlobalVariable.white,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: translistCount,
                                            itemBuilder: (context, pos) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 1,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10,
                                                          left: 10,
                                                          right: 10),
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Image.asset(
                                                                'drawable/cal_imgg.png',
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 4,left: 5),
                                                                child: Text(
                                                                  ''+dataCredits[pos].date,
                                                                  style: TextStyle(
                                                                      color: GlobalVariable
                                                                          .white,
                                                                      fontFamily:
                                                                      GlobalVariable
                                                                          .GothamMedium,
                                                                      fontSize:
                                                                      8),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 18,left: 11),
                                                                child: Text(
                                                                  ''+dataCredits[pos].day,
                                                                  style: TextStyle(
                                                                      color: GlobalVariable
                                                                          .yellow_main,
                                                                      fontFamily:
                                                                      GlobalVariable
                                                                          .GothamMedium,
                                                                      fontSize:
                                                                      16),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            margin:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 7),
                                                            width: 1,
                                                            color:
                                                            GlobalVariable
                                                                .blue_main,
                                                            height: 39,
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      'Credits Added',
                                                                      style: TextStyle(
                                                                          color: GlobalVariable
                                                                              .blue_main,
                                                                          fontFamily:
                                                                          GlobalVariable
                                                                              .GothamMedium,
                                                                          fontSize:
                                                                          14),
                                                                    ),
                                                                    Text(
                                                                      'Expire By : ' +
                                                                          dataCredits[
                                                                          pos]
                                                                              .expiry_date,
                                                                      style: TextStyle(
                                                                          color: GlobalVariable
                                                                              .blue_main,
                                                                          fontFamily:
                                                                          GlobalVariable
                                                                              .Gotham,
                                                                          fontSize:
                                                                          9),
                                                                    ),
                                                                    Text(
                                                                      '' +
                                                                          dataCredits[
                                                                          pos]
                                                                              .remarks,
                                                                      style: TextStyle(
                                                                          color: GlobalVariable
                                                                              .yellow_main_thick,
                                                                          fontFamily:
                                                                          GlobalVariable
                                                                              .Gotham,
                                                                          fontSize:
                                                                          11),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                          RichText(
                                                              text: TextSpan(
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                      text: '+' +
                                                                          dataCredits[
                                                                          pos]
                                                                              .points,
                                                                      style: TextStyle(
                                                                          color: GlobalVariable
                                                                              .primary,
                                                                          fontFamily:
                                                                          GlobalVariable
                                                                              .Gotham,
                                                                          fontSize:
                                                                          16),
                                                                    ),
                                                                    TextSpan(
                                                                      text: '\nBal : ' +
                                                                          dataCredits[
                                                                          pos]
                                                                              .balance,
                                                                      style: TextStyle(
                                                                          color: GlobalVariable
                                                                              .grey_main_,
                                                                          fontFamily:
                                                                          GlobalVariable
                                                                              .GothamMedium,
                                                                          fontSize:
                                                                          9),
                                                                    ),
                                                                  ])),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      color: GlobalVariable
                                                          .grey_main,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                translistCount = translistCount==5?dataCredits.length:5;
                                              });
                                            },
                                            child: Text(
                                              translistCount==5?'View more':'Show less',
                                              // 'View more',
                                              style: TextStyle(
                                                color: GlobalVariable.blue_main,
                                                fontFamily: GlobalVariable.Gotham,
                                                decoration:
                                                TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                margin: EdgeInsets.only(top: 2),
                                width: double.infinity,
                                color: GlobalVariable.blue_main,
                                child: Row(
                                  children: [
                                    Text(
                                      'Terms and Conditions',
                                      style: TextStyle(
                                          color: GlobalVariable.white,
                                          fontFamily: GlobalVariable.GothamMedium,
                                          fontSize: 20),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      'drawable/down_arr.png',
                                      height: 15,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: popupList,
              child: InkWell(
                onTap: (){
                  setState(() {
                    popupList = false;

                  });
                },
                child: Container(
                  color: GlobalVariable.white,
                  child:     Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        width: double.infinity,
                        color: GlobalVariable.blue_main,
                        child: Row(
                          children: [
                            Text(
                              transLog?'Transaction Log':'Debit History',
                              style: TextStyle(
                                  color: GlobalVariable.white,
                                  fontFamily: GlobalVariable.GothamMedium,
                                  fontSize: 20),
                            ),
                            Spacer(),
                            RotatedBox(
                              quarterTurns:90,
                              child: Image.asset(
                                'drawable/down_arr.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            // shrinkWrap: true,
                            itemCount:  transLog?dataCredits.length:dataDebits.length,
                            itemBuilder: (context, pos) {
                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: 1,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Image.asset(
                                                'drawable/cal_imgg.png',
                                                height: 40,
                                                width: 40,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4,left: 5),
                                                child: Text(
                                                  transLog?dataCredits[pos].date:dataCredits[pos].date,
                                                  // ''+dataCredits[pos].date,
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .white,
                                                      fontFamily:
                                                      GlobalVariable
                                                          .GothamMedium,
                                                      fontSize:
                                                      8),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 18,left: 11),
                                                child: Text(
                                                  transLog?dataCredits[pos].day:dataCredits[pos].day,
                                                  // ''+dataCredits[pos].day,
                                                  style: TextStyle(
                                                      color: GlobalVariable
                                                          .yellow_main,
                                                      fontFamily:
                                                      GlobalVariable
                                                          .GothamMedium,
                                                      fontSize:
                                                      16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.only(
                                                left: 10,
                                                right: 7),
                                            width: 1,
                                            color:
                                            GlobalVariable
                                                .blue_main,
                                            height: 39,
                                          ),
                                          Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Credits Added',
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .blue_main,
                                                          fontFamily:
                                                          GlobalVariable
                                                              .GothamMedium,
                                                          fontSize:
                                                          14),
                                                    ),
                                                    Text(
                                                     transLog?'Expire By : '+dataCredits[pos].expiry_date:'Expire By : '+dataCredits[pos].expiry_date,
                                                          // dataCredits[pos].expiry_date,
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .blue_main,
                                                          fontFamily:
                                                          GlobalVariable
                                                              .Gotham,
                                                          fontSize:
                                                          9),
                                                    ),
                                                    Text(
                                                          transLog?dataCredits[pos].remarks:dataCredits[pos].remarks,
                                                          // dataCredits[pos].remarks,
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .yellow_main_thick,
                                                          fontFamily:
                                                          GlobalVariable
                                                              .Gotham,
                                                          fontSize:
                                                          11),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          RichText(
                                              text: TextSpan(
                                                  children: <
                                                      TextSpan>[
                                                    TextSpan(
                                                      text:
                                                      transLog?'+'+dataCredits[pos].points:'+'+dataCredits[pos].points,

                                                      // '+' + dataCredits[pos].points,
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .primary,
                                                          fontFamily:
                                                          GlobalVariable
                                                              .Gotham,
                                                          fontSize:
                                                          16),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                      transLog?'\nBal : '+dataCredits[pos].points:'\nBal : '+dataCredits[pos].points,
                                                      // '\nBal : ' + dataCredits[pos].balance,
                                                      style: TextStyle(
                                                          color: GlobalVariable
                                                              .grey_main_,
                                                          fontFamily:
                                                          GlobalVariable
                                                              .GothamMedium,
                                                          fontSize:
                                                          9),
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: GlobalVariable
                                          .grey_main,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getMyCreditsData() async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/member_credits.php?+member_id=+" +
        GlobalVariable.member_id);

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getMyCeredits->' + data.toString());

      setState(() {
        expCredits = map['expired_total'].toString();
        totalCredits = map['total'].toString();
        for (Map i in map['credits']) {
          dataCredits.add(DataCredits.fromJson(i));
        }
      });
    } else {
      await pr.hide();
      print('getMyCeredits->error');
      throw Exception('Failed to load album');
    }
  }
  Future<void> getMyDebitsData() async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/member_debits.php?+member_id=+" +
        GlobalVariable.member_id);

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getMyDebits->' + data.toString());

      setState(() {
        // expCredits = map['expired_total'].toString();
        // totalCredits = map['total'].toString();
        for (Map i in map['debits']) {
          dataDebits.add(DataDebits.fromJson(i));
        }
      });
    } else {
      await pr.hide();
      print('getMyDebits->error');
      throw Exception('Failed to load album');
    }
  }
}

class DataCredits {
  String balance;
  String date;
  String day;
  String expiry_date;
  String points;
  String remarks;
  String title;
  String type;

  DataCredits(
      {this.balance,
      this.date,
      this.day,
      this.expiry_date,
      this.points,
      this.remarks,
      this.title,
      this.type});

  factory DataCredits.fromJson(Map<String, dynamic> json) {
    return DataCredits(
      balance: json['balance'],
      date: json['date'],
      day: json['day'],
      expiry_date: json['expiry_date'],
      points: json['points'],
      remarks: json['remarks'],
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['date'] = this.date;
    data['day'] = this.day;
    data['expiry_date'] = this.expiry_date;
    data['points'] = this.points;
    data['remarks'] = this.remarks;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
class DataDebits {
  String balance;
  String date;
  String day;
  String expiry_date;
  String points;
  String remarks;
  String title;
  String type;

  DataDebits(
      {this.balance,
        this.date,
        this.day,
        this.expiry_date,
        this.points,
        this.remarks,
        this.title,
        this.type});

  factory DataDebits.fromJson(Map<String, dynamic> json) {
    return DataDebits(
      balance: json['balance'],
      date: json['date'],
      day: json['day'],
      expiry_date: json['expiry_date'],
      points: json['points'],
      remarks: json['remarks'],
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['date'] = this.date;
    data['day'] = this.day;
    data['expiry_date'] = this.expiry_date;
    data['points'] = this.points;
    data['remarks'] = this.remarks;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
