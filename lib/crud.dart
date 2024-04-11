import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  Box friendBox = Hive.box('friend');
  String? name;
  addFriend() async {
    await friendBox.put('name', 'Tony Stark');
  }

  getFriend() async {
    setState(() {
      name = friendBox.get('name');
    });
  }

  updateFriend() async {
    await friendBox.put('name', 'Thor');
  }

  deleteFriend() async {
    friendBox.delete('name');
    print("Friend Deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HIVE DB"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  addFriend();
                  print("Friend Created");
                },
                child: Text("Create")),
            ElevatedButton(
                onPressed: () {
                  getFriend();
                  print('Name: ${name!}');
                },
                child: Text((name == null) ? "Read" : name!)),
            ElevatedButton(
                onPressed: () {
                  updateFriend();
                },
                child: Text("Update")),
            ElevatedButton(
                onPressed: () {
                  deleteFriend();
                },
                child: Text("Delete"))
          ],
        ),
      ),
    );
  }
}
