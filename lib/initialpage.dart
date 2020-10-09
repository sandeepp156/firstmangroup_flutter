import 'package:firstmangroup_flutter/customcolor.dart';
import 'package:firstmangroup_flutter/registration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Initial());
}
bool tem=true;
bool tem1=false;
int item_li=0;
class Initial extends StatefulWidget {
  @override
  _initialState createState() => _initialState();
}

class _initialState extends State<Initial> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     tem=true;
     tem1=false;
     item_li=0;
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                children: pages,
                controller: controller,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) =>
                {
                  item_li=index,
                  setState(() {
                    if (index == 2) {
                      tem = false;
                      tem1 = true;
                    } else {
                      tem1 = false;
                      tem = true;
                    }
                  }),
                },
              ),
              // Text("Started",style: TextStyle(color: Colors.green,fontSize: 20),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: arrows(context),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < 3; i++)
                      if (i == item_li)
                        circleBar(true)
                      else
                        circleBar(false),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static final controller = PageController(
    
    initialPage: 0,
  );
  List<Widget> pages = [
    Container(child: Image.asset("assets/in1.png", fit: BoxFit.fill,),),
    Container(child: Image.asset("assets/in2.png", fit: BoxFit.fill,),),
    Container(child: Image.asset("assets/in3.png", fit: BoxFit.fill,),)
  ];

  Widget arrows(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: double.infinity,width: double.infinity,
        padding:const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              child: new
              IconButton(iconSize:40,icon: new Image.asset('assets/right.png'), onPressed: () {
                if(item_li==0)
                  controller.nextPage(duration: Duration(milliseconds: 180), curve: Curves.linear);
                else
                  controller.nextPage(duration: Duration(milliseconds: 180), curve: Curves.linear);
              },),visible: tem,),
            Visibility(child: Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: InkWell(
                  onTap:(){
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>  Registration()),);
                  },
                  child: Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 25),)),
            ), visible: tem1,)
          ],
        )
    );
  }
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 10 : 5,
      width: isActive ? 10 : 5,
      decoration: BoxDecoration(
          color: isActive ? GlobalVariable.yellow_main : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
