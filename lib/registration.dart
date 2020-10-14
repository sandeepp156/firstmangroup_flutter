import 'package:firstmangroup_flutter/OTPVScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Registration());
}

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

TextEditingController phCntrl = new TextEditingController();

class _RegistrationState extends State<Registration> {
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
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: Text(
                      "Verify your Number",
                      style: TextStyle(
                          fontFamily: GlobalVariable.Gotham,
                          color: GlobalVariable.text_colors_black,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 10, top: 15),
                          child: Text(
                            "+91",
                            style: TextStyle(
                                color: GlobalVariable.text_colors_black,
                                fontSize: 20),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: phCntrl,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: GlobalVariable.blue_main, fontSize: 20),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.only(bottom: -15, top: 0.0),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                  color: GlobalVariable.blue_main,
                                )
                                ),
                                // border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: GlobalVariable.grey_main,
                                    fontSize: 18),
                                hintText: 'Enter a Mobile Number'),
                          ),
                        ),
                        // Expanded(child: Text("")),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: GlobalVariable.blue_main,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          sendOtp(context);
                        },
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 30.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              child: Text(
                                "Get OTP",
                                style: TextStyle(
                                    fontFamily: GlobalVariable.GothamMedium,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "assets/rightarrow.png",
                                color: Colors.white,
                              ),
                            )
                          ],
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

  sendOtp(BuildContext context) {
    if (phCntrl.text.toString() == "") {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: Text('Enter Mobile Number')));
    } else if (phCntrl.text.toString().length < 10) {
      Scaffold.of(context).showSnackBar(
          new SnackBar(content: Text('Enter valid Mobile Number')));
    } else {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => OTPVScreen(text:phCntrl.text.toString())),
      );
    }
  }
}
