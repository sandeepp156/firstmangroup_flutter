import 'package:flutter/material.dart';

void main() {
  runApp(Web());
}

class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Tab title',
        home: Scaffold(body: Container(
          color: Colors.white,
        )));
  }
}
