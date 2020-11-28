import 'package:flutter/material.dart';

import 'customcolor.dart';
void main(){
  runApp(AddLisitingScreen());
}
class AddLisitingScreen extends StatefulWidget {
  @override
  _AddLisitingScreenState createState() => _AddLisitingScreenState();
}

class _AddLisitingScreenState extends State<AddLisitingScreen> {
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
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
                        height: 30,
                        width: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 10),
                    child: Text(
                      'Enter Property Details',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 3,color: GlobalVariable.grey_main_,),
            Expanded(
              child: ListView(
                shrinkWrap: true,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Vijayawada',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),
                              Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Vijayawada',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),
                              Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/location.png',height: 35,width: 50,),
                            Text('Location',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                //propertyType
                  Row(
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 10),
                      //     padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                      //
                      //     // color: GlobalVariable.grey_main,
                      //     child: Row(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text('Open Plots',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Open Plots',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 15),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('Appartments',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Group Houses',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Independent\nHouses/Villas',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Commerical',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                      //     margin: EdgeInsets.only(left: 5,right: 10),
                      //
                      //     // color: GlobalVariable.grey_main,
                      //     child:  Row(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text('Independent\nHouses/Villas',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/propertytype.png',height: 35,width: 50,),
                            Text('Property\nType',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //bhk
                  Row(
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     margin: EdgeInsets.only(left: 10),
                      //     padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                      //
                      //     // color: GlobalVariable.grey_main,
                      //     child: Row(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text('Open Plots',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('1BHK',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15,),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('3BHK',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('2BHK',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('4BHK',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                      //     margin: EdgeInsets.only(left: 5,right: 10),
                      //
                      //     // color: GlobalVariable.grey_main,
                      //     child:  Row(
                      //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Image.asset('drawable/tieunchecked.png',height: 15,width: 15,),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text('Independent\nHouses/Villas',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 11,right: 10,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/bhk_one.png',height: 35,width: 50,),
                            Text('BHK',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //area
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          // color: GlobalVariable.grey_main,
                          child: Column(
                            children: [
                              Slider(
                                min: 0,
                                max: 1000,
                                value: _value,
                                divisions: 1000,
                                activeColor: GlobalVariable.yellow_main,
                                // inactiveColor: GlobalVariable.yellow_main,
                                label: '$_value',
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                    // print('sliderValue'+value.toString());
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15),
                                child: Row(
                                  children: [
                                    Text('0'
                                      ,style: TextStyle(fontFamily: GlobalVariable.Gotham,color: GlobalVariable.blue_main),

                                    ),
                                    Spacer(),
                                    Text('$_value'+' Sqft'
                                      ,style: TextStyle(fontFamily: GlobalVariable.Gotham,color: GlobalVariable.blue_main),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 11,right: 10,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/area_one.png',height: 35,width: 50,),
                            Text('Area',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Posession
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Property Age
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Facing
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Furnished
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //parking
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Packages
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 1,color: GlobalVariable.grey_main_,),
                  //Description
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 25,bottom: 25),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('drawable/propery_type_rupee_syembol.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                              Text('Enter Selling Price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          margin: EdgeInsets.only(left: 5,top: 25,bottom: 25,right: 10),

                          color: GlobalVariable.grey_main,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text('Commission at final price',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham,fontSize: 10),),
                              // Image.asset('drawable/down_arr.png',height: 10,width: 10,color: GlobalVariable.blue_main,),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 9,top: 20,bottom: 20),
                        color: GlobalVariable.yellow_main,
                        child: Column(
                          children: [
                            Image.asset('drawable/budget.png',height: 35,width: 50,),
                            Text('Budget',style: TextStyle(color: GlobalVariable.blue_main,fontFamily: GlobalVariable.Gotham),),

                          ],
                        ),
                      )
                    ],
                  ),
                  // Container(height: 1,color: GlobalVariable.grey_main_,),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: GlobalVariable.blue_main,
                // borderRadius: BorderRadius.circular(10)
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    // Navigator.pushReplacement(
                    //   context,
                    //   new MaterialPageRoute(builder: (context) => ReferralCodeScreen()),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:15,bottom: 10),

                    child: Text(
                      "NEXT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
