import 'dart:math';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int age = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(age.toString()),
              ElevatedButton(
                onPressed: () {
                  age++;
                  setState(() {});
                },
                child: Text('+'),
              ),
              ElevatedButton(
                onPressed: () {
                  age = max(age - 1, 0);
                  setState(() {});
                },
                child: Text('-'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
