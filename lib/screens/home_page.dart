import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api_call_example/model/todo.dart';
import 'package:provider_api_call_example/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Todo> futureTodo;

  @override
  void initState() {
    super.initState();
    futureTodo = Provider.of<TodoProvider>(context, listen: false).fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API Example'),
      ),
      body: Center(
        child: FutureBuilder<Todo>(
          future: futureTodo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data found');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Product ID: ${snapshot.data!.id}'),
                  Text('Title: ${snapshot.data!.title}'),
                  Text('Description: ${snapshot.data!.description}'),
                  Text('Price: \$ ${snapshot.data!.price}'),
                  Text('Discount Percentage: ${snapshot.data!.discountPercentage}%'),
                  Text('Rating: ${snapshot.data!.rating}'),
                  Text('Stock: ${snapshot.data!.stock}'),
                  Text('Brand: ${snapshot.data!.brand}'),
                  Text('Category: ${snapshot.data!.category}'),
                  Image.network(snapshot.data!.thumbnail),
                  Text('Images:'),
                  Column(
                    children: snapshot.data!.images.map((url) => Image.network(url)).toList(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
