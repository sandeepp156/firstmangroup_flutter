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
  int isSelected = 0;
  int tab =1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrackLeadsData(context,'1');
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
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            getTrackLeadsData(context,'1');

                            setState(() {
                              tab = 1;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),

                            height: 36,

                            // padding: EdgeInsets.only(top: 10),
                            color: tab==1?GlobalVariable.blue_main:Colors.transparent,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'RealEstate Leads',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        // decoration: TextDecoration.underline,

                                        fontFamily: GlobalVariable.GothamMedium,
                                        color: tab==1?GlobalVariable.white:GlobalVariable.blue_main,
                                        fontSize: 13),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible:tab==1? true:false,

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
                      ),
                      Container(
                        color: GlobalVariable.grey_main_,
                        width: 2,
                        height: 35,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            getTrackLeadsData(context,'2');

                            setState(() {
                              tab=2;
                            });
                          },
                          child: AnimatedContainer(
                            height: 36,

                            // padding: EdgeInsets.only(top: 10,bottom: 10),

                            color: tab==2?GlobalVariable.blue_main:Colors.transparent,
                            duration: Duration(milliseconds: 300),

                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Loan Leads',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.GothamMedium,
                                        color: tab==2?GlobalVariable.white:GlobalVariable.blue_main,

                                        fontSize: 13),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible:tab==2? true:false,
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
                      ),
                      Container(
                        color: GlobalVariable.grey_main_,
                        width: 2,
                        height: 35,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            getTrackLeadsData(context,'3');

                            setState(() {
                              tab=3;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),

                            height: 36,

                            // padding: EdgeInsets.only(top: 10,bottom: 10),

                            color: tab==3?GlobalVariable.blue_main:Colors.transparent,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Insurance Leads',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: GlobalVariable.GothamMedium,
                                        color: tab==3?GlobalVariable.white:GlobalVariable.blue_main,

                                        fontSize: 13),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible:tab==3? true:false,
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
                  itemCount: dataTrackLeads.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, pos) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = pos;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 70,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                color: GlobalVariable.white,
                                child: Text(
                                  '' + dataTrackLeads[pos].month,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.GothamMedium,
                                      color: isSelected != null &&
                                              isSelected == pos
                                          ? GlobalVariable.blue_main
                                          : GlobalVariable.grey_main_,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Visibility(
                                visible: isSelected != null && isSelected == pos
                                    ? true
                                    : false,
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
                    );
                  }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: dataTrackLeads.length == 0
                    ? Colors.transparent
                    : GlobalVariable.grey_main,
                child: dataTrackLeads.length == 0
                    ? Text('No Leads')
                    : dataTrackLeads[isSelected].leads.length == 0
                        ? Center(
                            child: Text('No Leads'),
                          )
                        : ListView.builder(
                            itemCount: dataTrackLeads.length == 0
                                ? 0
                                : dataTrackLeads[isSelected].leads.length == 0
                                    ? 0
                                    : dataTrackLeads[isSelected].leads.length,
                            itemBuilder: (context, pos) {
                              return trackLeaditem(
                                  context, pos); //trackLeadItem
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
              dataTrackLeads.length == 0
                  ? ''
                  : dataTrackLeads[isSelected].leads.length == 0
                      ? ''
                      : dataTrackLeads[isSelected].leads[pos].name +
                          "(" +
                          dataTrackLeads[isSelected].leads[pos].leadId +
                          ")",
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
                                dataTrackLeads.length == 0
                                    ? dataTrackLeads[isSelected].leads.length ==
                                            0
                                        ? ''
                                        : dataTrackLeads[isSelected]
                                            .leads[pos]
                                            .phone
                                    : dataTrackLeads[isSelected]
                                        .leads[pos]
                                        .phone,

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
                                dataTrackLeads.length == 0
                                    ? ''
                                    : dataTrackLeads[isSelected].leads.length ==
                                            0
                                        ? ''
                                        : dataTrackLeads[isSelected]
                                            .leads[pos]
                                            .date,
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
                                  dataTrackLeads.length == 0
                                      ? ''
                                      : dataTrackLeads[isSelected]
                                                  .leads
                                                  .length ==
                                              0
                                          ? ''
                                          : dataTrackLeads[isSelected]
                                              .leads[pos]
                                              .propertyType,
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
                                'drawable/area.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  dataTrackLeads.length == 0
                                      ? ''
                                      : dataTrackLeads[isSelected]
                                                  .leads
                                                  .length ==
                                              0
                                          ? ''
                                          : dataTrackLeads[isSelected]
                                              .leads[pos]
                                              .propertyType,
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
                              child: SizedBox(
                                // width: 100,
                                child: Text(
                                    dataTrackLeads.length == 0
                                        ? ''
                                        : dataTrackLeads[isSelected]
                                                    .leads
                                                    .length ==
                                                0
                                            ? ''
                                            : dataTrackLeads[isSelected]
                                                    .leads[pos]
                                                    .area +
                                                ',' +
                                                dataTrackLeads[isSelected]
                                                    .leads[pos]
                                                    .city,
                                    overflow: TextOverflow.ellipsis,

                                    // 'Vijayawada',
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: GlobalVariable.blue_main,
                                        fontFamily:
                                            GlobalVariable.GothamMedium)),
                              ),
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
                                'drawable/amount.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  // 'Vijayawada',
                                  dataTrackLeads.length == 0
                                      ? ''
                                      : dataTrackLeads[isSelected]
                                                  .leads
                                                  .length ==
                                              0
                                          ? ''
                                          : dataTrackLeads[isSelected]
                                              .leads[pos]
                                              .amount,
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
                              'drawable/loan_req.png',
                              height: 15,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                // 'Vijayawada',
                                dataTrackLeads.length == 0
                                    ? ''
                                    : dataTrackLeads[isSelected].leads.length ==
                                            0
                                        ? ''
                                        : dataTrackLeads[isSelected]
                                            .leads[pos]
                                            .loanReq,
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
                              'drawable/help.png',
                              height: 15,
                              width: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                // 'Vijayawada',
                                dataTrackLeads.length == 0
                                    ? ''
                                    : dataTrackLeads[isSelected].leads.length ==
                                            0
                                        ? ''
                                        : dataTrackLeads[isSelected]
                                            .leads[pos]
                                            .curStatus,
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
                        child: InkWell(
                          onTap: () {
                            deleteTrackLead(
                                context, dataTrackLeads[0].leads[pos].id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Image.asset(
                              'drawable/delete.png',
                              height: 25,
                              width: 25,
                            ),
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

  Future<void> getTrackLeadsData(BuildContext context,String type) async {
    dataTrackLeads.clear();
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
        "/api/leads.php?member_id=" +
        prefs.getString("member_id") +
        "+&type="+type);

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
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataTrackLeads.add(DataTrackLeads.fromJson(i));
        }
      });

      print('getTrackLeadsData->' + data.toString());
      print('length->' + dataTrackLeads.length.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getTrackLeadsData->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> deleteTrackLead(BuildContext context, String id) async {
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
        "/api/leads_del.php?member_id=" +
        prefs.getString("member_id") +
        "+&lead_id=" +
        id);

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
      // for (Map i in jsonDecode(json)) {
      //   dataTrackLeads.add(DataTrackLeads.fromJson(i));
      // }
      print('deleteTrackLead->' + data.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('deleteTrackLead->error');

      throw Exception('Failed to load album');
    }
  }
}
