import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'customcolor.dart';

void main() {
  runApp(SalesListScreen());
}

class SalesListScreen extends StatefulWidget {
  @override
  _SalesListScreenState createState() => _SalesListScreenState();
}

int tab = 0;
final List<DataSalesList> dataSalesList = new List<DataSalesList>();

class _SalesListScreenState extends State<SalesListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getSalesData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.centerLeft,
            //   // height: 45,
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           // // Navigator.pop(context);
            //          setState(() {
            //            // bottomMenu=0;
            //            bottomMenu!=0?0:2;
            //
            //          });
            //         },
            //         child: Hero(
            //           tag: 'back_img',
            //           child: Image.asset(
            //             'drawable/back_black.png',
            //             height: 30,
            //             width: 40,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 12, bottom: 10),
            //         child: Text(
            //           'Sales List',
            //           style: TextStyle(
            //               color: GlobalVariable.blue_main,
            //               fontFamily: GlobalVariable.GothamMedium,
            //               fontSize: 18),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
                                : GlobalVariable.white,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutSine,
                            child: Text(
                              'RealEstate Sales',
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
                                : GlobalVariable.white,
                            child: Text(
                              'Loan Sales',
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
                                : GlobalVariable.white,
                            child: Text(
                              'Insurance Sales',
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
                  Container(
                    color: GlobalVariable.grey_main_,
                    height: 2,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 10),
              color: GlobalVariable.grey_main,
              child: ListView.builder(
                  itemCount:
                      dataSalesList.length == 0 ? 0 : dataSalesList.length,
                  itemBuilder: (context, pos) {
                    return salesItem(pos);
                  }),
            ))
          ],
        ),
      ),
    );
  }

  Widget salesItem(int pos) {
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
                    Image.network(
                      dataSalesList[pos].property.image,
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
                          dataSalesList[pos].property.title,
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
                                    child: Text(
                                        dataSalesList[pos].name,
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
                                    child: Text(
                                        dataSalesList[pos].phone,
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
                                    child: Text(
                                        dataSalesList[pos].property_type,
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
                                    child: Text(
                                        dataSalesList[pos].sqft,
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
                              // mainAxisSize: ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Image.asset(
                                    'drawable/map.png',
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                        dataSalesList[pos].location,
                                        maxLines: 2,
                                        // softWrap: true,
                                        
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
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
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Image.asset(
                                    'drawable/calendar.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                      dataSalesList[pos].date,
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
                      dataSalesList[pos].price,
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
                      dataSalesList[pos].commission.toString(),
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
                      dataSalesList[pos].cur_status,
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

  Future<void> getSalesData(BuildContext context) async {
    dataSalesList.clear();
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
        "/api/sales_properties.php?member_id=" +
        prefs.getString("member_id"));

    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataSalesList.add(DataSalesList.fromJson(i));
        }
      });

      print('getSalesData->' + data.toString());
    } else {
      await pr.hide();
      print('getSalesData->error');
      throw Exception('Failed to load album');
    }
  }
}

class DataSalesList {
  Property property;
  int commission;
  String cur_status;
  String date;
  String final_price;
  String home_loan;
  String id;
  String location;
  String name;
  String phone;
  String price;
  String property_type;
  String sqft;

  DataSalesList(
      {this.property,
      this.commission,
      this.cur_status,
      this.date,
      this.final_price,
      this.home_loan,
      this.id,
      this.location,
      this.name,
      this.phone,
      this.price,
      this.property_type,
      this.sqft});

  factory DataSalesList.fromJson(Map<String, dynamic> json) {
    return DataSalesList(
      property:
          json['property'] != null ? Property.fromJson(json['property']) : null,
      commission: json['commission'],
      cur_status: json['cur_status'],
      date: json['date'],
      final_price: json['final_price'],
      home_loan: json['home_loan'],
      id: json['id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      price: json['price'],
      property_type: json['property_type'],
      sqft: json['sqft'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission'] = this.commission;
    data['cur_status'] = this.cur_status;
    data['date'] = this.date;
    data['final_price'] = this.final_price;
    data['home_loan'] = this.home_loan;
    data['id'] = this.id;
    data['location'] = this.location;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['price'] = this.price;
    data['property_type'] = this.property_type;
    data['sqft'] = this.sqft;
    if (this.property != null) {
      data['property'] = this.property.toJson();
    }
    return data;
  }
}

class Property {
  String image;
  String property_id;
  String title;

  Property({this.image, this.property_id, this.title});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      image: json['image'],
      property_id: json['property_id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['property_id'] = this.property_id;
    data['title'] = this.title;
    return data;
  }
}
