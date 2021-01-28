import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customcolor.dart';

void main() {
  runApp(BankAccScreen());
}

class BankAccScreen extends StatefulWidget {
  @override
  _BankAccScreenState createState() => _BankAccScreenState();
}

TextEditingController hnameCtrl = new TextEditingController(),
    accNumCtrl = new TextEditingController(),
    bankNameCtrl = new TextEditingController(),
    ifscCodeCtrl = new TextEditingController(),
    panCtrl = new TextEditingController(),
    addressCtrl = new TextEditingController();

bool img1=false,img2=false;

class _BankAccScreenState extends State<BankAccScreen> {
  final picker = ImagePicker();
  File _image1, _image2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.grey_main,
          child: Column(
            children: [
              //appBar
              Container(
                color: GlobalVariable.white,
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
                        'Bank Account',
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
                  child: ListView(
                children: [
                  Container(
                    // height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
                    color: GlobalVariable.white,
                    child: Text(
                      'Please fill below information to verfiy your account for commission payments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText: 'Enter A/C holder Name'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText: 'Enter A/C Number'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText: 'Bank And Branch Name'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText: 'IFSC Code'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText:
                                    'Enter Account Holder\'s Pan Card Number '),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    child: Row(
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
                            // controller: fnameCtrl,
                            // maxLength: 10,
                            // keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 14),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: -5.0),
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.grey_main_,
                                    fontSize: 14),
                                hintText: 'Enter Your Correspondence Address'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
                    color: GlobalVariable.white,
                    child: Column(
                      children: [
                        Text(
                          'Upload A/C Holder\'s Pancard And Cancelled Cheque',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: GlobalVariable.blue_main,
                              fontFamily: GlobalVariable.GothamMedium),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  getImage(0);
                                  setState(() {
                                    // img1=true;
                                  });
                                },
                                child: img1== false
                                    ? Image.asset(
                                        'drawable/upload.png',
                                        height: 60,
                                        width: 60,
                                      )
                                    : Container(
                                        height: 100,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(_image1))))),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  getImage(1);
                                  setState(() {
                                    // img2=true;
                                  });
                                },
                                child: img2== false
                                    ? Image.asset(
                                  'drawable/upload.png',
                                  height: 60,
                                  width: 60,
                                )
                                    : Container(
                                    height: 100,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(_image2))))
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
              InkWell(
                onTap: (){
                  sendBankDetails();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  color: GlobalVariable.blue_main,
                  child: Center(
                      child: Text(
                    'VERIFY',
                    style: TextStyle(
                        color: GlobalVariable.yellow_main, fontSize: 18),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(int id) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        // maxWidth: 500,
        imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        if (id == 0) {
          _image1 = File(pickedFile.path);
          print('image' + _image1.path);
          var str = _image1.path.toString().split('.');
          print('extension = ' + str[3].toString());
          img1=true;
        } else {
          _image2 = File(pickedFile.path);
          print('image' + _image2.path);
          var str = _image2.path.toString().split('.');
          print('extension = ' + str[3].toString());
          img2=true;
          // _image1.path.toString()
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> sendBankDetails() async {
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
    final bytes = File(_image1.path).readAsBytesSync();
    final bytes2 = File(_image2.path).readAsBytesSync();

    await pr.show();
    var queryParameters = {
      'member_id': '' + prefs.getString('member_id'),
      'name': '' + hnameCtrl.text.toString(),
      'ac_no': '' + accNumCtrl.text.toString(),
      'branch': '' + bankNameCtrl.text.toString(),
      'ifsc': '' + ifscCodeCtrl.text.toString(),
      'pancard_no': panCtrl.text.toString(),
      'address': '' + addressCtrl.text.toString(),
      'file': base64Encode(bytes),
      'file1':  base64Encode(bytes2),
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
        print('sendBankDetails:status' + map['status']);
      }

    } else {
      await pr.hide();
      print('sendBankDetails->error');
      throw Exception('Failed to load album');
    }
  }

}
