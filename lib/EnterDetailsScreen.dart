import 'package:firstmangroup_flutter/DataEvents.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/material.dart';

import 'CitySelectScreen.dart';

void main() {
  runApp(EnterDetailsScreen());
}

class EnterDetailsScreen extends StatefulWidget {

  @override
  _EnterDetailsScreenState createState() => _EnterDetailsScreenState();
}

bool oneStar = true, twoStar = true, threeStar = true, fourStar = true;
bool advisor = false,
    builder = false,
    dev = false,
    emp = false,
    freel = false,
    othres = false,
    terms = false,
    popup = false;

class _EnterDetailsScreenState extends State<EnterDetailsScreen>
    with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    // _controller = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    // animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset(
                  'drawable/personal_page.png',
                  // height: MediaQuery.of(context).size.height/2.75,
                ),
                enterdetials(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: GlobalVariable.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => CitySelectScreen(),
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    decoration: BoxDecoration(
                      color: GlobalVariable.blue_main,
                      // borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "SUBMIT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            // cityPopup(),
            Visibility(
              visible:popup==true?true:false,
              child: AnimatedOpacity(
                  opacity: popup==true?1.0:0.0,
                  duration: Duration(milliseconds: 500),
                  child:
                  cityPopup()
              ),
            ),
            // SlideTransition(position: _animation, child: cityPopup())

          ],
        ),
      ),
    );
  }

  Widget enterdetials() {
    return Container(
      color: GlobalVariable.light_blue,
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          firstname(),
          lastname(),
          selectcity(),
          selectusertype(),
          gridview(),
          accept(),
        ],
      ),
    );
  }

  Widget accept() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 50),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                terms = terms ? false : true;
              });
            },
            child: Image.asset(
              terms
                  ? 'drawable/terms_checked.png'
                  : 'drawable/checkoff1.png', //checkoff1
              height: 20, width: 15,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'By logging in I agree to First Man Group ',
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamLight,
                          fontSize: 10)),
                  TextSpan(
                      text: 'Terms of service.',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: '\nPrivacy Policy',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        // decoration: TextDecoration.underline,
                        // decorationColor: GlobalVariable.yellow_main,
                      )),
                  TextSpan(
                      text: 'Content Policies',
                      style: TextStyle(
                        fontFamily: GlobalVariable.GothamLight,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                        decorationColor: GlobalVariable.yellow_main,
                      )),
                ]),
              )
              // Text(
              //   'By logging in I agree to First Man Group Terms of service.\nPrivacy Policy and Content Policies',
              //   style: TextStyle(color: GlobalVariable.white,fontSize: 10),
              // ),
              ),
        ],
      ),
    );
  }

  Widget firstname() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Visibility(
            visible: oneStar,
            child: Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextField(
            onChanged: (c) {
              if (c.length == null || c.length == 0) {
                setState(() {
                  oneStar = true;
                });
              } else {
                setState(() {
                  oneStar = false;
                });
              }
            },
            style: TextStyle(color: GlobalVariable.white),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                hintText: '  First name',
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                disabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                hintStyle: TextStyle(
                    color: GlobalVariable.white,
                    fontFamily: GlobalVariable.Gotham,
                    fontSize: 15)),
          )
        ],
      ),
    );
  }

  Widget lastname() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Visibility(
            visible: twoStar,
            child: Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextField(
            onChanged: (c) {
              if (c.length == null || c.length == 0) {
                setState(() {
                  twoStar = true;
                });
              } else {
                setState(() {
                  twoStar = false;
                });
              }
            },
            style: TextStyle(color: GlobalVariable.white),

            // cursorColor: GlobalVariable.white,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                hintText: '  Last name',
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                disabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                hintStyle: TextStyle(
                    color: GlobalVariable.white,
                    fontSize: 15,
                    fontFamily: GlobalVariable.Gotham)),
          )
        ],
      ),
    );
  }

  Widget selectcity() {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          setState(() {
            popup = popup==true ? false : true;

            // _controller.forward();
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: 30,
          width: double.infinity,
          child: Stack(
            children: [
              Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
              TextField(
                onChanged: (c) {
                  if (c.length == null || c.length == 0) {
                    setState(() {
                      threeStar = true;
                    });
                  } else {
                    setState(() {
                      threeStar = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                    hintText: '  Select city',
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.text_colors_black,
                    )),
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.white,
                    )),
                    disabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: GlobalVariable.text_colors_black,
                    )),
                    hintStyle: TextStyle(
                        color: GlobalVariable.white,
                        fontSize: 15,
                        fontFamily: GlobalVariable.Gotham)),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'drawable/down_arr.png',
                    height: 7,
                    width: 15,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectusertype() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Text(
            '*',
            style: TextStyle(color: Colors.red),
          ),
          TextField(
            onChanged: (c) {
              if (c.length == null || c.length == 0) {
                setState(() {
                  fourStar = true;
                });
              } else {
                setState(() {
                  fourStar = false;
                });
              }
            },
            decoration: InputDecoration(
                enabled: false,
                contentPadding: EdgeInsets.only(bottom: 15, top: 0.0),
                hintText: '  Select User Type',
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                disabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                  color: GlobalVariable.text_colors_black,
                )),
                hintStyle: TextStyle(
                    color: GlobalVariable.white,
                    fontSize: 15,
                    fontFamily: GlobalVariable.Gotham)),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'drawable/down_arr.png',
                height: 7,
                width: 15,
              )),
        ],
      ),
    );
  }

  Widget gridview() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png', ////terms_checked//checkoff1
                      height: 20, width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Advisor',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Builder',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Developer',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Employee',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'FreeLancer',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'drawable/checkoff1.png',
                      height: 20,
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Others',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.Gotham),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cityPopup() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Text('Select City'),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int pos) {
                    return Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                // print('clicked');
                                popup = popup==true ? false : true;
                                // _controller.reverse();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                'jfjf',
                              ),
                            )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
