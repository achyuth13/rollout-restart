import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatelessWidget {
  final int countdown;
  const CountdownWidget({super.key, required this.countdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Text(
          countdown.toString(),
          style: TextStyle(
            fontSize: 100,
            color: countdown == 3 ? Colors.red : countdown == 2 ? Colors.yellow : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
