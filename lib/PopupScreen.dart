import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customcolor.dart';

void main() {
  runApp(PopupScreen());
}

class PopupScreen extends StatefulWidget {
  @override
  _PopupScreenState createState() => _PopupScreenState();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length, name_length, pname_length;
var j, pj;
String imgg = null;
List<String> gotItems = new List<String>();

class _PopupScreenState extends State<PopupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    img();
    Timer(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[700],
          child: ListView(
            children: [
              // appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(

                    margin: EdgeInsets.only(right: 10,top: 10),
                    child: IconButton(icon: Icon(Icons.close), onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      );
                    },
                    child: imgg == null
                        ? Container(
                            color: Colors.grey[700],
                          )
                        : Image.network(imgg,height: MediaQuery.of(context).size.height/1.2,)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> img() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String s = prefs.getString('settings');
    print('imagesssss===' + s);
    // String g= jsonDecode(s);
    Map<String, dynamic> map = jsonDecode(s);
    setState(() {
      imgg = map['popup_image'].toString();
    });
  }
}
