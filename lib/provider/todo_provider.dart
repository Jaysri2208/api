import 'package:flutter/material.dart';
import 'package:provider_api_call_example/model/todo.dart';
import 'package:provider_api_call_example/services/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  final TodoService _service = TodoService();
  bool isLoading = false;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getAll();

      _todos = response;
    } catch (e) {
      // Handle error appropriately, e.g., show error message
      print('Error fetching todos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Todo> fetchTodo() async {
    try {
      // Replace with your logic to fetch a single todo
      final todo = await _service.getTodo(); // Example method to get a single todo
      return todo;
    } catch (e) {
      print('Error fetching todo: $e');
      throw e; // Rethrow the error to handle it in the UI
    }
  }
}
