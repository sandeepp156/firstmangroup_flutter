import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataMemberDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'customcolor.dart';

void main() {
  runApp(EditProfileScreen());
}

class EditProfileScreen extends StatefulWidget {
  final DataMemberDetails dataMemberDetails;

  EditProfileScreen({this.dataMemberDetails});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final DataMemberDetails dataMemberDetails;

  _EditProfileScreenState({this.dataMemberDetails});

  TextEditingController fnameCtrl = new TextEditingController(),
      lnameCtrl = new TextEditingController(),
      phoneCtrl = new TextEditingController(),
      emailCtrl = new TextEditingController(),
      aadharCtrl = new TextEditingController(),
      profCtrl = new TextEditingController(),
      addressCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //appbar
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
                      'Edit Profile',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 10),
                    child: Text(
                      // widget.dataMemberDetails. != 0 ? dataMemDe[0].code : '000',
                      widget.dataMemberDetails.code,
                      style: TextStyle(
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
              margin: EdgeInsets.only(bottom: 15),
            ),
            //content
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: Hero(
                      tag: 'usrImg',
                      child: Image.network(
                        widget.dataMemberDetails.image,
                        fit: BoxFit.cover,
                        height: 105,
                        width: 105,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 85, top: 65),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(40)),
                  height: 35,
                  width: 35,
                  child: Center(
                    child: Image.asset(
                      'drawable/edit_blue.png',
                      color: GlobalVariable.white,
                      // fit: BoxFit.cover,
                      height: 20, width: 20,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: fnameCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'First Name'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: lnameCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Last name'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        enabled: false,
                        controller: phoneCtrl,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Phone'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        enabled: false,
                        controller: emailCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Email'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        enabled: false,
                        controller: aadharCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Aadhar'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: profCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Profession'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Text(
                        '*',
                        style: TextStyle(
                            color: GlobalVariable.red,
                            fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: addressCtrl,
                        // maxLength: 10,
                        // keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontFamily: GlobalVariable.Gotham,
                            color: GlobalVariable.blue_main,
                            fontSize: 16),
                        decoration: InputDecoration(
                            counterText: "",
                            // contentPadding: EdgeInsets.only(bottom: -10, top: 0.0),
                            // enabledBorder: new UnderlineInputBorder(
                            //     borderSide: new BorderSide(
                            //       color: GlobalVariable.blue_main,
                            //     )),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.grey_main_,
                                fontSize: 16),
                            hintText: 'Address'),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  color: GlobalVariable.grey_main_,
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.grey[400],
              ),
            ),
            InkWell(
              onTap: () {
                updateProfile(); //edit-profile.php
              },
              child: Container(
                color: GlobalVariable.blue_main,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: GlobalVariable.yellow_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setDetails() {
    fnameCtrl.text = widget.dataMemberDetails.fname;
    lnameCtrl.text = widget.dataMemberDetails.lname;
    phoneCtrl.text = widget.dataMemberDetails.phone;
    emailCtrl.text = widget.dataMemberDetails.email;
    aadharCtrl.text = widget.dataMemberDetails.aadhar;
    profCtrl.text = widget.dataMemberDetails.profession;
    addressCtrl.text = widget.dataMemberDetails.address;
  }

  Future<void> updateProfile() async {
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
    var queryParameters = {
      'member_id': '' +prefs.getString('member_id'),
      'fname': '' + fnameCtrl.text.toString(),
      'lname': '' + lnameCtrl.text.toString(),
      'phone': '' + phoneCtrl.text.toString(),
      'email': '' + emailCtrl.text.toString(),
      'profession': profCtrl.text.toString(),
      'address': '' + addressCtrl.text.toString(),
      'aadhar': '' + aadharCtrl.text.toString(),
    };

    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/edit-profile.php', queryParameters);
    print(uri);
    Response response = await get(uri);
/*    // final response = await http
    //     .get("https://" + GlobalVariable.BASE_URL + "/api/inventory_sale.php");*/
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      print('updateProfile->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      if (map['status'] == 'Success') {
      } else {
        print('updateProfile:status' + map['status']);
      }

    } else {
      await pr.hide();
      print('updateProfile->error');
      throw Exception('Failed to load album');
    }
  }
}
