import 'package:flutter/material.dart';

import 'customcolor.dart';
void main(){
  runApp(InviteFMScreen());
}
class InviteFMScreen extends StatefulWidget {
  @override
  _InviteFMScreenState createState() => _InviteFMScreenState();
}

class _InviteFMScreenState extends State<InviteFMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Container(
          color: GlobalVariable.white,
          child: Column(
            children: [
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
                          // color: GlobalVariable.white,
                          height: 30,
                          width: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 10),
                      child: Text(
                        'Invite FM',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset('drawable/bnner1.png',height: 175,width: double.infinity,fit: BoxFit.fill,),
              Card(

                child: Column(
                  children: [
                    Text('Your Referral Code is',style: TextStyle(fontSize: 18,color: GlobalVariable.blue_main,fontFamily: GlobalVariable.GothamMedium),),
                    Text('FM181002004',style: TextStyle(fontSize: 16,color: GlobalVariable.yellow_main,fontFamily: GlobalVariable.GothamMedium),),

                  ],
                ),
              ),
              Card(

                child: Text('Your Referral Code is',style: TextStyle(fontSize: 14,color: GlobalVariable.blue_main,fontFamily: GlobalVariable.GothamMedium),),
              ),

              Spacer(),
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                color: GlobalVariable.blue_main,
                child: Center(child:                    Text('INVITE',style: TextStyle(fontSize: 16,color: GlobalVariable.yellow_main,fontFamily: GlobalVariable.GothamMedium),),
                    ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
