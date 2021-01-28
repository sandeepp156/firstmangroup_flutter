// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/ApplyLoanScreen.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'MyFmNw.dart';
import 'PropertyGalleryScreen.dart';
import 'initialpage.dart';

void main() {
  runApp(InsuranceScreen());
}

class InsuranceScreen extends StatefulWidget {
  final String typeId;

  InsuranceScreen({this.typeId});

  @override
  _InsuranceScreenState createState() => _InsuranceScreenState();
}

final List<DataBanners> dataBanners = new List<DataBanners>();
final List<DataLoanType> dataLoanType = new List<DataLoanType>();
// final List<DataAds> dataAds = new List<DataAds>();

List<String> dataBusiness = [
  "Submit Lead",
  "Emi Calculator",
  "Contact Rm",
  "Check Eligibility",
  "Offers"
];
List<String> dataBusinessImg = [
  "drawable/submitlead_white.png",
  "drawable/emicalculator_white.png",
  "drawable/contactrm_white.png",
  "drawable/checkeligibility.png",
  "drawable/offers_white.png",
];

class _InsuranceScreenState extends State<InsuranceScreen> {
  final String typeId;

  _InsuranceScreenState({this.typeId});

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getLoanTypeData();
    // showProg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                appBar(),
                Expanded(child: HomePage()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
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
              'Insurance',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget HomePage() {
    return ListView(
      children: [
        SizedBox(
          height: 220,
          child: Carousel(
            images: dataBanners.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Text('Loading'),
                  ]
                : dataBanners.map((imgURL) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imgURL.image,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
            onImageTap: (i) {
              print('' + i.toString());

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => BannersScreen(id: dataBanners[i].typeId,typeId: dataBanners[i].type,)),
              );
            },
            showIndicator: true,
            borderRadius: false,
            dotSize: 3.0,
            dotSpacing: 5.0,
            dotIncreasedColor: GlobalVariable.white,
            dotColor: GlobalVariable.grey_main,
            dotBgColor: Colors.transparent,
            noRadiusForIndicator: true,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        Column(
          children: [
            Text(
              'FIND BY CATEGORY',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  // height: 1.5,
                  // decoration:TextDecoration.underline,
                  fontSize: 12),
            ),
            Container(
              color: GlobalVariable.yellow_main,
              height: 1,
              width: 110,
              margin: EdgeInsets.only(top: 3, bottom: 12),
            ),
            SizedBox(
              height: 75,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataLoanType.length == 0 ? 0 : dataLoanType.length,
                  itemBuilder: (context, pos) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ApplyLoanScreen(
                                  id: dataLoanType[pos].id,
                                  title: dataLoanType[pos].title)),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          children: [
                            Image.network(
                              dataLoanType[pos].image,
                              height: 40,
                              width: 50,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              dataLoanType[pos].title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.Gotham),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
        Container(
          color: GlobalVariable.blue_main,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'BUSSINESS GADGETS',
                  style: TextStyle(
                      color: GlobalVariable.white,
                      fontFamily: GlobalVariable.GothamMedium,
                      // height: 1.5,
                      // decoration:TextDecoration.underline,
                      fontSize: 12),
                ),
              ),
              Container(
                color: GlobalVariable.yellow_main,
                height: 1,
                width: 130,
                margin: EdgeInsets.only(top: 3, bottom: 12),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        dataBusiness.length == 0 ? 0 : dataBusiness.length,
                    itemBuilder: (context, pos) {
                      return Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Image.asset(
                                dataBusinessImg[pos],
                                height: 35,
                                width: 40,
                                color: GlobalVariable.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              dataBusiness[pos],
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: GlobalVariable.yellow_main,
                                  fontFamily: GlobalVariable.Gotham),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getData() async {
    // dataAds.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonAds = prefs.getString("cityJson");

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
        "/api/banners.php?city_id=1&type=" +
        widget.typeId.toString());

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataBanners.add(DataBanners.fromJson(i));
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

  Future<void> getLoanTypeData() async {

    //https://firstmangroup.in/api/loan_types.php
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

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/insurance_types.php");

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getData->' + data.toString());
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
}

class DataLoanType {
  String id;
  String image;
  String title;

  DataLoanType({this.id, this.image, this.title});

  factory DataLoanType.fromJson(Map<String, dynamic> json) {
    return DataLoanType(
      id: json['id'],
      image: json['image'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
