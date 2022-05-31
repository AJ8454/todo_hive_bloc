import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_hive_bloc/services/authentication.dart';
import 'package:todo_hive_bloc/services/todo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  LoginBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginAuthEvent>((event, emit) async {
      final user = _auth.authenticateUser(event.userName, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(username: user));
        emit(const LoginInitial());
      }
    });

    on<RegisteringServiceEvent>(
      (event, emit) async {
        await _auth.init();
        await _todo.init();

        emit(const LoginInitial());
      },
    );
  }
}
