import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [
    Color(0xffEF767A),
    Color(0xff456990),
    Color(0xff49BEAA),
    Color(0xff49DCB1),
    Color(0xffEEB868),
  ];

  final GlobalKey _boxKey = GlobalKey();

  dynamic counterText = {"count": 1, "color": Color(0xffEF767A)};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burst Counter'),
        centerTitle: true,
        backgroundColor: counterText['color'],
      ),
    );
  }
}
