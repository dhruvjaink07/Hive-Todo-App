import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb/add_todo.dart';
import 'package:hivedb/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box todoBox = Hive.box<Todo>('todo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Todo"),
      ),
      body: ValueListenableBuilder(
          // the .listenable() method is only available in hive_flutter package
          valueListenable: todoBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text("No Todo Available!"),
              );
            } else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: box.length,
                  itemBuilder: ((context, index) {
                    Todo todo = box.getAt(index);
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                todo.isCompleted ? Colors.green : Colors.black,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      leading: Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors
                                    .green; // Fill color when the checkbox is selected
                              }
                              return Colors
                                  .white; // Fill color when the checkbox is not selected
                            },
                          ),
                          value: todo.isCompleted,
                          onChanged: (value) {
                            Todo newTodo =
                                Todo(title: todo.title, isCompleted: value!);

                            box.putAt(index, newTodo);
                          }),
                      trailing: IconButton(
                          onPressed: () {
                            box.deleteAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Todo Deleted Successfully!")));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    );
                  }));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
