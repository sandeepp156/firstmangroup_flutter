import 'package:flutter/material.dart';

import 'customcolor.dart';

void main() {
  runApp(BannersScreen());
}

class BannersScreen extends StatefulWidget {
  @override
  _BannersScreenState createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Image.asset(
                          'drawable/app_icon.png',
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: RotatedBox(
                              quarterTurns: 90,
                              child: Image.asset('assets/right.png',color: GlobalVariable.white,scale: 3.5,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Chandan Valley',
                      style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.GothamMedium,fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: Text('Sarvana\'s',style: TextStyle(color: GlobalVariable.yellow_main,fontFamily: GlobalVariable.GothamMedium,fontSize: 12),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset('drawable/map_location.png',width: 20,height: 20,),
                              Text('Vijayawada'),

                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset('drawable/map_location.png',width: 20,height: 20,),
                              Text('Vijayawada'),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 5),
                    child: Row(
                      children: [
                        Image.asset('drawable/map_location.png',width: 20,height: 20,),
                        Text('Vijayawada'),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      children: [
                        Container(color: GlobalVariable.grey_main_,height: 2,),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                color: GlobalVariable.blue_main,
                                child: Text(
                                  'Property Options',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: GlobalVariable.GothamMedium,color: GlobalVariable.white,fontSize: 13),),
                              ),
                            ),
                            Container(color: GlobalVariable.grey_main_,width: 2,height: 35,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 10,bottom: 10),

                                color: GlobalVariable.white,
                                child: Text('Amenities',
                                  textAlign: TextAlign.center,style: TextStyle(fontFamily: GlobalVariable.GothamMedium,fontSize: 13),),
                              ),
                            ),
                            Container(color: GlobalVariable.grey_main_,width: 2,height:  35,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 10,bottom: 10),

                                color: GlobalVariable.white,
                                child: Text('Property Options',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: GlobalVariable.GothamMedium,fontSize: 13 ),),

                              ),
                            ),
                            // Container(color: GlobalVariable.grey_main_,height: 2,),

                          ],
                        ),
                        Container(color: GlobalVariable.grey_main_,height: 2,),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.black,
                    height: 200,
                  ),
                  Text('Price Trends',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 17),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),

                    // color: Colors.black,
                    height: 225,
                    child: Center(
                      child: Text('Graph',style: TextStyle(color: Colors.black),),
                    ),

                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(bottom: 10),

                    color: GlobalVariable.grey_main_,

                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 10),
                        child: Text('About',style: TextStyle(color: GlobalVariable.blue_main,fontSize: 16,fontFamily: GlobalVariable.GothamMedium),),
                      ),
                      Text('Chandan Valley'
                        ,style: TextStyle(color: GlobalVariable.yellow_main,fontSize: 16,fontFamily: GlobalVariable.GothamMedium),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 7),
                    child: Text('Description...'
                      ,style: TextStyle(color: GlobalVariable.blue_main,fontSize: 14,fontFamily: GlobalVariable.Gotham),

                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(bottom: 10,top: 10),

                    color: GlobalVariable.grey_main_,

                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 225,
                    child: Text('ListView',style: TextStyle(color: Colors.black),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: GlobalVariable.grey_main,
                    height: 300,
                    child: Text('MapView',style: TextStyle(color: Colors.black),),
                  ),
                  Container(
                    height: 50,
                  )

                  // Flexible(
                  //   // height: 150,
                  //   child: PageView(
                  //     children: [
                  //       Container(
                  //         height: 100,
                  //         color: GlobalVariable.blue_main,
                  //       ),
                  //       Container(
                  //         height: 150,
                  //         color: GlobalVariable.yellow_main,
                  //       ),
                  //       Container(
                  //         height: 75,
                  //         color: GlobalVariable.light_blue,
                  //       ),
                  //     ],
                  //   ),
                  // ),


                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: bottomMenu()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomMenu() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            color: GlobalVariable.blue_main,
            child: Text(
              'SUMBIT LEAD',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: GlobalVariable.GothamMedium,color: GlobalVariable.yellow_main,fontSize: 13),),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),

            color: GlobalVariable.yellow_main,
            child: Text('CALL',
              textAlign: TextAlign.center,style: TextStyle(fontFamily: GlobalVariable.GothamMedium,color: GlobalVariable.blue_main,fontSize: 13),),
          ),
        ),
        Expanded(
          child:
            // Image.asset('drawable/whatsapp_new.png',
            //   height: 30,
            //   fit: BoxFit.fill,
            //   // scale: 3,
            // ),
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),

            color: GlobalVariable.light_green,
            child: Text('',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: GlobalVariable.GothamMedium,fontSize: 13 ),),

          ),
        ),

      ],
    );
  }
}
