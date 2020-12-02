import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(LeadDetailsScreen());
}

class LeadDetailsScreen extends StatefulWidget {
  @override
  _LeadDetailsScreenState createState() => _LeadDetailsScreenState();
}

bool salaried = false;
bool yes = false;
bool siteVisityes = false;

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
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
                        'Lead Details',
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
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
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
                                hintText: 'Lead Name'),
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
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
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
                                hintText: 'Contact Number'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(left: 20),
                    color: GlobalVariable.white,
                    child: Row(
                      children: [
                        // Text(
                        //   '*',
                        //   style: TextStyle(
                        //       color: GlobalVariable.red,
                        //       fontFamily: GlobalVariable.GothamMedium),
                        // ),
                        Flexible(
                          child: TextField(
                            // controller: fnameCtrl,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
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
                                hintText: 'Lead Email'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(right: 15),
                    color: GlobalVariable.white,
                    child: Row(
                      children: [
                        Expanded(
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
                                'City',
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.Gotham),
                              )
                              // Flexible(
                              //   child: TextField(
                              //     // controller: fnameCtrl,
                              //     maxLength: 10,
                              //     keyboardType: TextInputType.phone,
                              //     style: TextStyle(
                              //         fontFamily: GlobalVariable.Gotham,
                              //         color: GlobalVariable.blue_main,
                              //         fontSize: 14),
                              //     decoration: InputDecoration(
                              //         counterText: "",
                              //         contentPadding:
                              //             EdgeInsets.only(top: -5.0),
                              //         enabledBorder: InputBorder.none,
                              //         border: InputBorder.none,
                              //         hintStyle: TextStyle(
                              //             fontFamily: GlobalVariable.Gotham,
                              //             color: GlobalVariable.grey_main_,
                              //             fontSize: 14),
                              //         hintText: 'City'),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'City',
                                  style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'drawable/down_arr.png',
                                color: GlobalVariable.text_colors_black,
                                height: 7,
                                width: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(right: 15),
                    color: GlobalVariable.white,
                    child: Row(
                      children: [
                        Expanded(
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
                                'Loan Requested for',
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.Gotham),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Loan Leads',
                                  style: TextStyle(
                                      color: GlobalVariable.text_colors_black,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ),
                              Image.asset(
                                'drawable/down_arr.png',
                                color: GlobalVariable.text_colors_black,
                                height: 7,
                                width: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(right: 15),
                    color: GlobalVariable.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Loan Type',
                                  style: TextStyle(
                                      color: GlobalVariable.text_colors_black,
                                      fontFamily: GlobalVariable.Gotham),
                                ),
                              ),
                              Image.asset(
                                'drawable/down_arr.png',
                                color: GlobalVariable.text_colors_black,
                                height: 7,
                                width: 13,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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
                                  // controller: fnameCtrl,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      fontFamily: GlobalVariable.Gotham,
                                      color: GlobalVariable.blue_main,
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.only(top: -5.0),
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontFamily: GlobalVariable.Gotham,
                                          color: GlobalVariable.grey_main_,
                                          fontSize: 14),
                                      hintText: 'Budget'),
                                ),
                              ),
                            ],
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
                        Text(
                          'Bank Name',
                          style: TextStyle(
                              color: GlobalVariable.text_colors_black,
                              fontFamily: GlobalVariable.Gotham),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(right: 15),
                    color: GlobalVariable.white,
                    child: Row(
                      children: [
                        Expanded(
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
                                'Location',
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.Gotham),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Select Area',
                                  style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                  ),
                                ),
                              ),
                              Image.asset(
                                'drawable/down_arr.png',
                                color: GlobalVariable.text_colors_black,
                                height: 7,
                                width: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7),
                    color: GlobalVariable.white,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              salaried = salaried ? false : true;
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                salaried
                                    ? 'drawable/radio_on.png'
                                    : 'drawable/radio_off.png',
                                height: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Salaried',
                                  style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              salaried = salaried ? false : true;
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                salaried
                                    ? 'drawable/radio_off.png'
                                    : 'drawable/radio_on.png',
                                height: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Not Salaried',
                                  style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
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
                    margin: EdgeInsets.only(top: 7),
                    padding: EdgeInsets.only(top: 5,bottom: 10),
                    color: GlobalVariable.white,
                    child: Column(
                      children: [
                        Row(
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
                              'RM Support Required',
                              style: TextStyle(
                                  color: GlobalVariable.text_colors_black,
                                  fontFamily: GlobalVariable.Gotham),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    yes = yes ? false : true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      yes
                                          ? 'drawable/radio_on.png'
                                          : 'drawable/radio_off.png',
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'YES',
                                        style: TextStyle(
                                          color: GlobalVariable.text_colors_black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    yes = yes ? false : true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      yes
                                          ? 'drawable/radio_off.png'
                                          : 'drawable/radio_on.png',
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'NO',
                                        style: TextStyle(
                                          color: GlobalVariable.text_colors_black,
                                        ),
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
                  Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.only(top: 7),
                      padding: EdgeInsets.only(top: 5,bottom: 10),
                      color: GlobalVariable.white,
                      child: Column(
                        children: [
                          Row(
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
                                'Site Visit Required',
                                style: TextStyle(
                                    color: GlobalVariable.text_colors_black,
                                    fontFamily: GlobalVariable.Gotham),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      siteVisityes = siteVisityes ? false : true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        siteVisityes
                                            ? 'drawable/radio_on.png'
                                            : 'drawable/radio_off.png',
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'YES',
                                          style: TextStyle(
                                            color: GlobalVariable.text_colors_black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      siteVisityes = siteVisityes ? false : true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        siteVisityes
                                            ? 'drawable/radio_off.png'
                                            : 'drawable/radio_on.png',
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'NO',
                                          style: TextStyle(
                                            color: GlobalVariable.text_colors_black,
                                          ),
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
                  ),
                ],
              )),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                color: GlobalVariable.blue_main,
                child: Center(
                    child: Text(
                  'SUBMIT',
                  style: TextStyle(
                      color: GlobalVariable.yellow_main, fontSize: 18),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
