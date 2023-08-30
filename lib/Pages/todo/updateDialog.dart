import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Pages/todo/bloc/todo_bloc.dart';

class UpdateDialogTodo extends StatefulWidget {
  final Map<String, dynamic> task;
  final int index;
  const UpdateDialogTodo({required this.task, required this.index, super.key});

  @override
  State<UpdateDialogTodo> createState() => _UpdateDialogTodoState();
}

class _UpdateDialogTodoState extends State<UpdateDialogTodo> {
  late Map data;

  @override
  void initState() {
    super.initState();
    print(widget.index);
    task.text = widget.task["Task"];
    data = {
      "Task": "",
      "Time": widget.task['Time'],
      "Location": widget.task['Dropdown'],
      "Changed": false
    };
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController task = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return Form(
      key: formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text("Add Task"),
        content: const Text("Add the Task for the List"),
        buttonPadding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        actions: [
          TextFormField(
            controller: task,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ("Please Enter Task");
              }
              return (null);
            },
          ),
          Row(
            children: [
              const Text("Location :- "),
              DropdownButton(
                value: data['Location'],
                // value: Text(data['Dropdown']),
                items: option
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => {
                  setState(() {
                    data["Location"] = value;
                    data['Time'] =
                        "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                  })
                },
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  data['Task'] = task.text;
                  print(data);
                  BlocProvider.of<TodoBloc>(context).add(UpdateTodo(
                      data["Task"],
                      data['Location'],
                      data['Time'],
                      widget.index));
                  Navigator.pop(context, data);
                }
              },
              child: const Text(
                "Add Task",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
