import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AddListingScreen.dart';
import 'DataCities.dart';
import 'customcolor.dart';

void main() {
  runApp(AddNewPropScreen());
}

class AddNewPropScreen extends StatefulWidget {
  @override
  _AddNewPropScreenState createState() => _AddNewPropScreenState();
}

int count = 0;
var propjson;
final List<DataCities> dataCities = new List<DataCities>();
final List<DataAreas> dataAreas = new List<DataAreas>();
List<PropertyData> dataProperty = new List<PropertyData>();
List<String> kkkkkkk = new List<String>();
bool myself = true;
bool cityPopup = false;
bool citysList = false;
// bool cityPopup = false;
String city = 'City', area = 'Area', cityid, areaid;
TextEditingController nameCtrl = new TextEditingController(),
    phoneCtrl = new TextEditingController(),
    firmNameCtrl = new TextEditingController()
// locationCtrl = new TextEditingController(),
// propertyCtrl = new TextEditingController(),
// cityCtrl = new TextEditingController()
    ;

List<TextEditingController> locationCtrl = new List();
List<TextEditingController> cityCtrl = new List();
List<TextEditingController> propertyCtrl = new List();
ScrollController _scrollController = new ScrollController();

class _AddNewPropScreenState extends State<AddNewPropScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    locationCtrl.clear();
    cityCtrl.clear();
    propertyCtrl.clear();
    firmNameCtrl.clear();
    phoneCtrl.clear();
    nameCtrl.clear();
    kkkkkkk.clear();
    propjson = '';
    count = 0;
    super.dispose();
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
                          'Add New Property',
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
                  color: GlobalVariable.grey_main,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 5),
                          margin: EdgeInsets.only(right: 10),
                          color: GlobalVariable.blue_main,
                          child: Text(
                            'I am subscribe for',
                            style: TextStyle(
                                color: GlobalVariable.yellow_main,
                                fontFamily: GlobalVariable.GothamMedium,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              myself = true;
                            });
                          },
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                myself == true
                                    ? 'drawable/tiechecked.png'
                                    : 'drawable/tieunchecked.png',
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Myself',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              myself = false;
                            });
                          },
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                myself == false
                                    ? 'drawable/tiechecked.png'
                                    : 'drawable/tieunchecked.png',
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Someone else',
                                  style: TextStyle(
                                      color: GlobalVariable.blue_main,
                                      fontFamily: GlobalVariable.Gotham,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: GlobalVariable.grey_main,
                    child: Column(
                      //d
                      children: [
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(bottom: 5),
                          color: GlobalVariable.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                      color: GlobalVariable.red,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: nameCtrl,
                                  // maxLength: 10,
                                  // keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main,
                                      fontSize: 14),
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
                                          fontSize: 14),
                                      hintText: 'Enter name'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(bottom: 5),
                          color: GlobalVariable.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                      color: GlobalVariable.red,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: phoneCtrl,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main,
                                      fontSize: 14),
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
                                          fontSize: 14),
                                      hintText: 'Enter Contact Number'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.only(bottom: 5),
                          color: GlobalVariable.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                      color: GlobalVariable.red,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: firmNameCtrl,
                                  // maxLength: 10,
                                  // keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main,
                                      fontSize: 14),
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
                                          fontSize: 14),
                                      hintText: 'Enter Firm name'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          padding:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          color: GlobalVariable.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  '*',
                                  style: TextStyle(
                                      color: GlobalVariable.red,
                                      fontFamily: GlobalVariable.GothamMedium),
                                ),
                              ),
                              Text(
                                'Select Number of Properties',
                                style: TextStyle(
                                    fontFamily: GlobalVariable.Gotham,
                                    color: GlobalVariable.blue_main,
                                    fontSize: 14),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (count == 0) {
                                      // locationCtrl[].clear();
                                      // propertyCtrl.clear();
                                      // cityCtrl.clear();
                                      propjson = '';
                                      kkkkkkk.clear();
                                      print('afterkkkk'+kkkkkkk.toString());

                                    } else {
                                      count = count - 1;
                                      kkkkkkk.removeAt(count-1);

                                    }
                                  });
                                },
                                child: Container(
                                  color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        color: GlobalVariable.yellow_main),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                color: GlobalVariable.blue_main,
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(
                                      color: GlobalVariable.yellow_main),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    count = count + 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  color: Colors.grey,
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        color: GlobalVariable.yellow_main),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: count == 0 ? true : false,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 5, right: 2),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10),
                                  color: GlobalVariable.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, left: 15),
                                              child: Text(
                                                '*',
                                                style: TextStyle(
                                                    color: GlobalVariable.red,
                                                    fontFamily: GlobalVariable
                                                        .GothamMedium),
                                              ),
                                            ),
                                            Text(
                                              'City',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            getCitiesData();
                                            setState(() {
                                              cityPopup = true;
                                              citysList = true;
                                            });
                                          },
                                          child: Text(
                                            city,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: GlobalVariable.blue_main,
                                                fontSize: 12,
                                                fontFamily:
                                                    GlobalVariable.Gotham),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 5, left: 2),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10),
                                  color: GlobalVariable.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, left: 15),
                                              child: Text(
                                                '*',
                                                style: TextStyle(
                                                    color: GlobalVariable.red,
                                                    fontFamily: GlobalVariable
                                                        .GothamMedium),
                                              ),
                                            ),
                                            Text(
                                              'Location',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              cityPopup = true;
                                              citysList = false;
                                            });
                                          },
                                          child: Text(
                                            area,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: GlobalVariable.blue_main,
                                                fontSize: 12,
                                                fontFamily:
                                                    GlobalVariable.Gotham),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: count == 0 ? false : true,
                            child: Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: count,
                                    itemBuilder: (context, pos) {
                                      propertyCtrl
                                          .add(new TextEditingController());
                                      locationCtrl
                                          .add(new TextEditingController());
                                      cityCtrl.add(new TextEditingController());
                                      return Container(
                                        color: GlobalVariable.blue_main,
                                        padding: EdgeInsets.only(
                                            left: 15, top: 5, bottom: 5),
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Enter Project Name : ',
                                                    style: TextStyle(
                                                        color: GlobalVariable
                                                            .white,
                                                        fontFamily:
                                                            GlobalVariable
                                                                .GothamMedium,
                                                        fontSize: 14),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          propertyCtrl[pos],
                                                      // controller: propertyCtrl,

                                                      style: TextStyle(
                                                          fontFamily:
                                                              GlobalVariable
                                                                  .Gotham,
                                                          color: GlobalVariable
                                                              .white,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        // counterText: "",
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 18.5,
                                                                top: 0.0),

                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'City : ',
                                                          style: TextStyle(
                                                              color:
                                                                  GlobalVariable
                                                                      .white,
                                                              fontFamily:
                                                                  GlobalVariable
                                                                      .GothamMedium,
                                                              fontSize: 14),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                cityCtrl[pos],
                                                            // maxLength: 10,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    GlobalVariable
                                                                        .Gotham,
                                                                color:
                                                                    GlobalVariable
                                                                        .white,
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              // counterText: "",
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom:
                                                                          18.5,
                                                                      top: 0.0),

                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Location : ',
                                                          style: TextStyle(
                                                              color:
                                                                  GlobalVariable
                                                                      .white,
                                                              fontFamily:
                                                                  GlobalVariable
                                                                      .GothamMedium,
                                                              fontSize: 14),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                locationCtrl[
                                                                    pos],
                                                            // maxLength: 10,
                                                            // keyboardType:
                                                            //     TextInputType.phone,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    GlobalVariable
                                                                        .Gotham,
                                                                color:
                                                                    GlobalVariable
                                                                        .white,
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              // counterText: "",
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom:
                                                                          18.5,
                                                                      top: 0.0),
                                                              border:
                                                                  InputBorder
                                                                      .none,
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
                                    }))),
                        Visibility(
                            visible: count == 0 ? true : false,
                            child: Spacer()),
                        InkWell(
                          onTap: () {
                            // if (count > 0 || count == 1) {
                            //   setPropJson();
                            //   _scrollController.animateTo(
                            //     0.0,
                            //     curve: Curves.easeOut,
                            //     duration: const Duration(milliseconds: 300),
                            //   );
                            // } else if(count==0) {
                            //   addNewProp(count);
                            //
                            // }

                            if (count == 0) {
                              addNewProp(count);
                            } else {
                              setPropJson();
                              _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            color: GlobalVariable.blue_main,
                            child: Center(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                  color: GlobalVariable.yellow_main,
                                  fontFamily: GlobalVariable.Gotham,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: cityPopup,
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cityPopup = false;
                    });
                  },
                  child: Container(
                    color: GlobalVariable.grey_main.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        top: 50, bottom: 50, left: 15, right: 15),
                    child: Center(
                      child:
                          // Expanded(
                          //   child:
                          dataCities.length == 0
                              ? Text('Please wait..')
                              : citysList == true
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: dataCities.length,
                                      itemBuilder: (context, pos) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              city = dataCities[pos].title;
                                              cityid = dataCities[pos].id;
                                              area = 'Area';
                                              // areaController.text = 'Area';
                                              areaid = '-1';
                                              getAreasData(cityid);
                                              cityPopup = false;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: GlobalVariable.white,
                                            margin: EdgeInsets.only(
                                                left: 25, right: 25),
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              dataCities[pos].title,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  fontSize: 16,
                                                  color:
                                                      GlobalVariable.blue_main),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 25, right: 25),
                                          height: 1,
                                          color: GlobalVariable.grey_main,
                                        );
                                      },
                                    )
                                  : SizedBox(
                                      height: 500,
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        itemCount: dataAreas.length,
                                        itemBuilder: (context, pos) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                area = dataAreas[pos].title;
                                                // areaController.text =
                                                //     dataAreas[pos].title;

                                                areaid = dataAreas[pos].id;
                                                cityPopup = false;
                                                // getAreasData(cityId);
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: GlobalVariable.white,
                                              margin: EdgeInsets.only(
                                                  left: 25, right: 25),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                dataAreas[pos].title,
                                                style: TextStyle(
                                                    fontFamily:
                                                        GlobalVariable.Gotham,
                                                    fontSize: 16,
                                                    color: GlobalVariable
                                                        .blue_main),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 25, right: 25),
                                            height: 1,
                                            color: GlobalVariable.grey_main,
                                          );
                                        },
                                      ),
                                    ),

                      // ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* void setDetails() {
    nameCtrl.text = widget.dataMemberDetails.fname;
    phoneCtrl.text = widget.dataMemberDetails.lname;
  }*/

  Future<void> addNewProp(int c) async {
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
    // await pr.show();

    print('kkkklength'+kkkkkkk.length.toString());
    /*  var e = jsonDecode(kkkkkkk.toString());
    setState(() {
      for (Map i in jsonDecode(e)) {
        dataProperty.add(PropertyData.fromJson(i));
      }
      print('DATAProp==='+dataProperty.toString());
    });*/
    var queryParameters = {
      'member_id': '' +prefs.getString('member_id'),
      'type': myself == true ? '1' : '2',
      'name': '' + nameCtrl.text.toString(),
      'phone': '' + phoneCtrl.text.toString(),
      'firm': '' + firmNameCtrl.text.toString(),
      'count': c == 0 ? '0' : '' + count.toString(),
      'city': c == 0 ? cityid : '',
      'area': c == 0 ? areaid : '',
      'properties': c != 0 ? kkkkkkk.toString() : '',
      // 'properties': c != 0 ?'[{property: tetst, city: tetst, location: tsts}]': '',
    };

    var json = {'json': '' + queryParameters.toString()};
    print(queryParameters.toString());
    // print(json.toString());

    // var uri = Uri.https(
    //     GlobalVariable.BASE_URL, '/api/property_info.php', json);
    // print(uri);
    // Response response = await get(uri);
  }

  Future<void> addNewProp_(int c) async {
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
      'type': myself == true ? '1' : '2',
      'name': '' + nameCtrl.text.toString(),
      'phone': '' + phoneCtrl.text.toString(),
      'firm': '' + firmNameCtrl.text.toString(),
      'count': c == 0 ? '0' : '' + count.toString(),
      'city': c == 0 ? cityid : '',
      'area': c == 0 ? areaid : '',
      'properties': c != 0 ? kkkkkkk.toString() : '',
      // 'properties': c != 0 ?'[{property: tetst, city: tetst, location: tsts}]': '',
    };

    var json = {'json': '' + queryParameters.toString()};
    print(queryParameters.toString());
    print(json.toString());

    var uri =
        Uri.https(GlobalVariable.BASE_URL, '/api/property_info.php', json);
    print(uri);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      String json = response.body;
      print('addNewProp->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      if (map['status'] == 'Success') {
      } else {
        print('addNewProp:status' + map['status']);
      }
    } else {
      await pr.hide();
      print('addNewProp->error');
      throw Exception('Failed to load album');
    }
  }

  void setPropJson() {
    // dataProperty.clear();

    // for (int i = 0; i < count; i++) {
    //   dataProperty.add(PropertyData(propertyCtrl[i].text.toString(),
    //       cityCtrl[i].text.toString(), locationCtrl[i].text.toString()));
    // }
    newJson();
    // print(dataProperty.toString());
    // print(dataProperty.length.toString());
  }

  void newJson() {
    // kkkkkkk.clear();
    if ( count == 1) {
      var propjson = jsonEncode({
        'property': '' + propertyCtrl[0].text.toString(),
        'city': '' + cityCtrl[0].text.toString(),
        'location': '' + locationCtrl[0].text.toString(),
      });
      if(kkkkkkk.length==0){
        kkkkkkk.insert(0,propjson.toString());
      }else{

      }
      print('sssssssss'+propjson.toString());

    } else if (count == 2) {
      var propjson1 = jsonEncode({
        'property': '' + propertyCtrl[1].text.toString(),
        'city': '' + cityCtrl[1].text.toString(),
        'location': '' + locationCtrl[1].text.toString(),
      });
      kkkkkkk.insert(1,propjson1);
      print('ssssssssss1ss'+propjson1.toString());
    } else if (count == 3) {
     var propjson3 = jsonEncode({
        'property': '' + propertyCtrl[2].text.toString(),
        'city': '' + cityCtrl[2].text.toString(),
        'location': '' + locationCtrl[2].text.toString(),
      });
      kkkkkkk.insert(2,propjson3);
     print('ssssssssss2ss'+propjson3.toString());

    } else if (count == 4) {
      var propjson4 = jsonEncode({
        'property': '' + propertyCtrl[3].text.toString(),
        'city': '' + cityCtrl[3].text.toString(),
        'location': '' + locationCtrl[3].text.toString(),
      });
      kkkkkkk.insert(3,propjson4);
    } else if (count == 5) {
     var propjson5 = jsonEncode({
        'property': '' + propertyCtrl[4].text.toString(),
        'city': '' + cityCtrl[4].text.toString(),
        'location': '' + locationCtrl[4].text.toString(),
      });
      kkkkkkk.insert(4,propjson5);
    } else if (count == 6) {
      var propjson6 = jsonEncode({
        'property': '' + propertyCtrl[5].text.toString(),
        'city': '' + cityCtrl[5].text.toString(),
        'location': '' + locationCtrl[5].text.toString(),
      });
      // kkkkkkk.add(propjson);
      kkkkkkk.insert(5,propjson6);

    } else if (count == 7) {
      var propjson7 = jsonEncode({
        'property': '' + propertyCtrl[6].text.toString(),
        'city': '' + cityCtrl[6].text.toString(),
        'location': '' + locationCtrl[6].text.toString(),
      });
      kkkkkkk.insert(6,propjson7);

      // kkkkkkk.add(propjson);
    } else if (count == 8) {
      var propjson8 = jsonEncode({
        'property': '' + propertyCtrl[7].text.toString(),
        'city': '' + cityCtrl[7].text.toString(),
        'location': '' + locationCtrl[7].text.toString(),
      });
      kkkkkkk.insert(7,propjson8);

      // kkkkkkk.add(propjson);
    } else if (count == 9) {
      var propjson9 = jsonEncode({
        'property': '' + propertyCtrl[8].text.toString(),
        'city': '' + cityCtrl[8].text.toString(),
        'location': '' + locationCtrl[8].text.toString(),
      });
      // kkkkkkk.add(propjson);
      kkkkkkk.insert(8,propjson9);

    } else if (count == 10) {
      var propjson10 = jsonEncode({
        'property': '' + propertyCtrl[9].text.toString(),
        'city': '' + cityCtrl[9].text.toString(),
        'location': '' + locationCtrl[9].text.toString(),
      });
      // kkkkkkk.add(propjson);
      kkkkkkk.insert(9,propjson10);

    }
    // kkkkkkk.add(propjson);
    // print('proJson===' + kkkkkkk.toString());

    // var j = json.decode(propjson);
    // print('[$j]');
    // var entireList = propjson.map((i)=>PropertyData.fromJson(i)).toList();

    addNewProp(count);
  }

  Future<void> getCitiesData() async {
    dataCities.clear();
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/cities.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataCities.add(DataCities.fromJson(i));
        }
      });
      print('getCities->' + data.toString());
    } else {
      print('getCities->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getAreasData(String cityID) async {
    dataAreas.clear();
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
    final response = await http.get(
        "https://" + GlobalVariable.BASE_URL + "/api/areas.php?city=" + cityID);
    if (response.statusCode == 200) {
      await pr.hide();
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataAreas.add(DataAreas.fromJson(i));
        }
      });
      //countInt
    } else {
      await pr.hide();
      print('getCategoryData_->error');
      throw Exception('Failed to load album');
    }
  }
}

class PropertyData {
  final String propName, propCity, propLoc;

  PropertyData({this.propName, this.propCity, this.propLoc});

  // PropertyData(this.propName, this.propCity, this.propLoc);
  // @override toString() => 'propName: $propName',;

  factory PropertyData.fromJson(Map<String, dynamic> json) {
    return new PropertyData(
      propName: json['property'],
      propLoc: json['location'],
      propCity: json['city'],
    );
  }
}
