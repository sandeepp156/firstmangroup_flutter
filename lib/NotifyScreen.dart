import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataEvents.dart';
import 'package:firstmangroup_flutter/DataTrackLeads.dart';
import 'package:firstmangroup_flutter/EventDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TrackLeadDetailsScreen.dart';
import 'customcolor.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NotifyScreen());
}

class NotifyScreen extends StatefulWidget {
  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

final List<DataNotify> dataNotify = new List<DataNotify>();

class _NotifyScreenState extends State<NotifyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getNotifyData(context);
    super.initState();
    // getTrackLeadsData(context);
    // getEventsData(context);
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
                      'Notifications',
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
              child: Container(
                padding: EdgeInsets.only(top: 3),
                color: GlobalVariable.grey_main,
                child: ListView.builder(
                  itemCount: dataNotify.length==0?0:dataNotify.length,
                    itemBuilder: (context, pos) {
                  return notifyItem(pos); //trackLeadItem
                }),
              ),
            )
          ],
        ),
      ),
    );
  }





  Widget notifyItem(int pos) {
    return Card(
      child: GestureDetector(
        onTap: () {

          Navigator.push(
              context,
              new PageRouteBuilder(
                  // transitionDuration: Duration(seconds: 1),
                  pageBuilder: (e,f,g)=>NotifyDetails(dataNotify:dataNotify[pos])));
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
                  padding: const EdgeInsets.only(left: 5, top: 10,bottom: 5),
                  child: Text(
                    dataNotify.length==0?'Title':dataNotify[pos].title,
                    // 'd',
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
                    child: Hero(
                      // tag: 'd',
                      tag: dataNotify[pos].id,
                      child: Image.network(
                        dataNotify.length==0?'http://via.placeholder.com/300x175':dataNotify[pos].image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 7),
                  child: Text(
                    // 'f',
                    dataNotify.length==0?'subtitle':parseHtmlString(dataNotify[pos].description),
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: GlobalVariable.text_colors_black,
                        fontSize: 9,
                        fontFamily: GlobalVariable.GothamMedium),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 7,right: 5),
                  child: Text(
                    // 'f',
                    dataNotify.length==0?'date':dataNotify[pos].date,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: GlobalVariable.text_colors_black,
                        fontSize: 9,
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

  Future<void> getNotifyData(BuildContext context) async {
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
        "/api/notifications.php");

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataNotify.add(DataNotify.fromJson(i));
        }
      });

      print('getNotifyData->' + data.toString());
      // print('getNotifyData->' + dataEvents.length.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getNotifyData->error');

      throw Exception('Failed to load album');
    }
  }

}
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}


class DataNotify {
    String date;
    String description;
    String id;
    String image;
    String title;
    String type;
    String type_id;

    DataNotify({this.date, this.description, this.id, this.image, this.title, this.type, this.type_id});

    factory DataNotify.fromJson(Map<String, dynamic> json) {
        return DataNotify(
            date: json['date'],
            description: json['description'],
            id: json['id'],
            image: json['image'],
            title: json['title'],
            type: json['type'],
            type_id: json['type_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['date'] = this.date;
        data['description'] = this.description;
        data['id'] = this.id;
        data['image'] = this.image;
        data['title'] = this.title;
        data['type'] = this.type;
        data['type_id'] = this.type_id;
        return data;
    }
}

class NotifyDetails extends StatelessWidget {
  final DataNotify dataNotify;
  NotifyDetails({this.dataNotify});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
            SizedBox(
              // alignment: Alignment.centerLeft,
              height: 45,
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
                ],
              ),
            ),
            Container(
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
                      padding: const EdgeInsets.only(left: 5, top: 10,bottom: 5),
                      child: Text(
                        dataNotify.title,
                        // 'd',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, left: 4, right: 5),
                    // color: GlobalVariable.white,
                    height: 220,
                    // color: GlobalVariable.grey_main,
                    child: Hero(
                      // tag: 'd',
                      tag: dataNotify.id,
                      child: Image.network(
                        dataNotify.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 7),
                      child: Text(
                        // 'f',
                          dataNotify.description,
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontSize: 12,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
