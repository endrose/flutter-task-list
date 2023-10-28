import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/datasource/task_remote_datasource.dart';

import 'package:flutter_task_list/model/task_response_model.dart';
import 'package:flutter_task_list/pages/edit_task_pages.dart';
import 'package:flutter_task_list/pages/home_pages.dart';

class DetailTask extends StatefulWidget {
  final Task task;
  const DetailTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Detail Tasks",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          children: [
            Text('Title : ${widget.task.attributes.title} '),
            const SizedBox(
              height: 16,
            ),
            Text('Description : ${widget.task.attributes.description}'),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(100, 40),
                    foregroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditTask(
                          task: widget.task,
                        );
                      }),
                    );
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(100, 40),
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                            "Are youe want to delete this tasks",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await TaskRemoteDataSource().deleteTask(
                                  widget.task.id,
                                );
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ));
                              },
                              child: const Text('Yes'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
