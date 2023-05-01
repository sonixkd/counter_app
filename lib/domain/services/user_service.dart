import 'package:counter_app/domain/data_providers/user_data_provider.dart';
import 'package:counter_app/domain/entity/user.dart';

class UserServise {
  final _userDataProvider = UserDataProvider();
  var _user = User(0);
  User get user => _user;

  Future<void> initialization() async {
    _userDataProvider.loadAge();
    _user = await _userDataProvider.loadAge();
  }

  void incrementAge() {
    _user.age++;
    _userDataProvider.saveAge(_user);
  }

  void decrementAge() {
    _user.age--;
    _userDataProvider.saveAge(_user);
  }

  void resetAge() {
    _user.age = 0;
    _userDataProvider.saveAge(_user);
  }
}
