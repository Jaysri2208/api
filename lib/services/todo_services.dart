import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api_call_example/model/todo.dart';

class TodoService {
  Future<List<Todo>> getAll() async {
    const url = 'https://dummyjson.com/products/1'; // Replace with your API endpoint
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json.map((e) {
        return Todo(
          id: e['id'],
          title: e['title'],
          description: e['description'],
          price: e['price'],
          discountPercentage: e['discountPercentage'],
          rating: e['rating'],
          stock: e['stock'],
          brand: e['brand'],
          category: e['category'],
          thumbnail: e['thumbnail'],
          images: List<String>.from(e['images']),
        );
      }).toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> getTodo() async {
    const url = 'https://dummyjson.com/product/1'; // Replace with your API endpoint
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final todo = Todo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountPercentage: json['discountPercentage'],
        rating: json['rating'],
        stock: json['stock'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: List<String>.from(json['images']),
      );
      return todo;
    } else {
      throw Exception('Failed to load todo');
    }
  }
}
