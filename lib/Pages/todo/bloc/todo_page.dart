import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Pages/todo/bloc/todo_bloc.dart';
import 'package:todo_bloc/Pages/todo/dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todo_bloc/Pages/todo/updateDialog.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent());
    super.initState();
  }

  List sharedstorage = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        actions: [
          IconButton(
              onPressed: () async {
                // Navigator.pushNamed(context, '/emp');
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you Sure to Delete All Todos"),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(ClearAllTodoEvent());
                                  Navigator.pop(context);
                                },
                                child: const Text("Confirm"))
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.remove_circle))
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadedState) {
            return ListView.separated(
                // reverse: true,
                itemCount: state.alltodo.length,
                // itemExtent: 60,
                padding: const EdgeInsets.all(20),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  var sd = json.decode(state.alltodo[index]);
                  print(sd.runtimeType);
                  return ListTile(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    title: Text("${sd["Task"]}"),
                    subtitle: Text("${sd["Dropdown"]} ${sd["Time"]} "),
                    leading: const Icon(Icons.add_task_rounded),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Confirmation to Delete Todo",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Want to Delete todo ?",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<TodoBloc>(context)
                                            .add(DeleteTodo(index));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Confirm')),
                                ],
                              )
                            ],
                          ),
                        ).then((value) => {
                              BlocProvider.of<TodoBloc>(context)
                                  .add(TodoLoadEvent())
                            })
                      },
                    ),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => UpdateDialogTodo(
                                task: sd,
                                index: index,
                              )).then((value) => {
                            BlocProvider.of<TodoBloc>(context)
                                .add(TodoLoadEvent())
                          });
                    },
                  );
                });
          } else {
            return Text("Loading");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const DialogTodo())
              .then((value) =>
                  BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
