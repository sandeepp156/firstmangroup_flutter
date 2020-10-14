import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Widget> pages = [
  //  HomePage(),
  //   PayoutsPage(),
  //   SaleListPage(),
  //   MyOfficePage(),
  // ];

  List<Widget> pages = [
    HomePage(),
    Container(
      child: Image.asset(
        "assets/in2.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      child: Image.asset(
        "assets/in3.png",
        fit: BoxFit.fill,
      ),
    )
  ];

  final controller = PageController(
    initialPage: 0,
  );

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
                bottommenu(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 3),
              child: Image.asset(
                'drawable/menu.png',
                height: 30,
                width: 30,
              ),
            ),
            Image.asset(
              'drawable/app_new_icon.png',
              height: 25,
              width: 30,
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'drawable/select_city.png',
                  height: 15,
                  width: 30,
                ),
                Text(
                  'Vijayawada',
                  style: TextStyle(fontSize: 8),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7, left: 3),
              child: Image.asset(
                'drawable/app_new_icon.png',
                height: 25,
                width: 30,
              ),
            ),
          ],
        ));
  }

  Widget fragments() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      children: pages,
      controller: controller,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget bottommenu() {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/home_act.png',
                height: 20,
              ),
              Text(
                'Home',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.blue_main,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/commission.png',
                height: 20,
              ),
              Text(
                'Payouts',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/sales_list.png',
                height: 20,
              ),
              Text(
                'Sale List',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'drawable/my_office.png',
                height: 20,
              ),
              Text(
                'My Office',
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalVariable.grey_main_,
                    fontFamily: GlobalVariable.GothamMedium),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget HomePage() {
  return ListView(
    children: [
      Image.asset(
        'drawable/app_icon.png',
        height: 125,
      ),
      tradegallery(),
      // gadgets(),
      // count(),
      // ads(),
      // news(),
    ],
  );
}

Widget tradegallery() {
  return SizedBox(
    child: Column(
      children: [
        Text(
          'TRADE GALLERY',
          style: TextStyle(
              color: GlobalVariable.blue_main,
              fontFamily: GlobalVariable.Gotham,
              // height: 1.5,
              // decoration:TextDecoration.underline,
              fontSize: 12),
        ),
        Container(
          color: GlobalVariable.yellow_main,
          height: 1,
          width: 115,
          margin: EdgeInsets.only(top: 3),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (BuildContext context,int pos){
              return Container(
                margin: EdgeInsets.only(left: 10),
                height: 100,
                width: 125,
                color: Colors.green,
                child: Image.asset('drawable/realestate_back.png',height: 100,fit: BoxFit.fill,),
              );
            },
          ),
        ),


      ],
    ),
  );
}

Widget gadgets() {
  return  GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4),
      itemCount: 8,
      itemBuilder: (BuildContext context, int pos) {
        return Container(
          margin: EdgeInsets.only(left: 10, top: 10),
          height: 100,
          width: 150,
          // color: GlobalVariable.yellow_main,
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: GlobalVariable.yellow_main,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 3, bottom: 3),
                  child: Text(
                    'Vijayawada',
                    style: TextStyle(
                        color: GlobalVariable.blue_main,
                        fontSize: 12,
                        fontFamily: GlobalVariable.Gotham),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget count() {}

Widget ads() {}

Widget news() {}
