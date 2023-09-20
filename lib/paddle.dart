import 'package:flutter/material.dart';

class Paddle {
  double y = 200.0;
  double speed = 16.0;
  double paddleWidth = 20.0;
  double paddleHeight = 100.0;

  void movePaddle(double dy, double screenHeight) {
    y += dy;

    // Limitez la raquette à l'écran en utilisant clamp
    y = y.clamp(0, screenHeight - paddleHeight);
  }

  Rect getPaddleRect(double screenWidth, double screenHeight) {
    return Rect.fromLTWH(
      screenWidth - paddleWidth,
      y,
      paddleWidth,
      paddleHeight,
    );
  }
}
