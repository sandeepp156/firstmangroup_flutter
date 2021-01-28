import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:firstmangroup_flutter/BannersScreen.dart';
import 'package:firstmangroup_flutter/CitySelectScreen.dart';
import 'package:firstmangroup_flutter/PopupScreen.dart';
import 'package:firstmangroup_flutter/Temp.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firstmangroup_flutter/HomeScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'DataMemberDetails.dart';
import 'customcolor.dart';
import 'initialpage.dart';
import 'dart:developer';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

final List<DataMemberDetails> dataMemDe = new List<DataMemberDetails>();
var usrName = 'Hi';
int count = 0;
String _externalUserId;
var tokenId, playerId;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String devType,type,type_id;

String _debugLabelString;

class _State extends State<MyApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // OneSignalWapper
    handleClickNotification(context);
    if(Platform.isAndroid){
      devType = 'android';
    }else if(Platform.isIOS){
      devType = 'iphone';

    }
    getUser(context);
    // _firebaseMessaging.autoInitEnabled();
    enableFireBase();
    firebaseCloudMessaging_Listeners();


    super.initState();
  }
  static Future<void> handleClickNotification(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification){
      print('handleClickNotification');
      print(notification.payload.title);
      print(notification.payload.jsonRepresentation());
      log('handleClickNotify:'+notification.payload.jsonRepresentation().toString());
      debugPrint('handleClickNotify:'+notification.payload.jsonRepresentation().toString() );

      if(notification.payload.additionalData['type']==null){
        type = notification.payload.additionalData['type'];
      }
      else{
        type='';
      }
      if(notification.payload.additionalData['type_id']==null){
        type_id =  notification.payload.additionalData['type_id'];
      }
      else{
        type_id='';
      }


      if( prefs.getString('cityId')=='-1'){
        Navigator.pushReplacement(
          context,
          new CupertinoPageRoute(builder: (context) => Initial()),
        );
       /* Intent intent = new Intent(context, InitialActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
        context.startActivity(intent);*/
      }else {
        if (type=='1') {
          Navigator.pushReplacement(
            context,
            new CupertinoPageRoute(builder: (context) => Initial()),
          );
          // Log.e("dataa21", type);
        /*  Intent intent = new Intent(context, LoanActivity.class);
          intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
          context.startActivity(intent);*/
        } else if (type=='2') {
         /* Intent intent = new Intent(context, InsurenceActivity.class);
          intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
          context.startActivity(intent);*/
        } else if (type=='3') {
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
         /*   Intent intent = new Intent(context, ProductsDetailsActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else if (type=='4') {
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
            /*Intent intent = new Intent(context, NewProductsDetailsActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else if (type=='news') {
          // Log.e("dataa1_news", type_id);
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
           /* Intent intent = new Intent(context, ReadMoreActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("text", "");
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else if (type=='event') {
          // Log.e("dataa1_event", type_id);
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
           /* Intent intent = new Intent(context, EventsDetailsActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else if (type=='offer') {
          // Log.e("dataa1_offer", type_id);
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
         /*   Intent intent = new Intent(context, OffersDetailsActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else if (type=='notification') {
          // Log.e("dataa1_offer", type_id);
          if (type_id=='') {
           /* Intent intent = new Intent(context, InitialActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
            context.startActivity(intent);*/
          } else {
          /*  Intent intent = new Intent(context, NotificationDetailsActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("id", type_id);
            context.startActivity(intent);*/
          }
        } else {
        /*  Intent intent = new Intent(context, InitialActivity.class);
          intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
          context.startActivity(intent);*/
        }
      }

   /* else{
//            Log.e("dataa1", "refdgfgds");
    Intent intent = new Intent(context, InitialActivity.class);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.putExtra("notify","notify");
    context.startActivity(intent);
    }
*/
      // print(notification.payload.additionalData['type']);


    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
      try {
        // var id = await result.notification.payload.additionalData["data_id"];
        print('handleClickNotification');
        print(result.toString());
        print(result.notification.jsonRepresentation());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BannersScreen()));
      } catch (e, stacktrace) {
        print('handleClickNotification');
        print(e.toString());
        print(stacktrace);
        // log(e);
      }
    });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("token->" + token);
      tokenId = token;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return InkWell(
        onTap: () {
          // print("tessstttttt");
          // // Navigator.pop(context);
          // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  Initial()),);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sp1.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              // color: Colors.grey,
              child: Column(
                children: [
                  new Flexible(
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(""),
                          flex: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: new Text(
                            usrName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              color: GlobalVariable.yellow_main,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(top:10),
                          child: Image.asset(
                            "assets/sp3.png",
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                    flex: 1,
                  ),
                  new Flexible(
                    child: Container(
                      padding: EdgeInsets.all(60),
                      child: Image.asset(
                        "assets/sp2.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }));
  }

  Future<void> getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('member_id') == null ||
        prefs.getString('member_id') == '-1') {
      //settings
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => Initial()), //Initial
              ));
    } else if (prefs.getString('member_id') != '-1') {
      getDetails(context);
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => Initial()), //Initial
              ));
    }
  }

  Future<void> getDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get("https://" +
            GlobalVariable.BASE_URL +
            "/api/members.php?member_id=" +
            prefs.getString('member_id'))
        //     .timeout(Duration(seconds: 5), onTimeout: () {
        //       print('serverbusy');
        //   // Navigator.pop(context);
        //   return null;
        // }
        // )
        ;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;

      // Map<String, dynamic> map = jsonDecode(json);
      print('getDetails->' + data.toString());

      setState(() {
        // GlobalVariable.member_id = prefs.getString('member_id');

        prefs.setString('memberJson', json);
        for (Map i in jsonDecode(json)) {
          dataMemDe.add(DataMemberDetails.fromJson(i));
        }
        usrName = 'Hi ' + dataMemDe[0].fname;
      });
      //settings
      //check city
      //if(city)==getAds
      //else ==citySelectionScreen

      //ads..
      //perday 3 times
      //popup_count(settings.php)//popup_image
      getSettings();

      //HomeScreen
    } else {
      print('getDetails->error');
      throw Exception('Failed to load album');
    }
  }

  Future<void> getSettings() async {
    setOneSignal();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .get("https://" + GlobalVariable.BASE_URL + "/api/settings.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int statusCode = response.statusCode;
      String json = response.body;
      Map<String, dynamic> map = jsonDecode(json);
      print('getSettings->' + json);
      setState(() {
        prefs.setString('settings', json);
        // print('getSettingsds->' + terms);
      });
      Timer(Duration(seconds: 3), () {
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);
        print(date.day.toString());

        if (date.day == date.day) {
          print('count====' + count.toString());

          if (prefs.getString('count') == null) {
            Navigator.pushReplacement(
              context,
              new CupertinoPageRoute(builder: (context) => PopupScreen()),
            );
          } else if (int.parse(prefs.getString('count')) ==
              int.parse(map['popup_count'])) {
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            setState(() {
              count = count + 1;
              prefs.setString('count', count.toString());
            });
            Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context) => PopupScreen()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }

        // var day = date.

        /*   Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => HomeScreen()),
        );*/
      });
    } else {
      print('getSettings->error');
      throw Exception('Failed to load album');
    }
  }

  void _handleNotificationReceived(OSNotification notification) {
    print(notification.payload.title);
  }

  Future<void> setOneSignal() async {
    // OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);

    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    //af474584-8ddb-48a5-81ed-c366f1bbabae (fmg)
    OneSignal.shared.init("af474584-8ddb-48a5-81ed-c366f1bbabae", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: false
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    playerId = status.subscriptionStatus.userId;

    print('playerId==' + playerId);
    callTokenRegAPI(context);

    /*  OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });


    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });*/

    // _handleSetExternalUserId();
  }

  void _handleSetExternalUserId() {

    print("Setting external user ID");
    OneSignal.shared.setExternalUserId(_externalUserId).then((results) {
      if (results == null) return;

      this.setState(() {
        _debugLabelString = "External user id set: $results";
        // print('_debugLabelString->'+_debugLabelString);
        // print('_externalUserId->'+_externalUserId);
      });
    });
  }

  Future<void> enableFireBase() async {
    await Firebase.initializeApp();
    // getUserToken();
  }

  Future<String> getUserToken() async {
    if (Platform.isIOS) checkforIosPermission();
    await _firebaseMessaging.getToken().then((token) {
      return token;
    });
  }

  void checkforIosPermission() async {
    await _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    await _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<String> getToken() async {
    // tokenId = await getUserToken();
    print('token:' + tokenId);
    return tokenId;
  }

  Future<void> callTokenRegAPI(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('member_id'));
    var queryParameters = {
      'device_token': '' + tokenId,
      'member_id': '' + prefs.getString('member_id'),
      'player_id': '' + playerId,
      'city_id': '' + prefs.getString('cityId'),
      'device_type': devType,
    };
    var uri = Uri.https(
        GlobalVariable.BASE_URL, '/api/token-register.php', queryParameters);
    print(uri);
    Response response = await get(uri);
    int statusCode = response.statusCode;
    String json = response.body;
    print('' + json.toString());
    Map<String, dynamic> map = jsonDecode(json);
    if (statusCode == 200) {
      if (map['status'] == 'Success') {
        /*   Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => OTPVScreen(text: phCntrl.text.toString(),otp: map['OTP'],)),
        );*/
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(map['message'])));
        // showMyDialog(context, map['message']);
      }
    }
  }
}
//ads.php
//popup image
//fms token::
//ios token
//e5kM9pKMBUc4uluHZO-Jyp:APA91bESU-xJLCWhdZSIx-dngDrtV7FzpIGPcu7PUzeT8OKTvIhFml6MbI3aaENxCauI6XxnboPGzBRqYZD0okSj4mjp7H4hrXzxHKKkzJ42LnL2FHF-nbDX7HHy_KwQ8hOxzu_uMylO
//android token
//dxVFdSSeTH6pmWiPiXwq9I:APA91bGILZ7M0rYa-uS4qtoRf2dfxHhHhA_8B840jZ2wULzJXHSKSrCiAHZJX1t-46s2uPoH5ihA0qshDbOL-ZwS4fi-Cf2oOxLNMzMMPGV_IdnAvpMu-9UZjFx0iv4WBVgxx7H8v0v-