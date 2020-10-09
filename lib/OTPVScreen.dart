import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ReferralCodeScreen.dart';

void main() {
  runApp(OTPVScreen());
}

class OTPVScreen extends StatefulWidget {
  final String text;
  OTPVScreen({this. text});

  @override
  _OTPVScreenState createState() => _OTPVScreenState();
}

TextEditingController
                      oneCntrl = new TextEditingController(),
                      twoCntrl = new TextEditingController(),
                      threeCntrl = new TextEditingController(),
                      fourCntrl = new TextEditingController(),
                      fiveCntrl = new TextEditingController(),
                      sixCntrl = new TextEditingController();

class _OTPVScreenState extends State<OTPVScreen> {
  final String text;
  _OTPVScreenState({this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    height: 45,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: RotatedBox(
                            quarterTurns: 90,
                            child: Image.asset('assets/right.png',color: GlobalVariable.grey_main_,scale: 3.5,),
                          ),
                        ),
                        Center(
                          child:
                          Text( "Enter the OTP sent to\n",style: TextStyle(fontFamily:GlobalVariable.Gotham,color: GlobalVariable.text_colors_black,fontSize: 13 )),
                        ),
                            Align(alignment: Alignment.bottomCenter,
                                child: Text( widget.text.toString(),style: TextStyle(fontFamily:GlobalVariable.Gotham,color: GlobalVariable.blue_main,fontSize: 13 )))

                      ],
                    ),
                  ),
                  Hero(
                    tag: 'bnner1',
                    child: Image.asset(
                      "assets/bnner1.png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 4,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, ),
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(
              fontFamily:GlobalVariable.Gotham,
                          color: GlobalVariable.text_colors_black,
                          fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      optTextFiled(),
                      optTextFiled1(),
                      optTextFiled2(),
                      optTextFiled3(),
                      optTextFiled4(),
                      optTextFiled5(),
                      // Expanded(child: Text("")),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,bottom: 7  ),
                    child:
                    Text('Didn\'t get the OTP ?',style: TextStyle(fontFamily: GlobalVariable.Gotham), ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Resend OTP',style: TextStyle(fontFamily: GlobalVariable.GothamMedium,color: Colors.pinkAccent), ),
                      Image.asset(
                        "assets/rightarrow.png",
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top:15,bottom: 10),
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        // borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {

                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => ReferralCodeScreen()),
                          );
                        },
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget optTextFiled(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: oneCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            fontFamily: GlobalVariable.Gotham,

            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(

            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                fontFamily: GlobalVariable.Gotham,

                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }
  Widget optTextFiled1(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: twoCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(
            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }
  Widget optTextFiled2(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: threeCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(

            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }
  Widget optTextFiled3(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: fourCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(

            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }
  Widget optTextFiled4(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: fiveCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(

            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }
  Widget optTextFiled5(){
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5),
      width: 27,
      child: TextField(
        textAlign: TextAlign.center,
        controller: sixCntrl,
        maxLength: 1,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: GlobalVariable.blue_main, fontSize: 14),
        decoration: InputDecoration(

            counterText: "",
            contentPadding:
            EdgeInsets.only(bottom: -25, top: 0.0),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                  color: GlobalVariable.blue_main,
                )),
            // border: InputBorder.none,
            hintStyle: TextStyle(
                color: GlobalVariable.grey_main,
                fontSize: 14),
            hintText: '*'),
      ),
    );
  }

}
