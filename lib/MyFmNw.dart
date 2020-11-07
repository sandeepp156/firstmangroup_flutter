import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(MyFmNwScreen());
}

class MyFmNwScreen extends StatefulWidget {
  @override
  _MyFmNwScreenState createState() => _MyFmNwScreenState();
}

class _MyFmNwScreenState extends State<MyFmNwScreen> {
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
                      Image.asset(
                        'drawable/back_black.png',
                        height: 30,
                        width: 40,
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
                        '233',
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
                      // controller: phCntrl,
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
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: ListView.builder(
                      itemCount: 15,
                        itemBuilder: (context, int) {
                      return Container(
                        color: GlobalVariable.white,
                        padding: EdgeInsets.only(left: 5, top: 10),
                        margin: EdgeInsets.only(left: 5,right: 5,top: 10),
                        height: 90,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'drawable/user.png',
                              width: 75,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('User',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Code : ',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham),
                                          ),
                                          Text('FM181000303 ',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: GlobalVariable.blue_main,
                                                  fontFamily:
                                                      GlobalVariable.Gotham)),
                                          Spacer(),
                                          Image.asset(
                                            'drawable/phone.png',
                                            height: 15,
                                            width: 20,
                                          ),
                                          Text('9898989898',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: GlobalVariable.blue_main,
                                                  fontFamily:
                                                  GlobalVariable.Gotham))

                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        //map
                                        Image.asset(
                                          'drawable/map.png',
                                          height: 15,
                                          width: 20,
                                        ),

                                        Text('Vijayawada',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham)),
                                        Spacer(
                                        ),

                                        Image.asset(
                                          'drawable/user_pro.png',
                                          height: 15,
                                          width: 20,
                                        ),
                                        Text('FM181000303',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                GlobalVariable.Gotham))

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 75,
                              color: Colors.green,
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
