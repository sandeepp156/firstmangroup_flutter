import 'dart:convert';
import 'dart:io';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

import 'package:firstmangroup_flutter/DataMemberDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'customcolor.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

void main() {
  runApp(MyAssistantScreen());
}

class MyAssistantScreen extends StatefulWidget {
  @override
  _MyAssistantScreenState createState() => _MyAssistantScreenState();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();

class _MyAssistantScreenState extends State<MyAssistantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.blue_main,
          child: Stack(
            children: [
              Image.asset(
                'drawable/bnner1.png',
                height: 175,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 45,
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
                          color: GlobalVariable.white,
                          height: 30,
                          width: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 10),
                      child: Text(
                        'Contact RM',
                        style: TextStyle(
                            color: GlobalVariable.white,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        dataMemDe.length != 0
                            ? dataMemDe[0].relation_manager.image
                            : '',
                        // 'drawable/user_yellow.png'
                        height: 100,
                        // width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        dataMemDe.length != 0
                            ? dataMemDe[0].relation_manager.fname +
                                dataMemDe[0].relation_manager.lname
                            : 'name',
                        style: TextStyle(
                            fontSize: 26,
                            color: GlobalVariable.white,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          dataMemDe.length != 0
                              ? dataMemDe[0].relation_manager.description
                              : 'About',
                          style: TextStyle(
                              fontSize: 16,
                              color: GlobalVariable.white,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      color: GlobalVariable.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FlutterOpenWhatsapp.sendSingleMessage(
                                    dataMemDe.length != 0
                                        ? '+91'+dataMemDe[0].relation_manager.phone
                                        : '',
                                    dataMemDe.length != 0
                                        ? "Hello" +
                                            dataMemDe[0]
                                                .relation_manager
                                                .fname +
                                            dataMemDe[0].relation_manager.lname
                                        : '');
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'drawable/whatsup_settings.png',
                                      height: 25,
                                      width: 25,
                                      color: GlobalVariable.blue_main,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'What\'sApp',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            color: GlobalVariable.blue_main,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                UrlLauncher.launch("tel://" +
                                    dataMemDe[0].relation_manager.phone);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'drawable/phone_icon.png',
                                      height: 25,
                                      width: 25,
                                      color: GlobalVariable.blue_main,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Call RM',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham),
                                      ),
                                    ),
                                  ],
                                ),
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
        ),
      ),
    );
  }

  Future<void> getDetails() async {
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
        "/api/members.php?member_id=" +
        GlobalVariable.member_id);
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getDetails->' + data.toString());
      for (Map i in jsonDecode(json)) {
        setState(() {
          dataMemDe.add(DataMemberDetails.fromJson(i));
        });
      }
      setState(() {});
    } else {
      await pr.hide();
      print('getDetails->error');
      throw Exception('Failed to load album');
    }
  }

// void launchWhatsApp(
//     {@required String phone,
//       @required String message,
//     }) async {
//   String url() {
//     if (Platform.isIOS) {
//       return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
//     } else {
//       return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
//     }
//   }
//
//   if (await canLaunch(url())) {
//     await launch(url());
//   } else {
//     throw 'Could not launch ${url()}';
//   }
// }

}
