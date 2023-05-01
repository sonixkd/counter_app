import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  int _age = 0;
  int get age => _age;

  ViewModel() {
    loadAge();
  }

  void loadAge() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _age = sharedPreferences.getInt('age') ?? 0;
    notifyListeners();
  }

  void incrementAge() async {
    _age++;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _age);
    notifyListeners();
  }

  void decrementAge() async {
    _age = max(age - 1, 0);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _age);
    notifyListeners();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _AgeTitle(),
              _AgeIncrementWidget(),
              _AgeDecrementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.select((ViewModel value) => value.age);
    return Text(viewModel.toString());
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.incrementAge,
      child: Text('+'),
    );
  }
}

class _AgeDecrementWidget extends StatelessWidget {
  const _AgeDecrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.decrementAge,
      child: Text('-'),
    );
  }
}
