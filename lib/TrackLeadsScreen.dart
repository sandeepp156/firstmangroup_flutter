import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataTrackLeads.dart';
import 'package:firstmangroup_flutter/EventDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TrackLeadDetailsScreen.dart';
import 'customcolor.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(TrackLeadsScreen());
}

class TrackLeadsScreen extends StatefulWidget {
  @override
  _TrackLeadsScreenState createState() => _TrackLeadsScreenState();
}

final List<DataTrackLeads> dataTrackLeads = new List<DataTrackLeads>();

class _TrackLeadsScreenState extends State<TrackLeadsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrackLeadsData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            SizedBox(
              // alignment: Alignment.centerLeft,
              // height: 45,
              child: Row(
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
                      'Leads',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Column(
                children: [
                  Container(
                    color: GlobalVariable.grey_main_,
                    height: 2,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          height: 36,

                          // padding: EdgeInsets.only(top: 10),
                          color: GlobalVariable.blue_main,
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  'RealEstate Leads',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      // decoration: TextDecoration.underline,

                                      fontFamily: GlobalVariable.GothamMedium,
                                      color: GlobalVariable.white,
                                      fontSize: 13),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: GlobalVariable.yellow_main,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: GlobalVariable.grey_main_,
                        width: 2,
                        height: 35,
                      ),
                      Expanded(
                        child: Container(
                          height: 36,

                          // padding: EdgeInsets.only(top: 10,bottom: 10),

                          color: GlobalVariable.white,
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  'Loan Leads',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.GothamMedium,
                                      fontSize: 13),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Visibility(
                                  visible: false,
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: GlobalVariable.yellow_main,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: GlobalVariable.grey_main_,
                        width: 2,
                        height: 35,
                      ),
                      Expanded(
                        child: Container(
                          height: 36,

                          // padding: EdgeInsets.only(top: 10,bottom: 10),

                          color: GlobalVariable.white,
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  'Insurance Leads',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.GothamMedium,
                                      fontSize: 13),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Visibility(
                                  visible: false,
                                  child: Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: GlobalVariable.yellow_main,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(color: GlobalVariable.grey_main_,height: 2,),
                    ],
                  ),
                  Container(
                    color: GlobalVariable.grey_main_,
                    height: 2,
                  ),
                ],
              ),
            ),
            Container(
              color: GlobalVariable.white,
              height: 40,
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, pos) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 70,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              color: GlobalVariable.white,
                              child: Text(
                                'Nov 2020',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.GothamMedium,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Visibility(
                              visible: false,
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: GlobalVariable.yellow_main,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: GlobalVariable.grey_main,
                child: ListView.builder(
                  itemCount: dataTrackLeads.length==0?0:dataTrackLeads.length,
                    itemBuilder: (context, pos) {
                  return trackLeaditem(context, pos); //trackLeadItem
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget trackLeaditem(BuildContext context, int pos) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      // padding: EdgeInsets.only(top: 10),
      color: GlobalVariable.blue_main,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              dataTrackLeads.length==0?'':dataTrackLeads[0].leads[pos].name+"("+dataTrackLeads[0].leads[pos].leadId+")",
              style: TextStyle(
                  color: GlobalVariable.white,
                  fontFamily: GlobalVariable.GothamMedium,
                  fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 10),
            color: GlobalVariable.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset(
                              'drawable/mobile.png',
                              height: 15,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                dataTrackLeads.length==0?'':dataTrackLeads[0].leads[pos].phone,

                                // 'Vijayawada',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset(
                              'drawable/calendar.png',
                              height: 12,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                dataTrackLeads.length==0?'':dataTrackLeads[0].leads[pos].date,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/bhk.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  dataTrackLeads.length==0?'':dataTrackLeads[0].leads[pos].propertyType,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/map.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/map.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/map.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset(
                              'drawable/map.png',
                              height: 15,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Vijayawada',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset(
                              'drawable/map.png',
                              height: 15,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Vijayawada',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      TrackLeadDetailsScreen()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(
                                left: 40, right: 40, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: GlobalVariable.yellow_main,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              'Track',
                              style: TextStyle(
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Image.asset(
                            'drawable/delete.png',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      // Icon(Icons.restore_from_trash)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget salesItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
      // padding: EdgeInsets.only(top: 10),
      color: GlobalVariable.white,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 7, right: 7),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Stack(
                  // alignment: Alignment.bottomCenter ,
                  children: [
                    Image.asset(
                      'drawable/app_icon.png',
                      height: 100,
                      width: 100,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          'Niwas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              fontSize: 8,
                              color: GlobalVariable.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // color: GlobalVariable.grey_main,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Image.asset(
                                      'drawable/user_yellow.png',
                                      height: 15,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Vijayawada',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Image.asset(
                                      'drawable/mobile.png',
                                      height: 15,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('9494949494',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Image.asset(
                                      'drawable/bed.png',
                                      height: 10,
                                      width: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text('Open Plots',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Image.asset(
                                      'drawable/area.png',
                                      height: 15,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('150',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Image.asset(
                                    'drawable/map.png',
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Vijayawada,',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: GlobalVariable.blue_main,
                                          fontFamily:
                                              GlobalVariable.GothamMedium)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Image.asset(
                                    'drawable/calendar.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text('21-02-2020',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: GlobalVariable.blue_main,
                                          fontFamily:
                                              GlobalVariable.GothamMedium)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 2),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // height: 36,

                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    color: GlobalVariable.blue_main,
                    child: Center(
                      child: Text(
                        'Original Price',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decoration: TextDecoration.underline,

                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.yellow_main,
                            fontSize: 11),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 2),

                    // height: 36,

                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    color: GlobalVariable.blue_main,
                    child: Center(
                      child: Text(
                        'Gross Commission',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decoration: TextDecoration.underline,

                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.yellow_main,
                            fontSize: 11),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    margin: EdgeInsets.only(left: 2),

                    // height: 36,

                    // padding: EdgeInsets.only(top: 10),
                    color: GlobalVariable.blue_main,
                    child: Center(
                      child: Text(
                        'Status',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // decoration: TextDecoration.underline,

                            fontFamily: GlobalVariable.GothamMedium,
                            color: GlobalVariable.yellow_main,
                            fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  // height: 36,

                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: GlobalVariable.blue_main,
                  child: Center(
                    child: Text(
                      '870000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // decoration: TextDecoration.underline,

                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.white,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 2),

                  // height: 36,

                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  color: GlobalVariable.blue_main,
                  child: Center(
                    child: Text(
                      '60000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // decoration: TextDecoration.underline,

                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.white,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(left: 2),

                  // height: 36,

                  // padding: EdgeInsets.only(top: 10),
                  color: GlobalVariable.blue_main,
                  child: Center(
                    child: Text(
                      'Pending',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // decoration: TextDecoration.underline,

                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.red,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myofficeItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      // padding: EdgeInsets.only(top: 10),
      color: GlobalVariable.blue_main,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15,
            ),
            color: GlobalVariable.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              child: Text('Posted On',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.grey_main_,
                                      fontFamily: GlobalVariable.Gotham)),
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(color: GlobalVariable.blue_main),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Vijayawada',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              child: Text('Valid For',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.grey_main_,
                                      fontFamily: GlobalVariable.Gotham)),
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(color: GlobalVariable.blue_main),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Vijayawada',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.GothamMedium)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Text('Posted On',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: GlobalVariable.grey_main_,
                                        fontFamily: GlobalVariable.Gotham)),
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(color: GlobalVariable.blue_main),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Text('Valid For',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: GlobalVariable.grey_main_,
                                        fontFamily: GlobalVariable.Gotham)),
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(color: GlobalVariable.blue_main),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 175,
                  // color: GlobalVariable.grey_main,
                  child: Stack(
                    children: [
                      Image.asset(
                        'drawable/bnner1.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/eye.png',
                                height: 15,
                                width: 20,
                              ),
                              Text(' 100 Views',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.white,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          color: GlobalVariable.white,
                          margin: EdgeInsets.all(25),
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 5, right: 10),
                          child: Text('Beau Fort',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/rupee.png',
                                color: GlobalVariable.blue_main,
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/map.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Vijayawada',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget eventsitem() {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => EventDetailsScreen(),
              ));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
          // padding: EdgeInsets.only(top: 10),
          color: GlobalVariable.white,
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Text(
                    'Title',
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5, left: 4, right: 5),
                color: GlobalVariable.white,
                height: 175,
                // color: GlobalVariable.grey_main,
                child: Card(
                    elevation: 5.0,
                    child: Image.asset(
                      'drawable/bnner1.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 7),
                  child: Text(
                    'Title',
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: GlobalVariable.text_colors_black,
                        fontSize: 10,
                        fontFamily: GlobalVariable.GothamMedium),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTrackLeadsData(BuildContext context) async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/leads.php?member_id="+prefs.getString("member_id")+"+&type=1");

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      // for(Map i in )
      for (Map i in jsonDecode(json)) {
        dataTrackLeads.add(DataTrackLeads.fromJson(i));
      }
      print('getTrackLeadsData->' + data.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getTrackLeadsData->error');

      throw Exception('Failed to load album');
    }
  }
}
