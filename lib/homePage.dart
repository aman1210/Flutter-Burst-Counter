import 'dart:async';
import 'dart:math';

import 'package:burst_counter/particle.dart';
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

  Random random = Random();

  List<Particle> particles = [];

  double fps = 1 / 30;

  Timer timer;

  final double gravity = 9.81;
  final double drag = 0.47;
  final double density = 1.1644;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Size size = _boxKey.currentContext.size;
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);
    });
    timer = Timer.periodic(
        Duration(milliseconds: (fps * 1000).floor()), frameBuilder);
  }

  frameBuilder(Timer timer) {
    particles.forEach((pt) {
      double dragForceX =
          0.5 * density * pow(pt.velocity.x, 2) * drag * pt.area;
      double dragForceY =
          0.5 * density * pow(pt.velocity.y, 2) * drag * pt.area;
      dragForceX = dragForceX.isInfinite ? 0.0 : dragForceX;
      dragForceY = dragForceY.isInfinite ? 0.0 : dragForceY;
      double accX = dragForceX / pt.mass;
      double accY = dragForceY / pt.mass + gravity;
      pt.velocity.x += accX * fps;
      pt.velocity.y += accY * fps;

      pt.position.x += pt.velocity.x * fps * 100;
      pt.position.y += pt.velocity.y * fps * 100;
      collision(pt);
    });
    setState(() {});
  }

  collision(Particle pt) {
    //rigt wall
    if (pt.position.x > boxSize.width - pt.radius) {
      pt.position.x = boxSize.width - pt.radius;
      pt.velocity.x *= pt.jumpFactor;
    }

    //left wall
    if (pt.position.x < pt.radius) {
      pt.position.x = pt.radius;
      pt.velocity.x *= pt.jumpFactor;
    }

    //bottom wall
    if (pt.position.y > boxSize.height - pt.radius) {
      pt.position.y = boxSize.height - pt.radius;
      pt.velocity.y *= pt.jumpFactor;
    }
  }

  burstParticle() {
    if (particles.length > 100) {
      particles.removeRange(0, 75);
    }
    counterText['count'] += 1;
    Color newColor = colors[random.nextInt(colors.length)];
    counterText['color'] = newColor;

    int count = random.nextInt(25).clamp(7, 25);
    for (int i = 0; i < count; i++) {
      Particle p = new Particle();
      p.position = PVector(boxSize.center.dx, boxSize.center.dy);
      double randomX = random.nextDouble() * 4;
      if (i % 2 == 0) {
        randomX = -randomX;
      }
      double randomY = random.nextDouble() * -8.0;
      p.velocity = PVector(randomX, randomY);
      p.radius = (random.nextDouble() * 10.0).clamp(2.0, 10.0);
      p.color = newColor;
      particles.add(p);
    }
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
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.only(bottom: 4),
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
            ...particles
                .map((p) => Positioned(
                      top: p.position.y,
                      left: p.position.x,
                      child: Container(
                        width: p.radius * 2,
                        height: p.radius * 2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: p.color),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: counterText['color'],
        onPressed: burstParticle,
      ),
    );
  }
}
