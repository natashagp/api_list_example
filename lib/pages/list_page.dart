import 'package:api_list_example/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final controller = HomeController();

  _success() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          var todo = controller.todos[index];
          return Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (bool? value) {},
              ),
              title: Text(todo.title),
            ),
          );
        },
      ),
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        child: Text('Tentar novamente'),
        onPressed: () {
          controller.start();
        },
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de ToDos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.start();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, index) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
