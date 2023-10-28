import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/datasource/task_remote_datasource.dart';
import 'package:flutter_task_list/model/add_task_request_model.dart';

import 'package:flutter_task_list/model/task_response_model.dart';
import 'package:flutter_task_list/pages/home_pages.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.attributes.title;
    descriptionController.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
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
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () async {
                final newModel = AddTasksRequestModel(
                    data: Data(
                  title: titleController.text,
                  description: descriptionController.text,
                ));

                await TaskRemoteDataSource().updateTask(
                  widget.task.id,
                  newModel,
                );
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              },
              child: const Text("Edit"))
        ],
      ),
    );
  }
}
