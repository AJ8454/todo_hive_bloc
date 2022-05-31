import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive_bloc/services/todo.dart';
import 'package:todo_hive_bloc/todos/todos_bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key, this.username}) : super(key: key);

  final String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(username!)),
        child: BlocBuilder(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: state.tasks
                    .map(
                      (e) => ListTile(
                        title: Text(e.task!),
                        trailing: Checkbox(
                          value: e.completed,
                          onChanged: (val) {},
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
