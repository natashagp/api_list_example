import 'package:api_list_example/models/todo_model.dart';
import 'package:api_list_example/repositories/todo_repository.dart';
import 'package:flutter/material.dart';

class HomeController {
  List<TodoModel> todos = [];
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await TodoRepository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
