import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'dialog_box.dart';
import 'todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //refrence hive box
  final TextEditingController _controller = TextEditingController();

  bool isDarkMode = false;

  List<Todo> todoList = [
    Todo('Làm bài tập Flutter', false),
    Todo('Học tiếng Nhật', false),
  ];

  void checkBoxChange({required bool? value, required int index}) {
    setState(() {
      todoList[index].completed = !todoList[index].completed;
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void saveNewTask() {
    {
      setState(() {
        todoList.add(Todo(
          _controller.text,
          false,
        ));
        _controller.clear();
        Navigator.of(context).pop();
      });
    }
  }

  void cancelNewTask() {
    {
      _controller.clear();
      Navigator.of(context).pop();
    }
  }

  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: cancelNewTask,
      ),
    );
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        // backgroundColor: Colors.purple[200],
        appBar: AppBar(
          title: Center(
            child: IconButton(
              iconSize: 72,
              icon: const Icon(Icons.brightness_6),
              onPressed: toggleTheme,
            ),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: todoList[index].title,
              isComplated: todoList[index].completed,
              onChange: (value) {
                checkBoxChange(index: index, value: value);
              },
              deleteFunction: (ctx) {
                deleteTask(index);
              },
            );
          },
        ),
      ),
    );
  }
}
