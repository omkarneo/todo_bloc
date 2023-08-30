import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/Pages/todo/bloc/todo_page.dart';
import 'dart:async';

import 'Pages/todo/bloc/todo_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        title: "Todo App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routes: {
          "/": (context) => const FirstPage(),
          "/todo": (context) => const TodoList(),
        },
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 1);
    Timer(
      duration,
      () => Navigator.pushReplacementNamed(context, '/todo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 150),
              Text(
                "Todo App",
                style: TextStyle(fontSize: 50),
              ),

              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, "/todo");
              //     },
              //     child: const Text("Lets Todo"))
            ]),
      ),
    );
  }
}
