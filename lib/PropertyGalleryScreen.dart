import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'customcolor.dart';

void main() {
  runApp(PropertyGalleryScreen());
}
class PropertyGalleryScreen extends StatefulWidget {
  @override
  _PropertyGalleryScreenState createState() => _PropertyGalleryScreenState();
}
final List<DataCategory> dataCategory = new List<DataCategory>();
int isSelected  = 0;


class _PropertyGalleryScreenState extends State<PropertyGalleryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getTrackLeadsData(context);
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
                      'Property Gallery',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: GlobalVariable.white,
              height: 40,
              child: ListView.builder(
                  itemCount: dataCategory.length==0?0:dataCategory.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, pos) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          isSelected = pos;

                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        // width: 70,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                color: GlobalVariable.white,
                                child:
                                Text(
                                  'asdfdsfds',
                                  // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
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
                                visible: isSelected != null && isSelected == pos?true:false,
                                child: Container(
                                  height: 1,
                                  width: 50,
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


          ],
        ),
      ),
    );
  }

  Future<void> getTrackLeadsData(BuildContext context) async {
    dataCategory.clear();
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
//https://firstmangroup.in/api/category.php
    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/category.php");

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
          dataCategory.add(DataCategory.fromJson(i));
        }
        dataCategory.add(DataCategory());
      });

    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getTrackLeadsData->error');

      throw Exception('Failed to load album');
    }
  }

}
class DataCategory {
    String id;
    String title;

    DataCategory({this.id, this.title});

    factory DataCategory.fromJson(Map<String, dynamic> json) {
        return DataCategory(
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}