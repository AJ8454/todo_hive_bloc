import 'package:hive/hive.dart';
import 'package:todo_hive_bloc/model/user.dart';

class AuthenticationService {
  Box<User>? _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');

    await _users!.clear();
    await _users!.add(User(userName: 'ajayPangare', password: '123456'));
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

  Future createUser(final String username, final String password) async {
    final alreadyExists = _users!.values.any(
      (element) => element.userName!.toLowerCase() == username.toLowerCase(),
    );
    if (alreadyExists) {
      return UserCreationResult.alreadyexists;
    }
    try {
      _users!.add(User(userName: username, password: password));
      return UserCreationResult.success;
    } on Exception {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult {
  success,
  failure,
  alreadyexists,
}
