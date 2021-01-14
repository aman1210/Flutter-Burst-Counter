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

  Rect boxSize = Rect.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Size size = _boxKey.currentContext.size;
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burst Counter'),
        centerTitle: true,
        backgroundColor: counterText['color'],
      ),
      body: Container(
        key: _boxKey,
        child: Stack(
          children: [
            Center(
              child: Text(
                '${counterText['count']}',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: counterText['color'],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: counterText['color'],
        onPressed: () {},
      ),
    );
  }
}
