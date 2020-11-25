// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
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
  runApp(LoansScreen());
}

class LoansScreen extends StatefulWidget {
  final String typeId;

  LoansScreen({this.typeId});

  @override
  _LoansScreenState createState() => _LoansScreenState();
}

final List<DataBanners> dataBanners = new List<DataBanners>();
// final List<DataAds> dataAds = new List<DataAds>();

List<String> dataCatg = [
  "Home Loan","Personal Loan","Vehicle Loan","Loan Transfer","Mortgage Loan"
];
List<String> dataCatgImg = [
  "","Personal Loan","Vehicle Loan","Loan Transfer","Mortgage Loan"
];

class _LoansScreenState extends State<LoansScreen> {
  final String typeId;

  _LoansScreenState({this.typeId});

  @override
  void initState() {
    // TODO: implement initState
    getData();
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
              'Loan',
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
                    builder: (context) => BannersScreen(id: dataBanners[i].id)),
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
            ListView(
              children: [

              ],
            )
          ],
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
}


