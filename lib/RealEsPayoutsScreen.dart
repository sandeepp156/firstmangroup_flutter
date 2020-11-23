import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataRealEsPayouts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import 'DataMemberDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(RealEsPayoutsScreen());
}

class RealEsPayoutsScreen extends StatefulWidget {
  final DataRealEsPayouts dataRealEsPayouts;

  RealEsPayoutsScreen({this.dataRealEsPayouts});

  @override
  _RealEsPayoutsScreenState createState() => _RealEsPayoutsScreenState();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();
final List<DataRealEsPayouts> dataRSP = new List<DataRealEsPayouts>();

int tab = 0;
int tab_two = 0;

class _RealEsPayoutsScreenState extends State<RealEsPayoutsScreen> {
  final DataRealEsPayouts dataRealEsPayouts;

  _RealEsPayoutsScreenState({this.dataRealEsPayouts});

  @override
  void initState() {
    // TODO: implement initState
    getMemberData();
    getRealEsPayoutsData("0");
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
                      'Real Estate Payouts',
                      style: TextStyle(
                          color: GlobalVariable.blue_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Hero(
                      tag: 'userImg',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          dataMemDe.length != 0 ? dataMemDe[0].image : '',
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Content
            tabs_one(),
            tabs_two(),
            Container(child: directPayouts()),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Pending : ',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium)),
                    TextSpan(
                        text: '2222,00.00',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 16))
                  ])),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Paid : ',
                        style: TextStyle(
                            color: GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium)),
                    TextSpan(
                        text: '0.00',
                        style: TextStyle(
                            color: GlobalVariable.yellow_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 16))
                  ])),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'drawable/housebadge.png',
                  height: 30,
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('2222,00.00',
                      style: TextStyle(
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 16)),
                )
              ],
            ),
            // SizedBox(
            //   child: graph(),
            // )
          ], //
        ),
      ),
    );
  }

  Widget graph() {
    return Container(
      child: LineChart(LineChartData()),
    );
  }

  Widget directPayouts() {
    return Container(
      child: Column(
        children: [
          Container(
            color: GlobalVariable.blue_main,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Lead Id',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  color: GlobalVariable.white,
                  height: 40,
                  width: 1,
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: Text(
                      'Generated payouts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  color: GlobalVariable.white,
                  height: 40,
                  width: 1,
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    child: Text(
                      'TDS\nDeduction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  color: GlobalVariable.white,
                  height: 40,
                  width: 1,
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    // color: GlobalVariable.blue_main ,
                    child: Text(
                      'Site Visit\nDeduction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  color: GlobalVariable.white,
                  height: 40,
                  width: 1,
                ),

                Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(right: 1),
                    padding: EdgeInsets.only(top: 7, bottom: 7),
                    // color: GlobalVariable.blue_main ,
                    child: Text(
                      'Payable\nAmount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  color: GlobalVariable.white,
                  height: 40,
                  width: 1,
                ),

                Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(right: 1),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    // color: GlobalVariable.blue_main ,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GlobalVariable.GothamMedium,
                          color: GlobalVariable.yellow_main,
                          fontSize: 10),
                    ),
                  ),
                ),

                // Container(color: GlobalVariable.grey_main_,height: 2,),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: dataRSP[0].direct_commissions.length,
            // itemCount: widget.dataRealEsPayouts.direct_commissions.length,
            itemBuilder: (context, pos) {
              return Container(
                color: (pos % 2 == 0) ? GlobalVariable.yellow_main : GlobalVariable.light_blue_listSeperate,

                // color: GlobalVariable.yellow_main,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          dataRSP[0].direct_commissions[pos].lead_id,
                          // widget.dataRealEsPayouts.direct_commissions[pos].lead_id,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.blue_main,
                              fontSize: 9),
                        ),
                      ),
                    ),
                    Container(
                      color: GlobalVariable.white,
                      height: 30,
                      width: 1,
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          dataRSP[0].direct_commissions[pos].commission,
                          // widget.dataRealEsPayouts.direct_commissions[pos].commission,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.blue_main,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      color: GlobalVariable.white,
                      height: 30,
                      width: 1,
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          dataRSP[0].direct_commissions[pos].tds,
                          // widget.dataRealEsPayouts.direct_commissions[pos].tds,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.blue_main,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      color: GlobalVariable.white,
                      height: 30,
                      width: 1,
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        // color: GlobalVariable.blue_main ,
                        child: Text(
                          dataRSP[0].direct_commissions[pos].visits,
                          // widget.dataRealEsPayouts.direct_commissions[pos].visits,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.blue_main,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      color: GlobalVariable.white,
                      height: 30,
                      width: 1,
                    ),

                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.only(right: 1),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        // color: GlobalVariable.blue_main ,
                        child: Text(
                          dataRSP[0].direct_commissions[pos].payable_amount.toString(),
                          // widget.dataRealEsPayouts.direct_commissions[pos].payable_amount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color: GlobalVariable.blue_main,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      color: GlobalVariable.white,
                      height: 30,
                      width: 1,
                    ),

                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.only(right: 1),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        // color: GlobalVariable.blue_main ,
                        child: Text(
                          dataRSP[0].direct_commissions[pos].status,
                          // widget.dataRealEsPayouts.direct_commissions[pos].status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GlobalVariable.GothamMedium,
                              color:  dataRSP[0].direct_commissions[pos].status ==
                                      "Pending"
                                  ? GlobalVariable.red
                                  : GlobalVariable.light_green,
                              fontSize: 10),
                        ),
                      ),
                    ),

                    // Container(color: GlobalVariable.grey_main_,height: 2,),
                  ],
                ),
              );
            },

          ),
        ],
      ),
    );
  }

  Widget tabs_one() {
    return Container(
      child: SizedBox(
        // height: 40,
        child: Column(
          children: [
            Container(
              color: GlobalVariable.grey_main_,
              height: 1,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // getRealEsPayoutsData('0');
                      setState(() {
                        tab = 0;

                      });
                    },
                    child: AnimatedContainer(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      color: tab == 0
                          ? GlobalVariable.blue_main
                          : GlobalVariable.white,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutSine,
                      child: Text(
                        'Direct payouts',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: tab == 0
                                ? GlobalVariable.white
                                : GlobalVariable.blue_main,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {

                      setState(() {
                        tab = 1;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.easeOutSine,
                      duration: Duration(milliseconds: 500),
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      color: tab == 1
                          ? GlobalVariable.blue_main
                          : GlobalVariable.white,
                      child: Text(
                        'Referral Income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: tab == 1
                                ? GlobalVariable.white
                                : GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                // Container(color: GlobalVariable.grey_main_,height: 2,),
              ],
            ),
            Container(
              color: GlobalVariable.grey_main_,
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget tabs_two() {
    return Container(
      child: SizedBox(
        // height: 40,
        child: Column(
          children: [
            // Container(
            //   color: GlobalVariable.grey_main_,
            //   height: 1,
            // ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getRealEsPayoutsData('0');

                      setState(() {
                        tab_two = 0;
                      });
                    },
                    child: AnimatedContainer(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      color: tab_two == 0
                          ? GlobalVariable.blue_main
                          : GlobalVariable.white,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutSine,
                      child: Text(
                        'Pending',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GlobalVariable.GothamMedium,
                            color: tab_two == 0
                                ? GlobalVariable.white
                                : GlobalVariable.blue_main,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getRealEsPayoutsData('1');
                      setState(() {
                        tab_two = 1;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.easeOutSine,
                      duration: Duration(milliseconds: 500),
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      color: tab_two == 1
                          ? GlobalVariable.blue_main
                          : GlobalVariable.white,
                      child: Text(
                        'Paid',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: tab_two == 1
                                ? GlobalVariable.white
                                : GlobalVariable.blue_main,
                            fontFamily: GlobalVariable.GothamMedium,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                // Container(color: GlobalVariable.grey_main_,height: 2,),
              ],
            ),
            Container(
              color: GlobalVariable.grey_main_,
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getRealEsPayoutsData(String id) async {
    dataRSP.clear();
    print("getREDid"+id);
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
        "/api/property_commissions.php?member_id=" +
        GlobalVariable.member_id +
        "&payment="+id);

    if (response.statusCode == 200) {
      await pr.hide();

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getRealEsPayoutsData->' + data.toString());
      //countInt
      setState(() {
        dataRSP.add(DataRealEsPayouts.fromJson(map));
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getRealEsPayoutsData->error');

      throw Exception('Failed to load album');
    }
  }

  getMemberData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(json);

    // String decodedString = jsonDecode(json);
    setState(() {
      String json = prefs.get('memberJson');
      for (Map i in jsonDecode(json)) {
        dataMemDe.add(DataMemberDetails.fromJson(i));
      }
    });
  }

  Widget graph_() {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // title: ChartTitle(text: 'Half yearly sales analysis'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        // tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<SalesData, String>>[
          // SalesData('Jan', 35),
          // SalesData('Feb', 28),
          // SalesData('Mar', 34),
          // SalesData('Apr', 32),
          // SalesData('May', 40)
          LineSeries(
              dataSource: <SalesData>[
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40),
                SalesData('Jun', 35),
                SalesData('Jul', 50),
                SalesData('Aug', 23),
                SalesData('Sep', 39),
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true))
          // SalesData('Jan', 35),
          // SalesData('Feb', 28),
          // SalesData('Mar', 34),
          // SalesData('Apr', 32),
          // SalesData('May', 40)
        ],
        // xValueMapper: (SalesData sales, _) => sales.year,
        // yValueMapper: (SalesData sales, _) => sales.sales,
        // // Enable data label
        // dataLabelSettings: DataLabelSettings(isVisible: true)
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
