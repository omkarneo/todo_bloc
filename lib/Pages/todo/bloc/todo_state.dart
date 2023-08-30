part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoCreatedState extends TodoState {}

class InputValidState extends TodoState {}

class TodoNotLoadedState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List alltodo;
  const TodoLoadedState(this.alltodo);
  @override
  List<Object> get props => [alltodo];
}

class TodoErrorState extends TodoState {
  final String errormessage;
  const TodoErrorState(this.errormessage);
  @override
  List<Object> get props => [];
}
