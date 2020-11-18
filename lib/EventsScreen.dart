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
  runApp(EventsScreen());
}

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

final List<DataEvents> dataEvents = new List<DataEvents>();

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTrackLeadsData(context);
    getEventsData(context);
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
                      'Events',
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
                  itemCount: dataEvents.length==0?0:dataEvents.length,
                    itemBuilder: (context, pos) {
                  return eventsitem(pos); //trackLeadItem
                }),
              ),
            )
          ],
        ),
      ),
    );
  }





  Widget eventsitem(int pos) {
    return Card(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     new MaterialPageRoute(
          //       builder: (context) => EventDetailsScreen(dataEvents:dataEvents[pos]),
          //     ));
          Navigator.push(
              context,
              new PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (e,f,g)=>EventDetailsScreen(dataEvents:dataEvents[pos])));
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
                    dataEvents.length==0?'Title':dataEvents[pos].title,
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
                      tag: dataEvents[pos].id,
                      child: Image.network(
                        dataEvents.length==0?'http://via.placeholder.com/300x175':dataEvents[pos].image,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 7),
                  child: Text(
                    dataEvents.length==0?'subtitle':parseHtmlString(dataEvents[pos].description),
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

  Future<void> getEventsData(BuildContext context) async {
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
        "/api/events.php");

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataEvents.add(DataEvents.fromJson(i));
        }
      });

      print('getEventsData->' + data.toString());
      print('getEventsData->' + dataEvents.length.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getEventsData->error');

      throw Exception('Failed to load album');
    }
  }

}
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}
