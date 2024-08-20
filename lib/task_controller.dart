// lib/controllers/task_controller.dart

import 'dart:convert';
import 'package:flutter_proj/task_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends GetxController {
  var todos = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void addTask(String title) {
    final newTodo = Task(id: DateTime.now().toString(), title: title);
    todos.add(newTodo);
    saveTodos();
  }

  void deleteTask(String id) {
    todos.removeWhere((element) => element.id == id);
    saveTodos();
  }

  void updateTask(String id, String newTitle) {
    var index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      todos[index].title = newTitle;
      saveTodos();
    }
  }

  void toggleTaskStatus(String id) {
    var index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      todos[index].isDone = !todos[index].isDone;
      saveTodos();
    }
  }

  void saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList =
        todos.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList('todos', todoList);
  }

  void loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      todos.value =
          todoList.map((item) => Task.fromJson(json.decode(item))).toList();
    }
  }
}
