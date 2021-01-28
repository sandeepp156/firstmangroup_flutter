import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/Temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'AddNewPropScreen.dart';
import 'DataMyOffice.dart';
import 'HomeScreen.dart';
import 'customcolor.dart';

void main() {
  runApp(MyOfficeScreen());
}

class MyOfficeScreen extends StatefulWidget {
  @override
  _MyOfficeScreenState createState() => _MyOfficeScreenState();
}

int tab = 0;
final List<DataMyOffice> dataMyOffice = new List<DataMyOffice>();

class _MyOfficeScreenState extends State<MyOfficeScreen> {
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
        child: Stack(
          children: [
            Column(
              children: [
                // Container(
                //   alignment: Alignment.centerLeft,
                //   // height: 45,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           // Navigator.pop(context);
                //           setState(() {
                //             bottomMenu!=0?0:3;
                //
                //           });
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
                //           'My Office',
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
                  child: dataMyOffice.length == 0 ? Center(child: Text('No Data'),):ListView.builder(
                      itemCount:
                          dataMyOffice.length == 0 ? 0 : dataMyOffice.length,
                      itemBuilder: (context, pos) {
                        return myofficeItem(pos);
                      }),
                ))
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AddNewPropScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'drawable/add_new_icon.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myofficeItem(int pos) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
      // padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: GlobalVariable.blue_main, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(5, 5), spreadRadius: 1)
      ]),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15,
            ),
            color: GlobalVariable.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Text('Posted On',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: GlobalVariable.grey_main_,
                                        fontFamily: GlobalVariable.Gotham)),
                              ),
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(color: GlobalVariable.blue_main),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(dataMyOffice[pos].date,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Text('Valid For',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: GlobalVariable.grey_main_,
                                        fontFamily: GlobalVariable.Gotham)),
                              ),
                            ),
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(color: GlobalVariable.blue_main),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(dataMyOffice[pos].expiry_date,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: Text('Plan',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: GlobalVariable.grey_main_,
                                          fontFamily: GlobalVariable.Gotham)),
                                ),
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(color: GlobalVariable.blue_main),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                    dataMyOffice[pos].subscription.title,
                                    style: TextStyle(
                                        fontSize: 10,
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
                            Expanded(
                              child: Container(
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text('Viewed FM',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: GlobalVariable.grey_main_,
                                          fontFamily: GlobalVariable.Gotham)),
                                ),
                              ),
                            ),
                            Text(
                              ' : ',
                              style: TextStyle(color: GlobalVariable.blue_main),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Text(dataMyOffice[pos].views + ' ',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium)),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text('(Click Here)',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: GlobalVariable
                                                  .text_colors_black,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium,
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  // color: GlobalVariable.grey_main,
                  child: Stack(
                    children: [
                      Image.network(
                        dataMyOffice[pos].image1,
                        // 'drawable/bnner1.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'drawable/eye.png',
                                height: 15,
                                width: 20,
                              ),
                              Text(' ' + dataMyOffice[pos].views + ' Views',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.white,
                                      fontFamily: GlobalVariable.GothamMedium)),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          color: GlobalVariable.white,
                          margin: EdgeInsets.all(25),
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 5, right: 10),
                          child: Text(dataMyOffice[pos].title,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: GlobalVariable.blue_main,
                                  fontFamily: GlobalVariable.GothamMedium)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'drawable/rupee.png',
                                color: GlobalVariable.blue_main,
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(dataMyOffice[pos].price_disp,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.GothamMedium)),
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
                                'drawable/map.png',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(dataMyOffice[pos].location,
                                    // 'Vijayawada',//location
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getSalesData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataMyOffice.clear();
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
        "/api/properties_new.php?member_id=" +
        prefs.getString("member_id"));

    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataMyOffice.add(DataMyOffice.fromJson(i));
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
