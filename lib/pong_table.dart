import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'ball.dart';
import 'paddle.dart';
import 'score.dart';

class PingPongTable extends StatefulWidget {
  @override
  _PingPongTableState createState() => _PingPongTableState();
}

class _PingPongTableState extends State<PingPongTable> {
  double ballX = 0.0;
  double ballY = 0.0;
  double ballSpeedX = 5.0;
  double ballSpeedY = 3.0;
  double playerY = 200.0;
  double opponentY = 200.0;
  double playerSpeed = 16.0;
  double opponentSpeed = 16.0;
  double ballSpeedIncrement = 3;
  int playerScore = 0;
  int opponentScore = 0;
  bool isGamePaused = false;

  late double screenHeight;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    startBallMovement();
    startOpponentAI();
  }

  void startBallMovement() {
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      if (!isGamePaused) {
        setState(() {
          ballX += ballSpeedX;
          ballY += ballSpeedY;

          double screenWidth = MediaQuery.of(context).size.width;

          if (ballX < 0) {
            playerScore++;
            resetBall(screenWidth, screenHeight);
          } else if (ballX > screenWidth) {
            opponentScore++;
            resetBall(screenWidth, screenHeight);
          }

          if (ballY < 0) {
            ballSpeedY *= -1;
            ballY = 0;
          } else if (ballY > screenHeight) {
            ballSpeedY *= -1;
            ballY = screenHeight;
          }

          if (ballX + screenWidth / 5 >= screenWidth - screenWidth / 10 &&
              ballY + screenWidth / 30 >= opponentY &&
              ballY <= opponentY + screenHeight / 6) {
            ballSpeedX *= -1;
            ballSpeedX += ballSpeedIncrement;
          }

          if (ballX - screenWidth / 10 <= screenWidth / 10 &&
              ballY >= playerY &&
              ballY <= playerY + screenHeight / 6) {
            ballSpeedX *= -1;
            ballSpeedX -= ballSpeedIncrement;
          }
        });
      }
    });
  }

  void resetBall(double screenWidth, double screenHeight) {
    ballX = screenWidth / 2;
    ballY = screenHeight / 2;
    ballSpeedX = 5.0 * (random.nextBool() ? 1 : -1);
    ballSpeedY = 3.0 * (random.nextBool() ? 1 : -1);
  }

  void startOpponentAI() {
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      if (!isGamePaused) {
        setState(() {
          if (ballY < opponentY + screenHeight / 12) {
            opponentY -= opponentSpeed;
          } else {
            opponentY += opponentSpeed;
          }

          opponentY = opponentY.clamp(0, screenHeight - screenHeight / 6);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ping Pong Game'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            playerY += details.delta.dy * 2.0;
            playerY = playerY.clamp(0, screenHeight - screenHeight / 6);
          });
        },
        onTap: () {
          isGamePaused = !isGamePaused;
        },
        child: Container(
          color: const Color.fromARGB(255, 41, 41, 41),
          child: Stack(
            children: [
              Positioned(
                left: ballX,
                top: ballY,
                child: Container(
                  width: MediaQuery.of(context).size.width / 30,
                  height: MediaQuery.of(context).size.width / 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: opponentY,
                child: Container(
                  width: MediaQuery.of(context).size.width / 60,
                  height: screenHeight / 6,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                left: 0,
                top: playerY,
                child: Container(
                  width: MediaQuery.of(context).size.width / 60,
                  height: screenHeight / 6,
                  color: Colors.green,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  'Joueur : $playerScore',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  'IA : $opponentScore',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              if (isGamePaused)
                Center(
                  child: Text(
                    'PAUSÉ OKALM',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
