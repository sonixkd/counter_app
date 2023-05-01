import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int age = 0;

  void loadAge() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    age = sharedPreferences.getInt('age') ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadAge();
  }

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
                onPressed: () async {
                  age++;

                  final sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setInt('age', age);

                  setState(() {});
                },
                child: Text('+'),
              ),
              ElevatedButton(
                onPressed: () async {
                  age = max(age - 1, 0);

                  final sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setInt('age', age);

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
