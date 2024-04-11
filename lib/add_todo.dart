import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb/todo.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});
  TextEditingController title = TextEditingController();
  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
                controller: title,
                decoration: const InputDecoration(
                    label: Text('Title goes here..'),
                    border: OutlineInputBorder())),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (title.text != '') {
                        Todo newTodo =
                            Todo(title: title.text, isCompleted: false);
                        todoBox.add(newTodo);
                        ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                            const SnackBar(content: Text("Todo Created")));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Add Todo',
                      style: TextStyle(fontSize: 16),
                    )))
          ]),
        ));
  }
}
