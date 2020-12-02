import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/MyFmNwLvLThree.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'DataMyFms.dart';
import 'MyFmNw.dart';
import 'customcolor.dart';

void main() {
  runApp(MyFmNwLvLTwo());
}

class MyFmNwLvLTwo extends StatefulWidget {
  final String id;
  MyFmNwLvLTwo({this.id});
  @override
  _MyFmNwLvLTwoState createState() => _MyFmNwLvLTwoState();
}

List<DataMyFms> dataMyFms = new List<DataMyFms>();
TextEditingController controller = new TextEditingController();
var totalFms='0';

class _MyFmNwLvLTwoState extends State<MyFmNwLvLTwo> {
  final String id;
  _MyFmNwLvLTwoState({this.id});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyFMsData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: GlobalVariable.white,
                  height: 45,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'drawable/back_black.png',
                          height: 30,
                          width: 40,
                        ),
                      ),
                      Text(
                        'FM\'s List',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                      Expanded(
                          child: Text(
                        'Level 2',
                        textAlign: TextAlign.center,
                      )),
                      Text(
                        'Active FM\'s : ',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                      Text(
                        ''+totalFms,
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.blue_main,
                ),
                Expanded(
                  child: userList()
                      // : Text('Please wait..'),
                )
              ],
            ),
          ],
        ),
      ),
    );

  }
  Widget userList(){
    return Container(
      color: GlobalVariable.grey_main,
      margin: EdgeInsets.only(bottom: 5),
      child: ListView.builder(
          itemCount: dataMyFms.length,
          itemBuilder: (context, pos) {
            return Container(
              color: GlobalVariable.white,
              // padding: EdgeInsets.only(left: 5, top: 10),
              margin: EdgeInsets.only(
                  left: 5, right: 5, top: 5),
              height: 75,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 3, bottom: 3),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  ImageVieW(
                                      image: dataMyFms[pos]
                                          .image,
                                      tag: dataMyFms[pos]
                                          .id),
                              fullscreenDialog: true),
                        );
                      },
                      child: Hero(
                        tag: dataMyFms[pos].id,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(5),
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
                                    MyFmNwLvLThree(
                                        id: dataMyFms[pos]
                                            .id),
                                fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                                dataMyFms[pos].fname +
                                    "" +
                                    dataMyFms[pos].lname,
                                overflow:
                                TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: GlobalVariable
                                        .blue_main,
                                    fontFamily:
                                    GlobalVariable
                                        .Gotham)),
                            Padding(
                              padding:
                              const EdgeInsets.only(
                                  top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Code : ',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable
                                                  .blue_main,
                                              fontFamily:
                                              GlobalVariable
                                                  .Gotham),
                                        ),
                                        Text(
                                            dataMyFms[pos]
                                                .code,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable
                                                    .blue_main,
                                                fontFamily:
                                                GlobalVariable
                                                    .Gotham)),
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
                                        Text(
                                            splitPhoneNum(dataMyFms[pos]
                                                .phone),
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable
                                                    .blue_main,
                                                fontFamily:
                                                GlobalVariable
                                                    .Gotham))
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
                                      Text(
                                          dataMyFms[pos]
                                              .address,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable
                                                  .blue_main,
                                              fontFamily:
                                              GlobalVariable
                                                  .Gotham)),
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
                                      Text(
                                          dataMyFms[pos]
                                              .profession,
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable
                                                  .blue_main,
                                              fontFamily:
                                              GlobalVariable
                                                  .Gotham))
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
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(
                            // top: 5,
                              bottom: 3),
                          child: Image.asset(
                            'drawable/eye.png',
                            height: 15,
                          ),
                        ),
                        Text(
                          'Payouts',
                          style: TextStyle(
                              color: GlobalVariable
                                  .white,
                              fontSize: 9),
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


  Future<void> getMyFMsData(BuildContext context) async {
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
        "/api/tps.php?" +
        "member_id=" +
        widget.id+
        "&search=");

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
          dataMyFms.add(DataMyFms.fromJson(i));
        }
        totalFms = dataMyFms.length.toString();
      });

      print('getMyFMsData->' + data.toString());
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getMyFMsData->error');

      throw Exception('Failed to load album');
    }
  }

  String splitPhoneNum(String phone) {
    var i = phone.split("");
    print(i[6]+"  "+phone);
    return "xxxxxx"+i[6]+i[7]+i[8]+i[9];
  }


}


