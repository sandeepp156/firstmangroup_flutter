import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataEvents.dart';
import 'package:http/http.dart' as http;

import 'customcolor.dart';

void main() {
  runApp(EventDetailsScreen());
}

class EventDetailsScreen extends StatefulWidget {
  final DataEvents dataEvents;

  EventDetailsScreen({this.dataEvents});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

int veg = 0;
bool veg_ = true;
var attends='';

class _EventDetailsScreenState extends State<EventDetailsScreen>
    with SingleTickerProviderStateMixin {
  final DataEvents dataEvents;

  _EventDetailsScreenState({this.dataEvents});

  bool _show = true;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 700), (_) {
      setState(() => _show = !_show);
    });
    super.initState();
    getAttendsData(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Column(
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
                          'Event',
                          style: TextStyle(
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.t,
                            children: [
                              Text(
                                'Attendees',
                                style: TextStyle(
                                    color: GlobalVariable.yellow_main,
                                    fontFamily: GlobalVariable.GothamMedium,
                                    fontSize: 8),
                              ),
                              Text(
                                attends,
                                style: _show
                                    ? TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.GothamMedium,
                                        fontSize: 10)
                                    : TextStyle(
                                        color: Colors.transparent,
                                        fontFamily: GlobalVariable.GothamMedium,
                                        fontSize: 10),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7, right: 5),
                            child: Image.asset(
                              'drawable/attendes.png',
                              height: 30,
                              width: 30,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                //appbar /**/

                Container(
                  padding: EdgeInsets.only(bottom: 5, left: 3, right: 3),
                  color: GlobalVariable.white,
                  height: 225,
                  // color: GlobalVariable.grey_main,
                  child: Card(
                      elevation: 5.0,
                      child: Hero(
                        tag:widget.dataEvents.id ,
                        child: Image.network(
                          widget.dataEvents.image,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.only(left: 7, right: 7, bottom: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.dataEvents.title,
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              // textAlign: TextAlign.left,
                              parseHtmlString(widget.dataEvents.description),

                              style: TextStyle(
                                  color: GlobalVariable.text_colors_black,
                                  fontSize: 10,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'drawable/eve_anima.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'drawable/eve_date.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.dataEvents.launch_date +
                                        " - " +
                                        widget.dataEvents.conclude_date,
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.GothamMedium),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'drawable/eve_time.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.dataEvents.start_time +
                                          " - " +
                                          widget.dataEvents.end_time,
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: GlobalVariable.text_colors_black,
                                          fontFamily: GlobalVariable.GothamMedium),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'drawable/eve_location.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.dataEvents.city.title,
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: GlobalVariable.text_colors_black,
                                        fontFamily: GlobalVariable.GothamMedium),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GlobalVariable.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.network(
                          widget.dataEvents.venue_image,
                          fit: BoxFit.fill,
                          height: 100,
                          width: 75,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Text(
                              'Venue',
                              style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  // decoration: TextDecoration.underline,
                                  fontFamily: GlobalVariable.GothamMedium),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              height: 1,
                              color: GlobalVariable.yellow_main,
                              width: 50,
                            ),
                            Text(
                              widget.dataEvents.venue,
                              style: TextStyle(
                                  color: GlobalVariable.text_colors_black,
                                  fontSize: 12,
                                  // decoration: TextDecoration.underline,
                                  fontFamily: GlobalVariable.GothamMedium),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                widget.dataEvents.venue_address,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontSize: 9,
                                    // decoration: TextDecoration.underline,
                                    fontFamily: GlobalVariable.GothamMedium),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    color: GlobalVariable.yellow_main,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'drawable/meal.png',
                                          height: 20,
                                          width: 30,
                                        ),
                                        Text(
                                          'Meal\nPreference:',
                                          style: TextStyle(
                                              color: GlobalVariable.white,
                                              fontSize: 10,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      veg = 1;
                                      veg_ = true;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      color: GlobalVariable.yellow_main_thick,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            veg_ == true
                                                ? 'drawable/checkon1.png'
                                                : 'drawable/checkoff1.png',
                                            height: 20,
                                            width: 30,
                                          ),
                                          Text(
                                            'VEG:',
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 10,
                                                fontFamily:
                                                    GlobalVariable.GothamMedium),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      veg = 0;
                                      veg_ = false;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      color: GlobalVariable.yellow_main_thick,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            veg_ == false
                                                ? 'drawable/checkon1.png'
                                                : 'drawable/checkoff1.png',
                                            height: 20,
                                            width: 30,
                                          ),
                                          Text(
                                            'NON-VEG',
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 10,
                                                fontFamily:
                                                    GlobalVariable.GothamMedium),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Image.asset('drawable/share.png',height: 40,width: 40,),
          ],
        ),
      ),
    );
  }

  Future<void> getAttendsData(BuildContext context) async {
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

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/event-attends.php?event_id="+""+widget.dataEvents.id);

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;


      print('getAttendsData->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      attends = map['willbe'].toString()+" Registrations";
      print(attends);


    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getAttendsData->error');

      throw Exception('Failed to load album');
    }
  }
}
