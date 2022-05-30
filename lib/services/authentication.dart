import 'package:hive/hive.dart';
import 'package:todo_hive_bloc/model/user.dart';

class Authentication {
  Box<User>? _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
  }

  String? authenticateUser(final String username, final String password) {
    final success = _users!.values.any((element) =>
        element.userName == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
