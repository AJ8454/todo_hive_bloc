part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final String username;

  const LoadTodosEvent(this.username);
  
  @override
  List<Object> get props => [username];
}
