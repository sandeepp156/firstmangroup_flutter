import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'customcolor.dart';

void main() {
  runApp(ProjectPartnerScreen());
}

class ProjectPartnerScreen extends StatefulWidget {
  @override
  _ProjectPartnerScreenState createState() => _ProjectPartnerScreenState();
}

final List<DataQues> dataQues = new List<DataQues>();

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();

int length, name_length, pname_length;
var j, pj;
List<String> gotItems = new List<String>();
List<String> ids = new List<String>();
double smt_btn_padding = 15.0;
bool yesOne = false,
    yesTwo = false,
    yesThree = false,
    yesFour = false,
    yesFive = false;
int pos__;

class _ProjectPartnerScreenState extends State<ProjectPartnerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // appbar
            Container(
              alignment: Alignment.centerLeft,
              // height: 45,
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
                      'Partnership Details',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: GlobalVariable.text_colors_black,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              margin: EdgeInsets.only(top: 3),
              width: double.infinity,
              color: GlobalVariable.blue_main,
              child: Text(
                'Check your Partnership Eligilibility',
                style: TextStyle(
                    // backgroundColor: GlobalVariable.blue_main,
                    color: GlobalVariable.yellow_main,
                    fontFamily: GlobalVariable.Gotham,
                    fontSize: 16),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                // height: 300,
                margin: EdgeInsets.only(left: 15, right: 10, bottom: 25),
                child: dataQues.length==0?Center(child: Text('loading')):Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + dataQues[0].id + '.' + dataQues[0].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesOne = !yesOne;
                                      // ids.add(dataQues[pos].id);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesOne
                                            ? 'drawable/checkon1.png'
                                            : 'drawable/tieunchecked.png',
                                        height: 20,
                                        width: 25,
                                      ),
                                      Text(
                                        '  Yes  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesOne=!yesOne;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesOne?'drawable/tieunchecked.png':'drawable/checkon1.png',
                                        height: 20,
                                      ),
                                      Text(
                                        '  No  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + dataQues[1].id + '.' + dataQues[1].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesTwo = !yesTwo;
                                      // ids.add(dataQues[pos].id);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesTwo
                                            ? 'drawable/checkon1.png'
                                            : 'drawable/tieunchecked.png',
                                        height: 20,
                                        width: 25,
                                      ),
                                      Text(
                                        '  Yes  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesTwo=!yesTwo;

                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesTwo?'drawable/tieunchecked.png':'drawable/checkon1.png'                                        ,
                                        height: 20,
                                      ),
                                      Text(
                                        '  No  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + dataQues[2].id + '.' + dataQues[2].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesThree = !yesThree;
                                      // ids.add(dataQues[pos].id);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesThree
                                            ? 'drawable/checkon1.png'
                                            : 'drawable/tieunchecked.png',
                                        height: 20,
                                        width: 25,
                                      ),
                                      Text(
                                        '  Yes  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesThree=!yesThree;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesThree?'drawable/tieunchecked.png':'drawable/checkon1.png'                                        ,
                                        height: 20,
                                      ),
                                      Text(
                                        '  No  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + dataQues[3].id + '.' + dataQues[3].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesFour = !yesFour;
                                      // ids.add(dataQues[pos].id);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesFour
                                            ? 'drawable/checkon1.png'
                                            : 'drawable/tieunchecked.png',
                                        height: 20,
                                        width: 25,
                                      ),
                                      Text(
                                        '  Yes  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesFour=!yesFour;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesFour?'drawable/tieunchecked.png':'drawable/checkon1.png'                                        ,
                                        height: 20,
                                      ),
                                      Text(
                                        '  No  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '' + dataQues[4].id + '.' + dataQues[4].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: GlobalVariable.blue_main,
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, left: 15),
                            child: Row(
                              children: [
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,

                                  onTap: () {
                                    setState(() {
                                      yesFive= !yesFive;
                                      // ids.add(dataQues[pos].id);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesFive
                                            ? 'drawable/checkon1.png'
                                            : 'drawable/tieunchecked.png',
                                        height: 20,
                                        width: 25,
                                      ),
                                      Text(
                                        '  Yes  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                InkWell(
                                  splashColor: GlobalVariable.blue_main,
                                  onTap: () {
                                    setState(() {
                                      yesFive=!yesFive;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        yesFive?'drawable/tieunchecked.png':'drawable/checkon1.png'   ,
                                        height: 20,
                                      ),
                                      Text(
                                        '  No  ',
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily: GlobalVariable.Gotham,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            // SizedBox(height: 25,),

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Conditions',
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                        color: GlobalVariable.red,
                        fontFamily: GlobalVariable.Gotham,
                        fontSize: 12),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: GlobalVariable.red,
                        size: 15,
                      ),
                      Text(
                        'Project Director to build a team of four FM partners',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.Gotham,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: GlobalVariable.red,
                        size: 15,
                      ),
                      Text(
                        'Selected four FM partners need to have a active FM team',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.Gotham,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: GlobalVariable.red,
                        size: 15,
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text:
                                'After successful closing of project, Project\nDirector recieves ',
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 10)),
                        TextSpan(
                            text: 'attractive profit\n share ',
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                fontSize: 10,
                                color: GlobalVariable.yellow_main)),
                        TextSpan(
                            text: 'on his closed project',
                            style: TextStyle(
                                fontFamily: GlobalVariable.Gotham,
                                color: GlobalVariable.blue_main,
                                fontSize: 10)),
                      ]))
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),
            AnimatedContainer(
              width: double.infinity,
              decoration: BoxDecoration(
                color: GlobalVariable.blue_main,
                // borderRadius: BorderRadius.circular(10)
              ),
              duration: Duration(milliseconds: 10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: GlobalVariable.white,
                  onTap: () {
                    sendAns();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getQuestions() async {
    dataQues.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Please wait',
      progressWidget: Platform.isIOS
          ? CupertinoActivityIndicator()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
    );
    await pr.show();

    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/questions.php");

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('getData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataQues.add(DataQues.fromJson(i));
        }
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getData->error');

      throw Exception('Failed to load album');
    }
  }
  Future<void> sendAns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: 'Please wait',
      progressWidget: Platform.isIOS
          ? CupertinoActivityIndicator()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
    );
    await pr.show();

    var ansJson = [
      {
        'question': '1',
        'answer':yesOne==true?'1':'2'
      },
      {
        'question': '2',
        'answer':yesTwo==true?'1':'2'
      },
      {
        'question': '3',
        'answer':yesThree==true?'1':'2'
      },
      {
        'question': '4',
        'answer':yesFour==true?'1':'2'
      },
      {
        'question': '5',
        'answer':yesFive==true?'1':'2'
      }
    ];

    var queryPrams = {
      'member_id':''+prefs.getString('member_id'),
      'json':''+ansJson.toString()
    };
    print(queryPrams.toString());
    print(ansJson.toString());

    // final response = await http
    //     .get("https://" + GlobalVariable.BASE_URL + "/api/member_questions.php",headers: queryPrams);
    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/member_questions.php', queryPrams);
    print(uri);
    Response response = await post(uri);
    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      print('getData->' + data.toString());
      Map<String, dynamic> map = jsonDecode(json);
      if(map['status']=='Success'){
        Navigator.pop(context);
      }


    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getData->error');

      throw Exception('Failed to load album');
    }
  }
}

class DataQues {
  String id;
  String title;

  DataQues({this.id, this.title});

  factory DataQues.fromJson(Map<String, dynamic> json) {
    return DataQues(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
//[{"question":"1","answer":"1"},{"question":"2","answer":"1"},{"question":"3","answer":"1"},{"question":"4","answer":"1"},{"question":"5","answer":"2"}]
