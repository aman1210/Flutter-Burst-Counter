import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PVector {
  double x;
  double y;
  PVector(this.x, this.y);
}

class Particle {
  PVector position = PVector(0, 0);
  PVector velocity = PVector(0, 0);
  double mass = 10;
  double radius = 10 / 100;
  Color color = Colors.deepPurple;
  double area = 0.0314;
  double jumpFactor = -0.6;
}
