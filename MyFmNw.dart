import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/PayoutsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'DataMyFms.dart';
import 'MyFmNwLvLTwo.dart';
import 'customcolor.dart';

void main() {
  runApp(MyFmNwScreen());
}

class MyFmNwScreen extends StatefulWidget {
  @override
  _MyFmNwScreenState createState() => _MyFmNwScreenState();
}

List<DataMyFms> dataMyFms = new List<DataMyFms>();
List<DataMyFms> _userDetails = new List<DataMyFms>();
TextEditingController controller = new TextEditingController();
var totalFms = '0';

class _MyFmNwScreenState extends State<MyFmNwScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyFMsData(context, '');
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
                        'Level 1',
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
                        '' + totalFms,
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
                Container(
                  padding: EdgeInsets.all(10),
                  color: GlobalVariable.white,
                  child: Container(
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        borderRadius: BorderRadius.circular(5)),
                    height: 30,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: controller,
                      onChanged: (string) {
                        getMyFMsData(context, string);
                      },
                      // onChanged: onSearchTextChanged,
                      // maxLength: 10,
                      // keyboardType: TextInputType.phone,
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          color: GlobalVariable.white,
                          fontSize: 14),
                      decoration: InputDecoration(

                          // counterText: "",
                          contentPadding: EdgeInsets.only(
                            bottom: 15,
                            // top: 3.0
                          ),
                          border: InputBorder.none,
                          // enabledBorder: new UnderlineInputBorder(
                          //     borderSide: new BorderSide(
                          //       color: GlobalVariable.blue_main,
                          //     )),
                          // border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: GlobalVariable.Gotham,
                              color: GlobalVariable.white,
                              fontSize: 14),
                          hintText: 'Type Here'),
                    ),
                  ),
                ),
                Expanded(
                    child: dataMyFms.length == 0
                        ? Text('No Data')
                        :
                        // _userDetails.length != 0 || controller.text.isNotEmpty
                        //     ? searchUserList() :
                        userList()
                    // : Text('Please wait..'),
                    )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: double.infinity,
                    color: GlobalVariable.blue_main,
                    child: Text(
                      'Invite FM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18,
                          color: GlobalVariable.yellow_main),
                    )))
          ],
        ),
      ),
    );
  }

  Widget userList() {
    return Container(
      color: GlobalVariable.grey_main,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: dataMyFms.length,
          itemBuilder: (context, pos) {
            return Container(
              color: GlobalVariable.white,
              // padding: EdgeInsets.only(left: 5, top: 10),
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              height: 75,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ImageVieW(
                                  image: dataMyFms[pos].image,
                                  tag: dataMyFms[pos].id),
                              fullscreenDialog: true),
                        );
                      },
                      child: Hero(
                        tag: dataMyFms[pos].id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
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
                                    MyFmNwLvLTwo(id: dataMyFms[pos].id),
                                fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child:
                            //Details column
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                dataMyFms[pos].fname +
                                    "" +
                                    dataMyFms[pos].lname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Code : ',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(dataMyFms[pos].code,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham)),
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
                                        Text(dataMyFms[pos].phone,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham))
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
                                      Text(dataMyFms[pos].address,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham)),
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
                                      Text(dataMyFms[pos].profession,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham))
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
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Navi
                              Navigator.push(context,
                                  CupertinoPageRoute(
                                      builder: (context) {
                                        return PayoutsScreen(id: dataMyFms[pos].id,);
                                      }));
                            },
                            child: Container(
                              // color: GlobalVariable.blue_main,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        // top: 5,
                                        bottom: 3),
                                    child: Image.asset(
                                      'drawable/eye.png',
                                      height: 10,
                                    ),
                                  ),
                                  Text(
                                    'Payouts',
                                    style: TextStyle(
                                        color: GlobalVariable.white,
                                        fontSize: 8),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    UrlLauncher.launch(
                                        "tel://" + dataMyFms[pos].phone);

                                    // String url() {
                                    //
                                    // }
                                  },
                                  child: Container(
                                      color: GlobalVariable.yellow_main,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                // top: 5,
                                                bottom: 3),
                                            child: Image.asset(
                                              'drawable/phone_icon.png',
                                              height: 10,
                                              color: GlobalVariable.white,
                                            ),
                                          ),
                                          Text(
                                            'Call FM',
                                            style: TextStyle(
                                                color: GlobalVariable.white,
                                                fontSize: 8),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      // add the [https]
                                      return "https://wa.me/" +
                                          dataMyFms[pos].phone; // new line
                                    } else {
                                      // add the [https]
                                      return "https://api.whatsapp.com/send?phone=" +
                                          dataMyFms[pos].phone; // new line
                                    }
                                  },
                                  child: Image.asset(
                                    'drawable/fff.png',
                                    fit: BoxFit.cover,
                                    height: 45,

                                    // height: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  Widget searchUserList() {
    return Container(
      color: GlobalVariable.grey_main,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: _userDetails.length,
          itemBuilder: (context, pos) {
            return Container(
              color: GlobalVariable.white,
              // padding: EdgeInsets.only(left: 5, top: 10),
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              height: 75,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ImageVieW(
                                  image: dataMyFms[pos].image,
                                  tag: dataMyFms[pos].id),
                              fullscreenDialog: true),
                        );
                      },
                      child: Hero(
                        tag: _userDetails[pos].id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            _userDetails[pos].image,
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
                                builder: (context) => ImageVieW(
                                    image: _userDetails[pos].image,
                                    tag: _userDetails[pos].id),
                                fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                dataMyFms[pos].fname +
                                    "" +
                                    dataMyFms[pos].lname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: GlobalVariable.blue_main,
                                    fontFamily: GlobalVariable.Gotham)),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Code : ',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham),
                                        ),
                                        Text(_userDetails[pos].code,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham)),
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
                                        Text(_userDetails[pos].phone,
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham))
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
                                      Text(_userDetails[pos].address,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham)),
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
                                      Text(_userDetails[pos].profession,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.Gotham))
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
                      children: [
                        Expanded(
                          child: Container(
                            // color: GlobalVariable.blue_main,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      // top: 5,
                                      bottom: 3),
                                  child: Image.asset(
                                    'drawable/eye.png',
                                    height: 10,
                                  ),
                                ),
                                Text(
                                  'Payouts',
                                  style: TextStyle(
                                      color: GlobalVariable.white, fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    color: GlobalVariable.yellow_main,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              // top: 5,
                                              bottom: 3),
                                          child: Image.asset(
                                            'drawable/phone_icon.png',
                                            height: 10,
                                            color: GlobalVariable.white,
                                          ),
                                        ),
                                        Text(
                                          'Call FM',
                                          style: TextStyle(
                                              color: GlobalVariable.white,
                                              fontSize: 8),
                                        )
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'drawable/fff.png',
                                  fit: BoxFit.cover,
                                  height: 45,

                                  // height: 15,
                                ),
                              ),
                            ],
                          ),
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

  Future<void> getMyFMsData(BuildContext context, String s) async {
    dataMyFms.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /* ProgressDialog pr = ProgressDialog(context);
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
    await pr.show();*/

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/tps.php?" +
        "member_id=4" +
        // prefs.getString('member_id') +
        "&search=" +
        s);

    if (response.statusCode == 200) {
      // await pr.hide();

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
      // await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getMyFMsData->error');

      throw Exception('Failed to load album');
    }
  }

  onSearchTextChanged(String text) async {
    _userDetails.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    dataMyFms.forEach((userDetail) {
      if (userDetail.fname.toUpperCase().contains(text.toUpperCase()) ||
          userDetail.lname.toUpperCase().contains(text.toUpperCase()))
        setState(() {
          _userDetails.add(userDetail);
        });
    });

    setState(() {});
  }
}

class ImageVieW extends StatefulWidget {
  final String image, tag;

  ImageVieW({this.image, this.tag});

  @override
  _ImageVieWState createState() => _ImageVieWState();
}

class _ImageVieWState extends State<ImageVieW> {
  final String image, tag;

  _ImageVieWState({this.image, this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Center(
                child:
                    // Hero(
                    //     tag: widget.tag,
                    //     child:
                    InteractiveViewer(child: Image.network('' + widget.image))
                // ),
                ),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20),
                    child: Image.asset(
                      'drawable/close.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
