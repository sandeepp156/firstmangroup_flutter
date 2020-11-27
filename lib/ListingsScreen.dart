// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firstmangroup_flutter/TrackLeadsScreen.dart';
import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'BannersScreen.dart';
import 'DataBanners.dart';
import 'MyFmNw.dart';
import 'PropertyGalleryScreen.dart';
import 'initialpage.dart';

void main() {
  runApp(ListingScreen());
}

class ListingScreen extends StatefulWidget {
  final String typeId;

  ListingScreen({this.typeId});

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

final List<DataBanners> dataBanners = new List<DataBanners>();
// final List<DataAds> dataAds = new List<DataAds>();

final controller = PageController(
  initialPage: 0,
);
bool tem = true;
bool tem1 = false;
int item_li = 0;
bool showId = false;
bool showMenu = false;
var _scale = 0.0;
List<Widget> pages = [
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.lightBlue,
  ),
  Container(
    color: Colors.lightGreen,
  ),
];

class _RealEstateScreenState extends State<ListingScreen> {
  final String typeId;

  _RealEstateScreenState({this.typeId});

  // List<Widget> pages = [
  //  HomePage(),
  //   PayoutsPage(),
  //   SaleListPage(),
  //   MyOfficePage(),
  // ];
  //
  // List<Widget> pages = [
  //   widget.HomePage,
  //   Container(
  //     child: Image.asset(
  //       "assets/in2.png",
  //       fit: BoxFit.fill,
  //     ),
  //   ),
  //   Container(
  //     child: Image.asset(
  //       "assets/in3.png",
  //       fit: BoxFit.fill,
  //     ),
  //   )
  // ];

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    getData();
    // showProg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                appBar(),
                Expanded(
                  child: HomePage(), //fragments
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      // alignment: Alignment.centerLeft,
      // height: 45,
      child: Row(
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
              'Listings',
              style: TextStyle(
                  color: GlobalVariable.blue_main,
                  fontFamily: GlobalVariable.GothamMedium,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget fragments() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      children: pages,
      controller: controller,
      scrollDirection: Axis.horizontal,
    );
  }


  Widget HomePage() {
    return ListView(
      children: [
        SizedBox(
          height: 225,
          child: Carousel(
            images: dataBanners.length == 0
                ? [
                    // Image.asset('drawable/bnner1.png'),
                    Text('Loading'),
                  ]
                : dataBanners.map((imgURL) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imgURL.image,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
            onImageTap: (i) {
              print('' + i.toString());

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => BannersScreen(id: dataBanners[i].typeId,typeId: dataBanners[i].type,)),
              );
            },
            showIndicator: true,
            borderRadius: false,
            dotSize: 3.0,
            dotSpacing: 5.0,
            dotIncreasedColor: GlobalVariable.white,
            dotColor: GlobalVariable.grey_main,
            dotBgColor: Colors.transparent,
            noRadiusForIndicator: true,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 1,
          color: GlobalVariable.grey_main_,
        ),
        // GridView.builder(
        //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2),
        //     itemCount:9,
        //     // itemCount: dataCities.length==0?1:dataCities.length,
        //     itemBuilder: (BuildContext context, int pos) {
        //       return InkWell(
        //         onTap: (){
        //           setState(() {
        //             // isSelected = pos;
        //             // cityID = dataCities[pos].id;
        //             // print('CITYIDSELECTED:'+cityID);
        //           });
        //         },
        //         child: Container(
        //           margin: EdgeInsets.only(left: 10, top: 10),
        //           height: 100,
        //           width: 150,
        //           // color: GlobalVariable.yellow_main,
        //           child: Container(
        //             child: Stack(
        //               children: [
        //                 Column(
        //                   children: [
        //                     Expanded(
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                             image: DecorationImage(image: NetworkImage(dataCities.length==0?'https://ak6.picdn.net/shutterstock/videos/6982306/thumb/1.jpg':dataCities[pos].image))
        //                         ),
        //                         // color: GlobalVariable.yellow_main,
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding:
        //                       const EdgeInsets.only(top: 3, bottom: 3),
        //                       child: Text(
        //                         dataCities.length==0?'':dataCities[pos].title,
        //                         style: TextStyle(
        //                             color: GlobalVariable.blue_main,
        //                             fontSize: 12,
        //                             fontFamily: GlobalVariable.Gotham),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //                 Align(
        //                   alignment: Alignment.topRight,
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(top: 5,right: 5),
        //                     child: Image.asset(isSelected != null && isSelected == pos ?'drawable/select_city_fill.png':'drawable/select_city.png',height: 15,width: 15,
        //                     ),
        //                     //isSelected != null && isSelected == index //set condition like this. voila! if isSelected and list index matches it will colored as white else orange.
        //                     //                              ? Colors.white
        //                     //                              : Colors.orange,
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     }),

      ],
    );
  }



  Future<void> getData() async {
    // dataAds.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonAds = prefs.getString("cityJson");
    // print("jsonAds"+jsonAds);
    // Map<String, dynamic> map = jsonDecode(jsonAds);
    //
    // setState(() {
    //   if(map.containsKey('realestate_gallery')){
    //     for(Map i in map["realestate_gallery"]){
    //       dataAds.add(DataAds.fromJson(i));
    //     }
    //   }
    //   else{
    //
    //   }
    //
    // });
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
        "/api/banners.php?city_id=1&type="+widget.typeId.toString());

    if (response.statusCode == 200) {
      await pr.hide();

      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      // Map<String, dynamic> map = jsonDecode(json);
      print('getData->' + data.toString());
      setState(() {
        for (Map i in jsonDecode(json)) {
          dataBanners.add(DataBanners.fromJson(i));
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


