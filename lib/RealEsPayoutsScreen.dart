import 'dart:convert';
import 'dart:io';

import 'package:firstmangroup_flutter/DataRealEsPayouts.dart';

// import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
// import 'package:fl_animated_linechart/chart/line_chart.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'DataInsurancePayouts.dart';
import 'DataLoanPayouts.dart';
import 'DataManualPayouts.dart';
import 'DataMemberDetails.dart';
import 'customcolor.dart';

void main() {
  runApp(RealEsPayoutsScreen());
}

class RealEsPayoutsScreen extends StatefulWidget {
  String title;
  RealEsPayoutsScreen({this.title});
  @override
  _RealEsPayoutsScreenState createState() => _RealEsPayoutsScreenState();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();
final List<DataRealEsPayouts> dataRSP = new List<DataRealEsPayouts>();
final List<SalesData> salesData = new List<SalesData>();
final List<DataLoanPayouts> dataLoanPayouts = new List<DataLoanPayouts>();
final List<DataInsurancePayouts> dataInsurancePayouts = new List<DataInsurancePayouts>();
final List<DataManualPayouts> dataManualPayouts = new List<DataManualPayouts>();

// LineChart lineChart = LineChart.fromDateTimeMaps(series, colors, units);
// LineChart lineChart = LineChart.fromDateTimeMaps([5, 5], [Colors.green, Colors.blue],[]);

int tab = 0;
int tab_two = 0;
bool tab_selected = true;

class _RealEsPayoutsScreenState extends State<RealEsPayoutsScreen> {
  String title;
  _RealEsPayoutsScreenState({this.title});
  @override
  void initState() {
    // TODO: implement initState
    getRealEsPayoutsData("0");
    getMemberData();
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
                      ''+widget.title,
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
                        text: tab_selected
                            ? dataRSP.length != 0
                                ? dataRSP[0].direct_commissions_total_pending
                                : 'sd'
                            : dataRSP.length != 0
                                ? dataRSP[0].override_commissions_total
                                : 'sd',
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
                        // text: '0.00',
                        text: tab_selected
                            ? dataRSP.length != 0
                                ? dataRSP[0].direct_commissions_total_paid
                                : 'sd'
                            : dataRSP.length != 0
                                ? dataRSP[0].override_commissions_total_paid
                                : 'sd',

                        // text:dataRSP.length!=0? dataRSP[0].direct_commissions_total_paid:'sd',

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
                  child: Text(
                      tab_selected
                          ? dataRSP.length != 0
                              ? dataRSP[0].direct_commissions_total
                              : 'sd'
                          : dataRSP.length != 0
                              ? dataRSP[0].override_commissions_total
                              : 'sd',

                      // dataRSP.length!=0?dataRSP[0].direct_commissions_total:'',
                      style: TextStyle(
                          color: GlobalVariable.yellow_main,
                          fontFamily: GlobalVariable.GothamMedium,
                          fontSize: 16)),
                )
              ],
            ),
            SizedBox(
              height: 175,
              child: SfCartesianChart(
                // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  // legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                      // Bind data source
                        dataSource: salesData,
                        // <SalesData>[
                        //   SalesData('Jan', 2500),
                        //   SalesData('Feb', 4000),
                        //   SalesData('Mar', 1000),
                        //   SalesData('Apr', 3000),
                        //   SalesData('May', 1700)
                        // ],
                        xValueMapper: (SalesData sales, _) =>
                        sales.year,
                        yValueMapper: (SalesData sales, _) =>
                        sales.sales)
                  ])
              ,
            )
            // AnimatedLineChart(lineChart),
            // SizedBox(
            //   width: double.infinity,
            //   child: graph(),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget graph() {
  //   return Container(
  //     child: LineChart(data()),
  //   );
  // }

  // LineChartData data(){
  //   return LineChartData(
  //     lineTouchData: LineTouchData(
  //       enabled: false,
  //     ),
  //     gridData: FlGridData(
  //       show: false,
  //     ),
  //     titlesData:  FlTitlesData(
  //       bottomTitles: SideTitles(
  //         showTitles: true,
  //         reservedSize: 20,
  //         getTextStyles: (value) => const TextStyle(
  //           color:Colors.red,
  //           // fontWeight: FontWeight.bold,
  //           fontSize: 10,
  //         ),
  //         margin: 25,
  //         getTitles: (value){
  //           switch(value.toInt()){
  //             case 0:
  //               return '';
  //             case 1:
  //               return 'Nov 20';
  //             case 2:
  //               return 'Oct 20';
  //             case 3:
  //               return 'Sep 20';
  //             case 4:
  //               return 'Aug 20';
  //             case 5:
  //               return 'Jul 20';
  //             case 6:
  //               return 'Jun 20';
  //           }
  //           return '';
  //         }
  //       ),
  //       leftTitles: SideTitles(
  //         showTitles: true,
  //         getTextStyles: (value) => const TextStyle(
  //           color: Color(0xff75729e),
  //           fontWeight: FontWeight.bold,
  //           fontSize: 10,
  //         ),
  //         getTitles: (value) {
  //           switch (value.toInt()) {
  //             case 1:
  //               return '0';
  //             case 2:
  //               return '4,000';
  //             case 3:
  //               return '8,000';
  //             case 4:
  //               return '12,000';
  //             case 5:
  //               return '16,000';
  //             case 6:
  //               return '20,000';
  //           }
  //           return '';
  //         },
  //         margin: 8,
  //         reservedSize: 30,
  //       )
  //     ),
  //     lineBarsData: linesBarData2(),
  //
  //   );
  // }

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

                Visibility(
                  visible: tab_selected,
                  child: Expanded(
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
          Container(
            height: 175,
            child: tab_selected ? directpayoutsList() : referralIncList(),
          ),
        ],
      ),
    );
  }

  Widget directpayoutsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataRSP.length == 0 ? 0 : dataRSP[0].direct_commissions.length,
      // itemCount: widget.dataRealEsPayouts.direct_commissions.length,
      itemBuilder: (context, pos) {
        return Container(
          color: (pos % 2 == 0)
              ? GlobalVariable.yellow_main
              : GlobalVariable.light_blue_listSeperate,

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
                    dataRSP[0]
                        .direct_commissions[pos]
                        .payable_amount
                        .toString(),
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
                        color: dataRSP[0].direct_commissions[pos].status ==
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
    );
  }

  Widget referralIncList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          dataRSP.length == 0 ? 0 : dataRSP[0].override_commissions.length,
      // itemCount: widget.dataRealEsPayouts.direct_commissions.length,
      itemBuilder: (context, pos) {
        return Container(
          color: (pos % 2 == 0)
              ? GlobalVariable.yellow_main
              : GlobalVariable.light_blue_listSeperate,

          // color: GlobalVariable.yellow_main,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    dataRSP[0].override_commissions[pos].tp,
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
                    dataRSP[0].override_commissions[pos].commission,
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
                    dataRSP[0].override_commissions[pos].tds,
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
                  // margin: EdgeInsets.only(right: 1),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  // color: GlobalVariable.blue_main ,
                  child: Text(
                    dataRSP[0]
                        .override_commissions[pos]
                        .payable_amount
                        .toString(),
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
                    dataRSP[0].override_commissions[pos].status,
                    // widget.dataRealEsPayouts.direct_commissions[pos].status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: GlobalVariable.GothamMedium,
                        color: dataRSP[0].override_commissions[pos].status ==
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
                      getRealEsPayoutsData('0');
                      setState(() {
                        tab = 0;
                        tab_selected = true;
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
                      getRealEsPayoutsData('1');

                      setState(() {
                        tab = 1;
                        tab_selected = false;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dataRSP.clear();
    print("getREDid" + id);
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
        prefs.getString('member_id') +
        "&payment=" +
        id);

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
        for (int j = 0; j < dataRSP[0].direct_commissions_graph.length; j++) {
          salesData.add(SalesData(dataRSP[0].direct_commissions_graph[j].date.toString(),double.parse(dataRSP[0].direct_commissions_graph[j].total.toString()) ));
        }
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

  Future<void> getLoanData() async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/loans_commissions.php?member_id=" +
        prefs.getString('member_id') +
        "&payment=0");

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
        dataLoanPayouts.add(DataLoanPayouts.fromJson(map));
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getRealEsPayoutsData->error');

      throw Exception('Failed to load album');
    }
  }
  Future<void> getInsuranceData() async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/insurance_commissions.php?member_id=" +
        prefs.getString('member_id') +
        "&payment=0");

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
        dataInsurancePayouts.add(DataInsurancePayouts.fromJson(map));
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getRealEsPayoutsData->error');

      throw Exception('Failed to load album');
    }
  }
  Future<void> getManualData() async {
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

    final response = await http.get("https://" +
        GlobalVariable.BASE_URL +
        "/api/manual_commissions.php?member_id=" +
        prefs.getString('member_id') +
        "&payment=0");

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
        dataManualPayouts.add(DataManualPayouts.fromJson(map));
      });
    } else {
      await pr.hide();

      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('getRealEsPayoutsData->error');

      throw Exception('Failed to load album');
    }
  }
//
// Widget graph_() {
//   return Container(
//     child: SfCartesianChart(
//       primaryXAxis: CategoryAxis(),
//       // title: ChartTitle(text: 'Half yearly sales analysis'),
//       // Enable legend
//       legend: Legend(isVisible: true),
//       // Enable tooltip
//       // tooltipBehavior: TooltipBehavior(enable: true),
//       series: <LineSeries<SalesData, String>>[
//         // SalesData('Jan', 35),
//         // SalesData('Feb', 28),
//         // SalesData('Mar', 34),
//         // SalesData('Apr', 32),
//         // SalesData('May', 40)
//         LineSeries(
//             dataSource: <SalesData>[
//               SalesData('Jan', 35),
//               SalesData('Feb', 28),
//               SalesData('Mar', 34),
//               SalesData('Apr', 32),
//               SalesData('May', 40),
//               SalesData('Jun', 35),
//               SalesData('Jul', 50),
//               SalesData('Aug', 23),
//               SalesData('Sep', 39),
//             ],
//             xValueMapper: (SalesData sales, _) => sales.year,
//             yValueMapper: (SalesData sales, _) => sales.sales,
//             dataLabelSettings: DataLabelSettings(isVisible: true))
//         // SalesData('Jan', 35),
//         // SalesData('Feb', 28),
//         // SalesData('Mar', 34),
//         // SalesData('Apr', 32),
//         // SalesData('May', 40)
//       ],
//       // xValueMapper: (SalesData sales, _) => sales.year,
//       // yValueMapper: (SalesData sales, _) => sales.sales,
//       // // Enable data label
//       // dataLabelSettings: DataLabelSettings(isVisible: true)
//     ),
//   );
// }
//
// List<LineChartBarData>linesBarData2() {
//   return [
//     LineChartBarData(
//       spots: [
//         FlSpot(1, 1),
//         FlSpot(3, 4),
//         FlSpot(5, 1.8),
//         FlSpot(7, 5),
//         FlSpot(10, 2),
//         FlSpot(12, 2.2),
//         FlSpot(13, 1.8),
//       ],
//       isCurved: true,
//       curveSmoothness: 0,
//       colors: const [
//         Color(0xff0E2D6B),        ],
//       barWidth: 4,
//       isStrokeCapRound: true,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     ),
//   ];
// }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
