import 'package:flutter/material.dart';
import 'pong_table.dart';

void main() => runApp(PingPongGame());

class PingPongGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PingPongTable(),
    );
  }
}
