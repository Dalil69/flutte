import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Ball {
  double x = 0.0;
  double y = 0.0;
  double speedX = 5.0;
  double speedY = 3.0;
  double speedIncrement = 0.3;
  late Random random;

  Ball() {
    random = Random();
    resetBall();
  }

  void moveBall(double screenWidth, double screenHeight) {
    x += speedX;
    y += speedY;

    if (x < 0) {
      resetBall();
    } else if (x > screenWidth) {
      resetBall();
    }

    if (y < 0 || y > screenHeight) {
      speedY *= -1;
    }
  }

  void resetBall() {
    x = 0.0;
    y = 0.0;
    speedX = 5.0 * (random.nextBool() ? 1 : -1);
    speedY = 3.0 * (random.nextBool() ? 1 : -1);
  }
}
