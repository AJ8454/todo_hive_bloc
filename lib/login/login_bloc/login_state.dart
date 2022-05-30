part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}


class LoginInitial extends LoginState {
  final bool? success;
  const LoginInitial({this.success});

  @override
  List<Object?> get props => [success];
}

