import 'package:flutter/material.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/widgets/screen_part.dart';
import 'package:todoey/widgets/tasks_list.dart';
import 'package:todoey/modals/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(name: 'learn flutter'),
    Task(name: 'create app'),
    Task(name: 'deploy'),
  ];

  void addTask(String task) {
    setState(() {
      if (task.length != 0) {
        tasks.add(Task(name: task));
      }
    });
    Navigator.pop(context);
  }

  void deleteTask(index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppView(taskLength: tasks.length),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TaskList(
                tasks: tasks,
                callback: (index) {
                  setState(() {
                    tasks[index].toggleDone();
                  });
                },
                deleteTask: deleteTask,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(callback: addTask),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
