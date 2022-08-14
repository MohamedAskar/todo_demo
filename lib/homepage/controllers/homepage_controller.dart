import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_demo/homepage/models/todo_model.dart';
import 'package:http/http.dart' as http;

const url = 'https://jsonplaceholder.typicode.com/todos';
final homeProvider =
    ChangeNotifierProvider<HomePageProvider>((ref) => HomePageProvider());

class HomePageProvider extends ChangeNotifier {
  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;

  HomePageProvider() {
    getTodos();
  }

  Future getTodos() async {
    log('Requesting todos');
    final response = await http.get(Uri.parse(url));
    _todoList = List<TodoModel>.from(
        json.decode(response.body).map((x) => TodoModel.fromJson(x)));
    log('Received ${_todoList.length} todos');
    notifyListeners();
  }

  void addTodo(String title) {
    final todo = TodoModel(
      userId: 1,
      id: _todoList.length + 1,
      title: title,
      completed: false,
    );
    _todoList.insert(0, todo);
    notifyListeners();
  }
}
