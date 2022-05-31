import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive_bloc/login/login_bloc/login_bloc.dart';
import 'package:todo_hive_bloc/services/authentication.dart';
import 'package:todo_hive_bloc/services/todo.dart';
import 'package:todo_hive_bloc/todos/todos.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final userNameField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Todo'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisteringServiceEvent()),
        child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state is SuccessfulLoginState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodosPage(username: state.username),
            ));
          }
          if (state is LoginInitial) {
            if (state.error != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: const Text('Error'), content: Text(state.error!)),
              );
            }
          }
        }, builder: (context, state) {
          if (state is LoginInitial) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: userNameField,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextField(
                      controller: passwordField,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              BlocProvider.of<LoginBloc>(context).add(
                            LoginAuthEvent(
                                userNameField.text, passwordField.text),
                          ),
                          child: const Text('LOGIN'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              BlocProvider.of<LoginBloc>(context).add(
                            RegisterAccountEvent(
                                userNameField.text, passwordField.text),
                          ),
                          child: const Text('REGISTER'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
