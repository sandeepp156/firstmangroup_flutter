import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'DataMyFms.dart';
import 'DataPropGallery.dart';
import 'DataTrackLeads.dart';
import 'MyFmNw.dart';
import 'MyFmNwLvLTwo.dart';
import 'customcolor.dart';

void main() {
  runApp(PartnershipDetails());
}

class PartnershipDetails extends StatefulWidget {
  @override
  _PartnershipDetails createState() => _PartnershipDetails();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length, name_length, pname_length, tab = 0;
String fm_tdy, fm_sev_dy, fm_th_dy, fm_nt_dy, fm_tt_dy;
String leads_tdy,
    leads_fm_sev_dy,
    leads_fm_th_dy,
    leads_fm_nt_dy,
    leads_fm_tt_dy;
String sales_tdy,
    sales_fm_sev_dy,
    sales_fm_th_dy,
    sales_fm_nt_dy,
    sales_fm_tt_dy;
String site_tdy, site_fm_sev_dy, site_fm_th_dy, site_fm_nt_dy, site_fm_tt_dy;
var j, pj;
final List<String> fms = new List<String>();
final List<String> leads = new List<String>();
final List<String> sales = new List<String>();
final List<String> siteVisits = new List<String>();
final List<DataPropGallery> dataPropGallery = new List<DataPropGallery>();
final List<DataPropGallery> dataPropGallery_new = new List<DataPropGallery>();
List<DataMyFms> dataMyFms = new List<DataMyFms>();

List<String> gotItems = new List<String>();

class _PartnershipDetails extends State<PartnershipDetails> {
  @override
  void initState() {
    // TODO: implement initState
    getDashData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // appbar
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
                      'Partnership Details',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: tab == 0
                  ? dashboard()
                  : tab == 1
                      ? myprop()
                      : myTemp(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard() {
    return Column(
      children: [
        //tabs
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    tab = 0;
                  });
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: tab == 0
                      ? GlobalVariable.blue_main
                      : GlobalVariable.grey_main,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                  child: Text(
                    'DashBoard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: GlobalVariable.GothamMedium,
                        color: tab == 0
                            ? GlobalVariable.white
                            : GlobalVariable.blue_main,
                        fontSize: 13),
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
                onTap: () {
                  setState(() {
                    tab = 1;
                  });
                },
                child: AnimatedContainer(
                  curve: Curves.easeOutSine,
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: tab == 1
                      ? GlobalVariable.blue_main
                      : GlobalVariable.grey_main,
                  child: Text(
                    'My Properties',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tab == 1
                            ? GlobalVariable.white
                            : GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 13),
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
                onTap: () {
                  setState(() {
                    tab = 2;
                  });
                },
                child: AnimatedContainer(
                  curve: Curves.easeOutSine,
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: tab == 2
                      ? GlobalVariable.blue_main
                      : GlobalVariable.grey_main,
                  child: Text(
                    'My Team',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tab == 2
                            ? GlobalVariable.white
                            : GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 13),
                  ),
                ),
              ),
            ),
            // Container(color: GlobalVariable.grey_main_,height: 2,),
          ],
        ),

        Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 5, top: 5, right: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: GlobalVariable.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: GlobalVariable.grey_main_)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FIRST MAN',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 11),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Today',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + fm_tdy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 7 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + fm_sev_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 30 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + fm_th_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 90 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + fm_nt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + fm_tt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 5, top: 5, right: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: GlobalVariable.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: GlobalVariable.grey_main_)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LEADS',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 11),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Today',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + leads_tdy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 7 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + leads_fm_sev_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 30 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + leads_fm_th_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 90 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + leads_fm_nt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + leads_fm_tt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 5, top: 5, right: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: GlobalVariable.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: GlobalVariable.grey_main_)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NO OF SALES',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 11),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Today',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + sales_tdy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 7 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + sales_fm_sev_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 30 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + sales_fm_th_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 90 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + sales_fm_nt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + sales_fm_tt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 5, top: 5, right: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: GlobalVariable.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: GlobalVariable.grey_main_)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SITE VISITS',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 11),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Today',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + site_tdy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 7 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + site_fm_sev_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 30 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + site_fm_th_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Last 90 Days',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + site_fm_nt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total',
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '- ' + site_fm_tt_dy,
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget myprop() {
    return Expanded(
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: 10),
        color: GlobalVariable.grey_main,
        duration: Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: ListView.builder(
            itemCount: dataPropGallery.length == 0 ? 0 : dataPropGallery.length,
            itemBuilder: (context, pos) {
              return Container(
                decoration: BoxDecoration(
                    color: GlobalVariable.white,
                    boxShadow: [
                      BoxShadow(
                          color: GlobalVariable.grey_main_,
                          offset: Offset(3, 3),
                          blurRadius: 5)
                    ]),
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      child: Stack(
                        children: [
                          Visibility(
                              visible:
                                  dataPropGallery.length == 0 ? false : true,
                              child: Image.network(
                                dataPropGallery[pos].image1,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 25, right: 20),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              color: GlobalVariable.white,
                              child: Text(
                                dataPropGallery.length != null
                                    ? dataPropGallery[pos].title.toString()
                                    : 'title',
                                // 'asdfdsfds',

                                // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.GothamMedium,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Image.asset(
                                  'drawable/rupee.png',
                                  height: 15,
                                  width: 10,
                                ),
                              ),
                              Text(
                                dataPropGallery[pos].priceDisp,
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 13),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Image.asset(
                                  'drawable/location.png',
                                  height: 15,
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  dataPropGallery[pos].area.title +
                                      ',' +
                                      dataPropGallery[pos].city.title,
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget userList() {
    return Container(
      color: GlobalVariable.grey_main,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: dataMyFms.length,
          itemBuilder: (context, pos) {
            return Container(
              color: GlobalVariable.white,
              // padding: EdgeInsets.only(left: 5, top: 10),
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              height: 75,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ImageVieW(
                                  image: dataMyFms[pos].image,
                                  tag: dataMyFms[pos].id),
                              fullscreenDialog: true),
                        );
                      },
                      child: Hero(
                        tag: dataMyFms[pos].id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            dataMyFms[pos].image,
                            fit: BoxFit.fill,
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    MyFmNwLvLTwo(id: dataMyFms[pos].id),
                                fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child:
                            //Details column
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                dataMyFms[pos].fname +
                                    "" +
                                    dataMyFms[pos].lname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Code : ',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(dataMyFms[pos].code,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'drawable/phone.png',
                                          height: 15,
                                          width: 20,
                                        ),
                                        Text(dataMyFms[pos].phone,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham))
                                      ],
                                    ),
                                  )
                                  // Spacer(),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'drawable/location.png',
                                        height: 15,
                                        width: 20,
                                      ),
                                      Text(dataMyFms[pos].address,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'drawable/agent.png',
                                        height: 15,
                                        width: 20,
                                      ),
                                      Text(dataMyFms[pos].profession,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 75,
                    color: GlobalVariable.blue_main,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            // color: GlobalVariable.blue_main,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      // top: 5,
                                      bottom: 3),
                                  child: Image.asset(
                                    'drawable/eye.png',
                                    height: 10,
                                  ),
                                ),
                                Text(
                                  'Payouts',
                                  style: TextStyle(
                                      color: GlobalVariable.white, fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    color: GlobalVariable.yellow_main,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              // top: 5,
                                              bottom: 3),
                                          child: Image.asset(
                                            'drawable/phone_icon.png',
                                            height: 10,
                                            color: GlobalVariable.white,
                                          ),
                                        ),
                                        Text(
                                          'Call FM',
                                          style: TextStyle(
                                              color: GlobalVariable.white,
                                              fontSize: 8),
                                        )
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'drawable/fff.png',
                                  fit: BoxFit.cover,
                                  height: 45,

                                  // height: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget myTemp() {
    return Expanded(
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: 10),
        color: GlobalVariable.grey_main,
        duration: Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: ListView.builder(
            itemCount: dataPropGallery.length == 0 ? 0 : dataPropGallery.length,
            itemBuilder: (context, pos) {
              return Container(
                decoration: BoxDecoration(
                    color: GlobalVariable.white,
                    boxShadow: [
                      BoxShadow(
                          color: GlobalVariable.grey_main_,
                          offset: Offset(3, 3),
                          blurRadius: 5)
                    ]),
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      child: Stack(
                        children: [
                          Visibility(
                              visible:
                                  dataPropGallery.length == 0 ? false : true,
                              child: Image.network(
                                dataPropGallery[pos].image1,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 25, right: 20),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              color: GlobalVariable.white,
                              child: Text(
                                dataPropGallery.length != null
                                    ? dataPropGallery[pos].title.toString()
                                    : 'title',
                                // 'asdfdsfds',

                                // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.GothamMedium,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Image.asset(
                                  'drawable/rupee.png',
                                  height: 15,
                                  width: 10,
                                ),
                              ),
                              Text(
                                dataPropGallery[pos].priceDisp,
                                style: TextStyle(
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham,
                                    fontSize: 13),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Image.asset(
                                  'drawable/location.png',
                                  height: 15,
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  dataPropGallery[pos].area.title +
                                      ',' +
                                      dataPropGallery[pos].city.title,
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> getDashData() async {
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
        "/api/dashboard.php?member_id=" +
        prefs.getString('member_id'));
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      // print(''+map['fms'][3].toString());
      setState(() {
        fm_tdy = map['fms'][0];
        fm_sev_dy = map['fms'][1];
        fm_th_dy = map['fms'][2];
        fm_nt_dy = map['fms'][3];
        fm_tt_dy = map['fms'][4];

        leads_tdy = map['leads'][0];
        leads_fm_sev_dy = map['leads'][1];
        leads_fm_th_dy = map['leads'][2];
        leads_fm_nt_dy = map['leads'][3];
        leads_fm_tt_dy = map['leads'][4];
        //sales,visits

        sales_tdy = map['sales'][0];
        sales_fm_sev_dy = map['sales'][1];
        sales_fm_th_dy = map['sales'][2];
        sales_fm_nt_dy = map['sales'][3];
        sales_fm_tt_dy = map['sales'][4];

        site_tdy = map['visits'][0];
        site_fm_sev_dy = map['visits'][1];
        site_fm_th_dy = map['visits'][2];
        site_fm_nt_dy = map['visits'][3];
        site_fm_tt_dy = map['visits'][3];
      });
      /*  setState(() {

        */
      /*for(int i = 0;i< map['fms'];i++){
          // fms.add(),
        }*/
      /*

      });*/

    } else {
      await pr.hide();
      print('getDashData->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getPropData() async {
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
        "/api/properties.php?member_assign=" +
        prefs.getString('member_id'));
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      // print(''+map['fms'][3].toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPropGallery.add(DataPropGallery.fromJson(i));
        }
      });
      /*  setState(() {

        */
      /*for(int i = 0;i< map['fms'];i++){
          // fms.add(),
        }*/
      /*

      });*/

    } else {
      await pr.hide();
      print('getDashData->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getNewPropData() async {
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
        "/api/properties_new.php?member_assign=" +
        prefs.getString('member_id'));
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      // print(''+map['fms'][3].toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataPropGallery_new.add(DataPropGallery.fromJson(i));
        }
      });
    } else {
      await pr.hide();
      print('getDashData->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getTPSData() async {
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
        "/api/tps.php?member_id=" +
        prefs.getString('member_id'));
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      // print(''+map['fms'][3].toString());
      setState(() {});
      /*  setState(() {

        */
      /*for(int i = 0;i< map['fms'];i++){
          // fms.add(),
        }*/
      /*

      });*/

    } else {
      await pr.hide();
      print('getDashData->error');
      throw Exception('Failed to load album');
    }
  }
}
