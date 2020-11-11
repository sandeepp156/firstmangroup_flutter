import 'package:flutter/material.dart';

import 'customcolor.dart';
void main(){
  runApp(MyAssistantScreen());
}
class MyAssistantScreen extends StatefulWidget {
  @override
  _MyAssistantScreenState createState() => _MyAssistantScreenState();
}

class _MyAssistantScreenState extends State<MyAssistantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Container(
          color: GlobalVariable.blue_main,
          child: Stack(
            children: [
              Image.asset('drawable/bnner1.png',height: 175,width: double.infinity,fit: BoxFit.fill,),
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
                      child: Image.asset('drawable/user_yellow.png',height: 100,
                        // width: double.infinity,
                        fit: BoxFit.fill,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      child:
                      Text('Name',style: TextStyle(fontSize: 26,color: GlobalVariable.white,fontFamily: GlobalVariable.GothamMedium),),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('About',
                        style: TextStyle(fontSize: 16,color: GlobalVariable.white,fontFamily: GlobalVariable.GothamMedium),),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      color: GlobalVariable.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('drawable/user_circle.png',height: 25,width: 25,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('About',
                                      style: TextStyle(fontSize: 16,color: GlobalVariable.blue_main,fontFamily: GlobalVariable.GothamMedium),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Container(width: 1,
                          color: GlobalVariable.blue_main,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('drawable/user_circle.png',height: 25,width: 25,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('About',
                                      style: TextStyle(fontSize: 16,color: GlobalVariable.blue_main,fontFamily: GlobalVariable.GothamMedium),),
                                  ),

                                ],
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
}
