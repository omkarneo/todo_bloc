part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoLoadEvent extends TodoEvent {}

class CreateTodo extends TodoEvent {
  final String task;
  final String location;
  final String time;

  const CreateTodo(this.task, this.location, this.time);
  List<Object> get props => [task, location, time];
}

class DeleteTodo extends TodoEvent {
  final int index;

  const DeleteTodo(this.index);
  List<Object> get props => [index];
}

class ClearAllTodoEvent extends TodoEvent {
  List<Object> get props => [];
}

class UpdateTodo extends TodoEvent {
  final String task;
  final String location;
  final String time;
  final int index;

  const UpdateTodo(this.task, this.location, this.time, this.index);
  List<Object> get props => [task, location, time];
}
