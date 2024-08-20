import 'package:flutter/material.dart';
import 'package:flutter_proj/chat_view.dart';
import 'package:flutter_proj/task_controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: ChatScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: taskController.todos.length,
                    itemBuilder: (context, index) {
                      final todo = taskController.todos[index];

                      return ListTile(
                        title: Text(todo.title,
                            style: TextStyle(
                                color: Colors.black,
                                decoration: todo.isDone
                                    ? TextDecoration.lineThrough
                                    : null)),
                        leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (value) {
                              taskController.toggleTaskStatus(todo.id);
                            }),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: () {
                              taskController.deleteTask(todo.id);
                            }),
                        onTap: () {
                          textEditingController.text = todo.title;
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Edit Todo'),
                                  content: TextField(
                                    controller: textEditingController,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter a new title'),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cacncel')),
                                    TextButton(
                                      onPressed: () {
                                        taskController.updateTask(todo.id,
                                            textEditingController.text);
                                        Get.back();
                                      },
                                      child: const Text('update'),
                                    )
                                  ],
                                );
                              });
                        },
                      );
                    });
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a new todo Item'),
                  )),
                  ElevatedButton(
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty) {
                          taskController.addTask(textEditingController.text);
                          textEditingController.clear();
                        }
                      },
                      child: const Text('add'))
                ],
              ),
            )
          ],
        ));
  }
}
