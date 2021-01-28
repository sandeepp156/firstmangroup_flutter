import 'package:firstmangroup_flutter/EventsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'customcolor.dart';

void main() {
  runApp(FAQScreen());
}

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}
final List<DataFaqs> dataFaqs = new List<DataFaqs>();

int isSelected = -1;

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getFaqs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                      'FAQ\'s',
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
              margin: EdgeInsets.only(bottom: 10),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: dataFaqs.length==0?0:dataFaqs.length,
                    itemBuilder: (context, pos) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = pos;
                          });
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          // color: GlobalVariable.white,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: GlobalVariable.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey[300])
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        parseHtmlString(dataFaqs[pos].title),
                                        style: TextStyle(
                                            color: GlobalVariable.blue_main,
                                            fontFamily:
                                                GlobalVariable.GothamMedium,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Spacer(),
                                    //isSelected != null && isSelected == pos ?'drawable/select_city_fill.png':'drawable/select_city.png'
                                    RotatedBox(
                                      quarterTurns: isSelected != null &&
                                              isSelected == pos
                                          ? 90
                                          : 0,
                                      child: Image.asset(
                                        'drawable/downarrow.png',
                                        width: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: isSelected != null && isSelected == pos
                                    ?true
                                    : false,
                                child: Container(
                                  // color: Colors.grey[300],
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),

                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey[300])
                                      ]),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          parseHtmlString(dataFaqs[pos].description),
                                          style: TextStyle(
                                              color: GlobalVariable.blue_main,
                                              fontFamily:
                                                  GlobalVariable.GothamMedium,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
  Future<void> getFaqs() async {
    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/faq.php");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);

      setState(() {
        for (Map i in jsonDecode(json)) {
          dataFaqs.add(DataFaqs.fromJson(i));
        }
      });

      print('getFaqs->' + data.toString());

    } else {

      print('getFaqs->error');

      throw Exception('Failed to load album');
    }
  }

}
class DataFaqs {
    String description;
    String id;
    String title;

    DataFaqs({this.description, this.id, this.title});

    factory DataFaqs.fromJson(Map<String, dynamic> json) {
        return DataFaqs(
            description: json['description'], 
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}