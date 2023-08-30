import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoLoadEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List? alltodos = prefs.getStringList("todo");
      if (alltodos == null) {
        prefs.setStringList("todo", []);
      } else {
        emit(TodoLoadedState(alltodos));
      }
    });
    on<CreateTodo>((event, emit) async {
      Map data = {
        "Task": event.task,
        "Time":
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        "Dropdown": event.location,
      };
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? alltodo = prefs.getStringList('todo');
      if (alltodo == null) {
        prefs.setStringList("todo", []);
      } else {
        String encode = json.encode(data);
        alltodo.add(encode);
        prefs.setStringList("todo", alltodo);
      }
    });
    on<DeleteTodo>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? alltodo = prefs.getStringList('todo');
      if (alltodo == null) {
        prefs.setStringList("todo", []);
      } else {
        alltodo.removeAt(event.index);
        prefs.setStringList("todo", alltodo);
      }
    });
    on<UpdateTodo>((event, emit) async {
      Map data = {
        "Task": event.task,
        "Time": event.time,
        "Dropdown": event.location,
      };
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? alltodo = prefs.getStringList('todo');
      if (alltodo == null) {
        prefs.setStringList("todo", []);
      } else {
        String encode = json.encode(data);
        alltodo[event.index] = encode;
        prefs.setStringList("todo", alltodo);
      }
    });
    on<ClearAllTodoEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Remove data for the 'counter' key.
      await prefs.remove('todo');
      List? alltodos = prefs.getStringList("todo");

      if (alltodos == null) {
        prefs.setStringList("todo", []);
        List? Cleardata = prefs.getStringList("todo");
        emit(TodoLoadedState(Cleardata!));
      } else {
        emit(TodoLoadedState(alltodos));
      }
    });
  }
}
