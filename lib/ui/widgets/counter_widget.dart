import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int _age = 0;
  int get age => _age;
  set age(int value) => _age = value;

  User(this._age);
}

class UserServise {
  var _user = User(0);
  User get user => _user;

  Future<void> loadAge() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final age = sharedPreferences.getInt('age') ?? 0;
    _user = User(age);
  }

  Future<void> saveAge() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _user.age);
  }

  void incrementAge() {
    _user.age++;
    saveAge();
  }

  void decrementAge() {
    _user.age = max(_user.age - 1, 0);
    saveAge();
  }
}

class ViewModelstate {
  String ageTitle;
  ViewModelstate({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userService = UserServise();
  var _state = ViewModelstate(ageTitle: '');
  ViewModelstate get state => _state;

  void _updateState() {
    final user = _userService.user;
    _state = ViewModelstate(ageTitle: user.age.toString());
    notifyListeners();
  }

  void loadAge() async {
    await _userService.loadAge();
    _updateState();
  }

  ViewModel() {
    loadAge();
  }

  void onIncrementButtonPressed() {
    _userService.incrementAge();
    _updateState();
  }

  void onDerementButtonPressed() {
    _userService.decrementAge();
    _updateState();
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
    final viewModel = context.select((ViewModel value) => value.state.ageTitle);
    return Text(viewModel);
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onIncrementButtonPressed,
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
      onPressed: viewModel.onDerementButtonPressed,
      child: Text('-'),
    );
  }
}
