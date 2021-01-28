import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataTrackLeads.dart';
import 'package:firstmangroup_flutter/EventDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataSiteVisits.dart';
import 'TrackLeadDetailsScreen.dart';
import 'customcolor.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SiteVisitScreen());
}

class SiteVisitScreen extends StatefulWidget {
  @override
  _SiteVisitScreenState createState() => _SiteVisitScreenState();
}

final List<DataSiteVisits> dataSiteVisits = new List<DataSiteVisits>();

class _SiteVisitScreenState extends State<SiteVisitScreen> {
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
            Container(
              color: GlobalVariable.white,
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
                      'Site Visits',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
Container(height: 1,color: GlobalVariable.grey_main_,),
/*
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
*/
            Container(
              color: GlobalVariable.white,
              height: 40,
              child: ListView.builder(
                  itemCount: dataSiteVisits.length,
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
                                  '' + dataSiteVisits[pos].month,
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
                color: dataSiteVisits.length == 0
                    ? Colors.transparent
                    : GlobalVariable.grey_main,
                child: dataSiteVisits.length == 0
                    ? Text('No Visits')
                    : dataSiteVisits[isSelected].leads.length == 0
                        ? Center(
                            child: Text('No Visits'),
                          )
                        : ListView.builder(
                            itemCount: dataSiteVisits.length == 0
                                ? 0
                                : dataSiteVisits[isSelected].leads.length == 0
                                    ? 0
                                    : dataSiteVisits[isSelected].leads.length,
                            itemBuilder: (context, pos) {
                              return Container(
                                child: Text('No Visits'),
                              )
                                /*trackLeaditem(
                                  context, pos)*/
                              ; //trackLeadItem
                            }),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> getTrackLeadsData(BuildContext context,String type) async {
    dataSiteVisits.clear();
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
        "/api/site_visits.php?member_id=" +
        prefs.getString("member_id"));

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
          dataSiteVisits.add(DataSiteVisits.fromJson(i));
        }
      });

      print('getTrackLeadsData->' + data.toString());
      print('length->' + dataSiteVisits.length.toString());
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
