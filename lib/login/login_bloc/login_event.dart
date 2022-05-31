part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginAuthEvent extends LoginEvent {
  final String userName;
  final String password;

  const LoginAuthEvent(this.userName, this.password);

  @override
  List<Object?> get props => [userName, password];
}

class RegisteringServiceEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
