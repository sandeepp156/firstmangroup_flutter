import 'package:flutter/material.dart';

import 'customcolor.dart';
void main() {
  runApp(TrackLeadsScreen());
}
class TrackLeadsScreen extends StatefulWidget {
  @override
  _TrackLeadsScreenState createState() => _TrackLeadsScreenState();
}

class _TrackLeadsScreenState extends State<TrackLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // alignment: Alignment.centerLeft,
              height: 45,
              child: Row(
                children: [
                  Image.asset(
                    'drawable/back_black.png',
                    height: 30,
                    width: 40,
                  ),
                  Text(
                    'Leads',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontFamily: GlobalVariable.GothamMedium,
                        fontSize: 18),
                  ),

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
                            'RealEstate Leads',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: GlobalVariable.GothamMedium,color: GlobalVariable.white,fontSize: 13),),
                        ),
                      ),
                      Container(color: GlobalVariable.grey_main_,width: 2,height: 35,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),

                          color: GlobalVariable.white,
                          child: Text('Loan Leads',
                            textAlign: TextAlign.center,style: TextStyle(fontFamily: GlobalVariable.GothamMedium,fontSize: 13),),
                        ),
                      ),
                      Container(color: GlobalVariable.grey_main_,width: 2,height:  35,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),

                          color: GlobalVariable.white,
                          child: Text('Insurance Leads',
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

          ],
        ),
      ),
    );
  }
}
