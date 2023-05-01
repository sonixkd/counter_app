import 'package:counter_app/domain/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    await _userService.initialization();
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

  void onResetButtonPressed() {
    _userService.resetAge();
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
            children: [
              _AgeTitle(),
              SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AgeIncrementWidget(),
                  SizedBox(width: 20),
                  _AgeDecrementWidget(),
                ],
              ),
              SizedBox(height: 10),
              _AgeResetWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.select((ViewModel value) => value.state.ageTitle);
    return Text(
      viewModel,
      style: TextStyle(fontSize: 70),
    );
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onIncrementButtonPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 30),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(10),
      ),
      child: Text('+'),
    );
  }
}

class _AgeDecrementWidget extends StatelessWidget {
  const _AgeDecrementWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onDerementButtonPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 30),
        padding: EdgeInsets.all(10),
      ),
      child: Text('-'),
    );
  }
}

class _AgeResetWidget extends StatelessWidget {
  const _AgeResetWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
      onPressed: viewModel.onResetButtonPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 35),
        backgroundColor: Color.fromARGB(255, 205, 21, 76),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      ),
      child: Text('Reset'),
    );
  }
}
