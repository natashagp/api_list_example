import 'package:api_list_example/models/todo_model.dart';
import 'package:dio/dio.dart';

class TodoRepository {
  static Future fetchTodos() async {
    final url = "https://jsonplaceholder.typicode.com/todos";

    try {
      final response = await Dio().get(url);
      final list = response.data as List;
      return list.map((json) => TodoModel.fromJson(json)).toList();
    } catch (e) {
      return e;
    }
  }
}
