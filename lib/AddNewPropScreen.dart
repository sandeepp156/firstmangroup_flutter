import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(AddNewPropScreen());
}

class AddNewPropScreen extends StatefulWidget {
  @override
  _AddNewPropScreenState createState() => _AddNewPropScreenState();
}

int count = 0;

class _AddNewPropScreenState extends State<AddNewPropScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'drawable/tieunchecked.png',
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
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'drawable/tieunchecked.png',
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
                              // controller: lnameCtrl,
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
                              // controller: lnameCtrl,
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
                              // controller: lnameCtrl,
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
                                  hintText: 'Enter Firm name'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
                                } else {
                                  count = count - 1;
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
                              style:
                                  TextStyle(color: GlobalVariable.yellow_main),
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
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Guntur',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontSize: 12,
                                          fontFamily: GlobalVariable.Gotham),
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
                                              fontFamily: GlobalVariable.Gotham,
                                              color: GlobalVariable.blue_main,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Guntur',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: GlobalVariable.blue_main,
                                          fontSize: 12,
                                          fontFamily: GlobalVariable.Gotham),
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
                                itemCount: count,
                                itemBuilder: (context, pos) {
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
                                                    color: GlobalVariable.white,
                                                    fontFamily: GlobalVariable
                                                        .GothamMedium,
                                                    fontSize: 14),
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  // controller: lnameCtrl,
                                                  // maxLength: 10,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GlobalVariable.Gotham,
                                                      color:
                                                          GlobalVariable.white,
                                                      fontSize: 14),
                                                  decoration: InputDecoration(
                                                    // counterText: "",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 18.5,
                                                            top: 0.0),

                                                    border: InputBorder.none,
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
                                                          color: GlobalVariable
                                                              .white,
                                                          fontFamily:
                                                              GlobalVariable
                                                                  .GothamMedium,
                                                          fontSize: 14),
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        // controller: lnameCtrl,
                                                        // maxLength: 10,
                                                        keyboardType:
                                                            TextInputType.phone,
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
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Location : ',
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
                                                        // controller: lnameCtrl,
                                                        // maxLength: 10,
                                                        keyboardType:
                                                            TextInputType.phone,
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
                                                                  bottom: 18.5,
                                                                  top: 0.0),
                                                          border:
                                                              InputBorder.none,
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
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      width: double.infinity,
                      color: GlobalVariable.blue_main,
                      child: Center(child: Text('SUBMIT',style: TextStyle(color: GlobalVariable.yellow_main,fontFamily: GlobalVariable.Gotham,fontSize: 16,),),),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
