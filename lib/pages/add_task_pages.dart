import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/datasource/task_remote_datasource.dart';
import 'package:flutter_task_list/model/add_task_request_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // titleController
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Task',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
                hintText: 'Description', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              final model = AddTasksRequestModel(
                data: Data(
                    title: titleController.text,
                    description: descriptionController.text),
              );
              final response = await TaskRemoteDataSource().addTasks(model);
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
