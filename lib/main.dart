
import 'dart:ui';
import 'dart:async';

import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'initialpage.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MyApp()));
}
class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();

}

class _State extends State<MyApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser(context);

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Builder(builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              // print("tessstttttt");
              // // Navigator.pop(context);
              // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  Initial()),);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sp1.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Column(

                    children: [
                      new Flexible(child: Column(
                        children: [
                          Expanded(child: Text(""), flex: 1,),
                          new Text("Testing", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),),
                          Container(
                            // padding: EdgeInsets.only(top:10),
                            child: Image.asset(
                              "assets/sp3.png", height: 100, fit: BoxFit.fill,),
                          )
                        ],
                      ), flex: 1,),
                      new Flexible(child: Container(
                        padding: EdgeInsets.all(60),
                        child: Image.asset("assets/sp2.png", fit: BoxFit.fill,),
                      ), flex: 1,),
                    ],
                  ),
                )
              ],
            ),
          );
        }

        )
    );
  }

  Future<String> getUser(BuildContext context) async{
    Timer(Duration(seconds: 3),()=>
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) { return HomeScreen();}),));

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getString('member_id')!='-1'){
    //   Timer(Duration(seconds: 3),()=>
    //       Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>  HomeScreen()),));
    //
    // }
    // else if(prefs.getString('member_id')==null||prefs.getString('member_id')=='-1'){
    //   Timer(Duration(seconds: 3),()=>
    //       Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>  Initial()),));
    //
    // }
    // Timer(Duration(seconds: 3),()=>
    //     Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>  Initial()),));
    return "";
  }
}

