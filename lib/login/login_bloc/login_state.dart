part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object?> get props => [];
}

class RegisteringServiceState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessfulLoginState extends LoginState {
  final String? username;
  const SuccessfulLoginState({this.username});

  @override
  List<Object?> get props => [username];
}
