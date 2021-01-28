import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BannersScreen.dart';
import 'Cart.dart';
import 'DataPropGallery.dart';
import 'customcolor.dart';

void main() {
  runApp(ShortListPropScreen());
}

class ShortListPropScreen extends StatefulWidget {
  @override
  _ShortListPropScreenState createState() => _ShortListPropScreenState();
}

TextEditingController name = new TextEditingController(),
    pname = new TextEditingController();
final List<DataPropGallery> dataPropGallery = new List<DataPropGallery>();
List<Cart> cartData = new List<Cart>();

int length, name_length, pname_length;
var j, pj;
List<String> gotItems = new List<String>();

class _ShortListPropScreenState extends State<ShortListPropScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // getShortListProp();
    getCartItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      'ShortListed Properties',
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
              color: GlobalVariable.text_colors_black,
              height: 1,
            ),
            Expanded(
              child: cartData.length == 0
                  ? Center(
                      child: Text(
                      'Your ShortListed Properties are Empty',
                      style: TextStyle(
                        fontFamily: GlobalVariable.Gotham,
                      ),
                    ))
                  : ListView.builder(
                      itemCount: cartData.length == 0 ? 0 : cartData.length,
                      itemBuilder: (context, pos) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => BannersScreen(
                                        id: cartData[pos].id,
                                        typeId: '0',
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: GlobalVariable.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: GlobalVariable.grey_main_,
                                      offset: Offset(3, 3),
                                      blurRadius: 5)
                                ]),
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: Column(
                              children: [
                                Container(
                                  height: 180,
                                  child: Stack(
                                    children: [
                                      Visibility(
                                          visible: cartData.length == 0
                                              ? false
                                              : true,
                                          child: Image.network(
                                            cartData[pos].image,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          )),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 25, right: 20),
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          color: GlobalVariable.white,
                                          child: Text(
                                            cartData.length != null
                                                ? cartData[pos].title.toString()
                                                : 'title',
                                            // 'asdfdsfds',

                                            // dataCategory.length!=0?dataCategory[pos].title:'asdfadsads',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily:
                                                    GlobalVariable.GothamMedium,
                                                color: GlobalVariable.blue_main,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            print('$pos');
                                            setState(() {
                                              // shortlistIndex=pos;
                                              // ids.add(dataPropGallery[pos].id);
                                            });
                                            // saveShortlistitems (dataPropGallery[pos]);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, bottom: 15),
                                                child: Image.asset(
                                                  'drawable/short_select.png',
                                                  height: 35,
                                                  // color: GlobalVariable.text_colors_black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, bottom: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Image.asset(
                                              'drawable/rupee.png',
                                              height: 15,
                                              width: 10,
                                            ),
                                          ),
                                          Text(
                                            cartData[pos].price,
                                            style: TextStyle(
                                                color: GlobalVariable.blue_main,
                                                fontFamily:
                                                    GlobalVariable.Gotham,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Image.asset(
                                              'drawable/location.png',
                                              height: 15,
                                              width: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              cartData[pos].address +
                                                  ',' +
                                                  cartData[pos].address,
                                              style: TextStyle(
                                                  color:
                                                      GlobalVariable.blue_main,
                                                  fontFamily:
                                                      GlobalVariable.Gotham,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getShortListProp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('srtlst') == null ||
        prefs.getString('srtlst').length == 0) {
    } else {
      var s = prefs.getString('srtlst');
      // var ab = json.decode(prefs.getString('srtlst').toString());
      print('saveShortlistitems:' + s.toString());

      // dataPropGallery.add();
    }
  }

  void getCartItem() async {
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
    // await pr.show();

    // cartData.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getStringList('cart').toString() ?? "0");
    print(data.toString());
    if (data != null) {
      if (data != "0") {
        // await pr.hide();
        setState(() {
          for (Map i in data) {
            cartData.add(Cart.fromJson(i));
          }
        });

      } else {
        // await pr.hide();

        // showMyDialog(context, 'Your Cart is Empty');
        print('Your Cart is Empty');
      }
    } else {
      // await pr.hide();

      print('Your Cart is Empty');
      // showMyDialog(context, 'Your Cart is Empty');
    }
  }
}
