import 'package:counter_app/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<User> loadAge() async {
    final age = (await sharedPreferences).getInt('age') ?? 0;
    return User(age);
  }

  Future<void> saveAge(User user) async {
    (await sharedPreferences).setInt('age', user.age);
  }
}
