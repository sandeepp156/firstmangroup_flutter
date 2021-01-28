import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AddListingScreen.dart';
import 'DataMemberDetails.dart';
import 'InsuranceScreen.dart';
import 'customcolor.dart';
import 'DataCategory.dart';
import 'DataCities.dart';

void main() {
  runApp(LeadDetailsScreen());
}

class LeadDetailsScreen extends StatefulWidget {
  final String id, loanid, loanTitle, from, bankName, propId, propType, bankId;

  LeadDetailsScreen(
      {this.id,
      this.loanid,
      this.loanTitle,
      this.from,
      this.bankName,
      this.propId,
      this.propType,
      this.bankId});

  @override
  _LeadDetailsScreenState createState() => _LeadDetailsScreenState();
}

// UniqueKey keyy;
bool keyPress = false;
bool salaried = false;
bool yes = false;
bool cityPopup = false;
bool cityList = false;
bool loantypeList = false;
bool TypePopup = false;
bool siteVisityes = false;
bool loanReq = false;
var siteVis = '0', sms = '0', loadn_req = '0', bankId = '0';
String city = 'Select City', area = 'Select Area', cityiD = '', areaiD = '';
String loanType = 'Type of Loan', loanTypeID = '0';
String insuranceType = 'Type of Insurance', insuranceTypeId = '0';

final List<DataCities> dataCities = new List<DataCities>();
final List<DataAreas> dataAreas = new List<DataAreas>();
final List<DataCategory> dataCategory = new List<DataCategory>();
final List<DataLoanType> dataLoanType = new List<DataLoanType>();
final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();


TextEditingController nameCtrl = new TextEditingController(),
    phoneCtrl = new TextEditingController(),
    emailCtrl = new TextEditingController(),
    budgetCtrl = new TextEditingController(),
    cmtCtrl = new TextEditingController();

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
  final String id, loanid, loanTitle, from, bankName, propId, propType, bankId;

  _LeadDetailsScreenState(
      {this.id,
      this.loanid,
      this.loanTitle,
      this.from,
      this.bankName,
      this.propId,
      this.propType,
      this.bankId});

  // get keyy => null;

  @override
  void dispose() {
    // TODO: implement dispose
    nameCtrl.clear();
    phoneCtrl.clear();
    emailCtrl.clear();
    budgetCtrl.clear();
    cmtCtrl.clear();
    loanType = 'Type of Loan';
    keyPress = false;
    insuranceType = 'Type of Insurance';
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.from == 'loan') {
      getLoanTypeData();
      getCitiesData();
    } else if (widget.from == 'insurance') {
      // getLoanTypeData();
      getLoanTypeData();

      getCitiesData();
    } else {}
    getMemberDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: GlobalVariable.grey_main,
              child: Column(
                children: [
                  //appBar
                  Container(
                    color: GlobalVariable.white,
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
                            dataMemDe.length==0?'Lead Details':dataMemDe[0].type=='3'?'Customer Details':'Lead Details',
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 15),
                              child: Text(
                                '*',
                                style: TextStyle(
                                    color: GlobalVariable.red,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: nameCtrl,
                                // maxLength: 10,
                                // keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.only(top: -5.0),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.grey_main_,
                                        fontSize: 14),
                                    hintText:   dataMemDe.length==0?'Lead Name':dataMemDe[0].type=='3'?'Customer Name':'Lead Name'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 15),
                              child: Text(
                                '*',
                                style: TextStyle(
                                    color: GlobalVariable.red,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: phoneCtrl,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.only(top: -5.0),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.grey_main_,
                                        fontSize: 14),
                                    hintText: 'Contact Number'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(left: 20),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            // Text(
                            //   '*',
                            //   style: TextStyle(
                            //       color: GlobalVariable.red,
                            //       fontFamily: GlobalVariable.GothamMedium),
                            // ),
                            Flexible(
                              child: TextField(
                                controller: emailCtrl,
                                // maxLength: 10,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.only(top: -5.0),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontFamily: GlobalVariable.Gotham,
                                        color: GlobalVariable.grey_main_,
                                        fontSize: 14),
                                    hintText: 'Lead Email'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(right: 15),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: GlobalVariable.red,
                                          fontFamily:
                                              GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                  Text(
                                    'City',
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.Gotham),
                                  )
                                  // Flexible(
                                  //   child: TextField(
                                  //     // controller: fnameCtrl,
                                  //     maxLength: 10,
                                  //     keyboardType: TextInputType.phone,
                                  //     style: TextStyle(
                                  //         fontFamily: GlobalVariable.Gotham,
                                  //         color: GlobalVariable.blue_main,
                                  //         fontSize: 14),
                                  //     decoration: InputDecoration(
                                  //         counterText: "",
                                  //         contentPadding:
                                  //             EdgeInsets.only(top: -5.0),
                                  //         enabledBorder: InputBorder.none,
                                  //         border: InputBorder.none,
                                  //         hintStyle: TextStyle(
                                  //             fontFamily: GlobalVariable.Gotham,
                                  //             color: GlobalVariable.grey_main_,
                                  //             fontSize: 14),
                                  //         hintText: 'City'),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    cityPopup = true;
                                    cityList = true;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        dataCities.length == 0
                                            ? 'Select City'
                                            : city,
                                        // 'City',
                                        style: TextStyle(
                                            color: GlobalVariable
                                                .text_colors_black,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                    Image.asset(
                                      'drawable/down_arr.png',
                                      color: GlobalVariable.text_colors_black,
                                      height: 7,
                                      width: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(right: 15),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: GlobalVariable.red,
                                          fontFamily:
                                              GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                  Text(
                                    'Loan Requested for',
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.Gotham),
                                  )
                                ],
                              ),
                            ),

                            // 3 types fixed
                            //get loan id ,loan title
                            //1 loan or 2insuran

                            //add loan Requesq for direct banners screen submit lead
                            //propid  prop_new?city_id = ()

                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.from == 'loan'
                                          ? 'Loan Leads'
                                          : widget.from == 'realestate'
                                              ? 'Real Estate Leads'
                                              : 'Insurance Leads',
                                      // 'Loan Leads',
                                      style: TextStyle(
                                          color:
                                              GlobalVariable.text_colors_black,
                                          fontFamily: GlobalVariable.Gotham),
                                    ),
                                  ),
                                  Image.asset(
                                    'drawable/down_arr.png',
                                    color: GlobalVariable.text_colors_black,
                                    height: 7,
                                    width: 13,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(right: 15),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // popupLoanType();
                                  // sadfasdads
                                  setState(() {
                                    TypePopup = true;
                                    if (widget.from != 'loan') {
                                      loantypeList = false;
                                      getLoanTypeData();
                                    } else {
                                      loantypeList = true;
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        keyPress == true
                                            ? widget.from == 'loan'
                                                ? loanType
                                                : insuranceType
                                            : widget.from == 'loan'
                                                ? widget.loanTitle
                                                    :widget.loanTitle,
                                        // keyPress == true
                                        //     ? widget.from=='loan'?loanType:insuranceType
                                        //     : widget.from == 'loan'
                                        //         ? widget.loanTitle == '0'
                                        //             ? loanType
                                        //             : widget.loanTitle
                                        //         : widget.loanTitle == '0'
                                        //             ? insuranceType
                                        //             : widget.loanTitle,
                                        // key: keyy,
                                        // 'Loan Type',
                                        style: TextStyle(
                                            color: GlobalVariable
                                                .text_colors_black,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                    Image.asset(
                                      'drawable/down_arr.png',
                                      color: GlobalVariable.text_colors_black,
                                      height: 7,
                                      width: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: GlobalVariable.red,
                                          fontFamily:
                                              GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: budgetCtrl,
                                      // maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: GlobalVariable.Gotham,
                                          color: GlobalVariable.blue_main,
                                          fontSize: 14),
                                      decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.only(top: -5.0),
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.grey_main_,
                                              fontSize: 14),
                                          hintText: 'Budget'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.bankName == '0' ? false : true,
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 7),
                          color: GlobalVariable.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                      color: GlobalVariable.red,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Text(
                                '' + widget.bankName,
                                // 'Bank Name',
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.Gotham),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(right: 15),
                        color: GlobalVariable.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: GlobalVariable.red,
                                          fontFamily:
                                              GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    cityPopup = true;
                                    cityList = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        dataAreas.length == 0
                                            ? 'Select Area'
                                            : area,
                                        style: TextStyle(
                                          color:
                                              GlobalVariable.text_colors_black,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'drawable/down_arr.png',
                                      color: GlobalVariable.text_colors_black,
                                      height: 7,
                                      width: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                        visible: widget.id == '0' ? true : false,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              loanReq = loanReq ? false : true;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 7),
                            padding: EdgeInsets.only(left: 20, right: 15),
                            height: 45,
                            color: GlobalVariable.white,
                            child: Row(
                              children: [
                                Text(
                                  'Loan Requested',
                                  style: TextStyle(
                                      color: GlobalVariable.text_colors_black,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                                Spacer(),
                                Image.asset(
                                  loanReq
                                      ? 'drawable/ttick.png'
                                      : 'drawable/un_tick.png',
                                  height: 20,
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //only for Loans not  for Insurance
                      Visibility(
                        visible: widget.from == 'loan' ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 7),
                          color: GlobalVariable.white,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    salaried = salaried ? false : true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      salaried
                                          ? 'drawable/radio_on.png'
                                          : 'drawable/radio_off.png',
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Salaried',
                                        style: TextStyle(
                                            color: GlobalVariable
                                                .text_colors_black,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    salaried = salaried ? false : true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      salaried
                                          ? 'drawable/radio_off.png'
                                          : 'drawable/radio_on.png',
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Not Salaried',
                                        style: TextStyle(
                                            color: GlobalVariable
                                                .text_colors_black,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(top: 5, bottom: 10),
                        color: GlobalVariable.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 15),
                                  child: Text(
                                    '*',
                                    style: TextStyle(
                                        color: GlobalVariable.red,
                                        fontFamily:
                                            GlobalVariable.GothamMedium),
                                  ),
                                ),
                                Text(
                                  'RM Support Required',
                                  style: TextStyle(
                                      color: GlobalVariable.text_colors_black,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        yes = yes ? false : true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          yes
                                              ? 'drawable/radio_on.png'
                                              : 'drawable/radio_off.png',
                                          height: 22,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'YES',
                                            style: TextStyle(
                                              color: GlobalVariable
                                                  .text_colors_black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        yes = yes ? false : true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          yes
                                              ? 'drawable/radio_off.png'
                                              : 'drawable/radio_on.png',
                                          height: 22,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'NO',
                                            style: TextStyle(
                                              color: GlobalVariable
                                                  .text_colors_black,
                                            ),
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
                      ),
                      Visibility(
                        visible: widget.id == '0' ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 7),
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          color: GlobalVariable.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                          color: GlobalVariable.red,
                                          fontFamily:
                                              GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                  Text(
                                    'Site Visit Required',
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.Gotham),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          siteVisityes =
                                              siteVisityes ? false : true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            siteVisityes
                                                ? 'drawable/radio_on.png'
                                                : 'drawable/radio_off.png',
                                            height: 22,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                color: GlobalVariable
                                                    .text_colors_black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          siteVisityes =
                                              siteVisityes ? false : true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            siteVisityes
                                                ? 'drawable/radio_off.png'
                                                : 'drawable/radio_on.png',
                                            height: 22,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'NO',
                                              style: TextStyle(
                                                color: GlobalVariable
                                                    .text_colors_black,
                                              ),
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
                        ),
                      ),

                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.only(top: 5, left: 20, bottom: 10),
                        color: GlobalVariable.white,
                        child: TextField(
                          controller: cmtCtrl,
                          // maxLength: 10,
                          // keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              color: GlobalVariable.blue_main,
                              fontSize: 14),
                          decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(top: -5.0),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontFamily: GlobalVariable.Gotham,
                                  color: GlobalVariable.grey_main_,
                                  fontSize: 14),
                              hintText: 'Comments'),
                        ),
                      ),
                    ],
                  )),
                  InkWell(
                    onTap: () {
                      sendleadDetails();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      color: GlobalVariable.blue_main,
                      child: Center(
                          child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main, fontSize: 18),
                      )),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: cityPopup,
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cityPopup = false;
                    });
                  },
                  child: Container(
                    color: GlobalVariable.grey_main.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        top: 50, bottom: 50, left: 15, right: 15),
                    child: Center(
                      child: dataCities.length == 0
                          ? Text('Please wait..')
                          : cityList == true
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: dataCities.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          city = dataCities[pos].title;
                                          cityiD = dataCities[pos].id;
                                          area = 'Select Area';
                                          // areaController.text = 'Area';
                                          areaId = '-1';
                                          getAreasData(cityiD);
                                          cityPopup = false;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: GlobalVariable.white,
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          dataCities[pos].title,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 16,
                                              color: GlobalVariable.blue_main),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 25, right: 25),
                                      height: 1,
                                      color: GlobalVariable.grey_main,
                                    );
                                  },
                                )
                              : ListView.separated(
                                  // shrinkWrap: true,
                                  itemCount: dataAreas.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          area = dataAreas[pos].title;
                                          // areaController.text =
                                          //     dataAreas[pos].title;

                                          areaiD = dataAreas[pos].id;
                                          cityPopup = false;
                                          // getAreasData(cityId);
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: GlobalVariable.white,
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          dataAreas[pos].title,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 16,
                                              color: GlobalVariable.blue_main),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 25, right: 25),
                                      height: 1,
                                      color: GlobalVariable.grey_main,
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: TypePopup,
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      TypePopup = false;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    color: GlobalVariable.grey_main.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        top: 50, bottom: 50, left: 15, right: 15),
                    child: Center(
                      child: dataLoanType.length == 0
                          ? Text('Please wait..')
                          : loantypeList == true
                              ? ListView.separated(
                                  // shrinkWrap: true,
                                  itemCount: dataLoanType.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          keyPress = true;

                                          loanType = dataLoanType[pos].title;
                                          // keyy.
                                          // print(loanType);

                                          loanTypeID = dataLoanType[pos].id;
                                          TypePopup = false;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: GlobalVariable.white,
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          dataLoanType[pos].title,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 16,
                                              color: GlobalVariable.blue_main),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 25, right: 25),
                                      height: 1,
                                      color: GlobalVariable.grey_main,
                                    );
                                  },
                                )
                              : ListView.separated(
                                  // shrinkWrap: true,
                                  itemCount: dataLoanType.length,
                                  itemBuilder: (context, pos) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          insuranceType =
                                              dataLoanType[pos].title;
                                          // areaController.text =
                                          //     dataAreas[pos].title;

                                          insuranceTypeId =
                                              dataLoanType[pos].id;
                                          TypePopup = false;
                                          // getAreasData(cityId);
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: GlobalVariable.white,
                                        margin: EdgeInsets.only(
                                            left: 25, right: 25),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Text(
                                          dataLoanType[pos].title,
                                          style: TextStyle(
                                              fontFamily: GlobalVariable.Gotham,
                                              fontSize: 16,
                                              color: GlobalVariable.blue_main),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      height: 1,
                                      color: GlobalVariable.grey_main,
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> getMemberDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefs.setString('member_id', '4');

      String json = prefs.get('memberJson');
      for (Map i in jsonDecode(json)) {
        dataMemDe.add(DataMemberDetails.fromJson(i));
      }
    });
  }
  Future<void> getCitiesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dataCities.clear();
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/cities.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCities.add(DataCities.fromJson(i));
        }
      });
      print('getCities->' + data.toString());
    } else {
      print('getCities->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getAreasData(String cityID) async {
    dataAreas.clear();
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

    final response = await http.get(
        "https://" + GlobalVariable.BASE_URL + "/api/areas.php?city=" + cityID);
    if (response.statusCode == 200) {
      await pr.hide();
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataAreas.add(DataAreas.fromJson(i));
        }
      });
      //countInt
    } else {
      await pr.hide();
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getLoanTypeData() async {
    //https://firstmangroup.in/api/loan_types.php
    // dataAds.clear();
    dataLoanType.clear();
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
    var response;
    if (widget.from == 'loan') {
      response = await http
          .get("https://" + GlobalVariable.BASE_URL + "/api/loan_types.php");
    } else {
      response = await http.get(
          "https://" + GlobalVariable.BASE_URL + "/api/insurance_types.php");
    }

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getLoanTypeData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataLoanType.add(DataLoanType.fromJson(i));
        }
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getData->error');

      throw Exception('Failed to load album');
    }
  }

  Future<void> getPropertiesList() async {
    // dataCities.clear();
    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/properties_list.php?city_id=");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCities.add(DataCities.fromJson(i));
        }
      });
      print('getCities->' + data.toString());
    } else {
      print('getCities->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getCategoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dataCategory.clear();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/category.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCategory.add(DataCategory.fromJson(i));
        }
      });
      print('getCategoryData_->' + data.toString());
    } else {
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendleadDetails() async {
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
    // await pr.show();
    var queryParameters = {
      'member_id': '' +prefs.getString('member_id'),
      'name': '' + nameCtrl.text.toString(),
      'email': '' + emailCtrl.text.toString(),
      'phone': '' + phoneCtrl.text.toString(),
      'city': '' + cityiD,
      'type': '' + widget.id,
      'property_id': widget.propId,
      'property_type': widget.propType,
      'loan_type': widget.from == 'insurance' ? '' : widget.loanTitle,
      'salaried': widget.from == 'loan'
          ? salaried == true
              ? '0'
              : '1'
          : '',
      'insurance_type': widget.from == 'insurance' ? widget.loanTitle : '',
      'amount': '' + budgetCtrl.text.toString(),
      'area': '' + areaiD,
      'loan_req': widget.id == '0'
          ? loanReq
              ? '0'
              : '1'
          : '0',
      'site_visit': widget.id == '0'
          ? siteVisityes
              ? '1'
              : '0'
          : '0',
      'rm_support': yes == true ? '0' : '1',
      'bank': widget.from == 'loan' ? widget.bankId : '0',
      'sms': '' + sms,
      'comments': '' + cmtCtrl.text.toString(),
    };

    print('queryParameters==' + queryParameters.toString());

    var uri =
        Uri.https(GlobalVariable.BASE_URL, '/api/lead.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    // final response = await http
    //     .get("https://" + GlobalVariable.BASE_URL + "/api/inventory_sale.php");
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('sendInventDetails->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      if (map['status'] == 'Success') {
        // setInvetImages(map['sale_id']);
      } else {
        print('sendInventDetails:status' + map['status']);
      }
      // status
      // setInvetImages();

      //countInt
    } else {
      await pr.hide();
      print('sendInventDetails->error');
      throw Exception('Failed to load album');
    }
  }
}

///siteVis = 0 , sms = 0 , loadn_req = 0 ,bankId = 0
/////
