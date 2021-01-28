import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/LeadDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'DataLoanDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(ApplyLoanScreen());
}

class ApplyLoanScreen extends StatefulWidget {
  final String id, title;

  ApplyLoanScreen({this.id, this.title});

  @override
  _ApplyLoanScreenState createState() => _ApplyLoanScreenState();
}

final List<DataLoanDetails> dataLoanDetails = new List<DataLoanDetails>();

class _ApplyLoanScreenState extends State<ApplyLoanScreen> {
  final String id, title;

  _ApplyLoanScreenState({this.id, this.title});

  @override
  void initState() {
    // TODO: implement initState
    getLoanData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalVariable.grey_main,
          child: Column(
            children: [
              //appBar
              Container(
                color: GlobalVariable.white,
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
                        'Apply ' + widget.title,
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: dataLoanDetails.length == 0
                          ? 0
                          : dataLoanDetails.length,
                      itemBuilder: (context, pos) {
                        return Container(
                          decoration: BoxDecoration(color: GlobalVariable.white,borderRadius: BorderRadius.circular(5)),

                          margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          // color: GlobalVariable.white,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: ,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: Image.network(
                                    dataLoanDetails[pos].image,
                                    height: 60,
                                    width: 80,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 65,
                                    width: 3,
                                    color: GlobalVariable.blue_main,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 3,
                                    color: GlobalVariable.yellow_main,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    dataLoanDetails[pos].title +
                                        '\n\n' +
                                        'ROI - ' +
                                        dataLoanDetails[pos].loans[int.parse(widget.id)-1].roi,
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LeadDetailsScreen(
                                          from: 'loan',
                                          id: '1',
                                          loanid: dataLoanDetails[pos].id,
                                          loanTitle :widget.title,
                                          bankName:dataLoanDetails[pos].title,
                                          bankId:dataLoanDetails[pos].id,
                                        )),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                  margin: EdgeInsets.only(right: 30,top: 20),
                                  decoration: BoxDecoration(color: GlobalVariable.yellow_main,borderRadius: BorderRadius.circular(5)),
                                  child:Text(
                                  'Apply',
                                    style: TextStyle(
                                        color: GlobalVariable.blue_main,
                                        fontFamily: GlobalVariable.Gotham,
                                        fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLoanData() async {
    dataLoanDetails.clear();
    print('getLoanData:'+widget.id+','+widget.title);
    // https://firstmangroup.in/api/banks.php?loan_id=1
    // dataAds.clear();
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/banks.php?loan_id=" +
        widget.id);

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataLoanDetails.add(DataLoanDetails.fromJson(i));
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
}
