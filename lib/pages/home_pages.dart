import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/datasource/task_remote_datasource.dart';
import 'package:flutter_task_list/model/task_response_model.dart';
import 'package:flutter_task_list/pages/add_task_pages.dart';
import 'package:flutter_task_list/pages/detail_task_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Task> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
    });
    final model = await TaskRemoteDataSource().getTasks();
    print(model);
    tasks = model.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Task List",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DetailTask(
                          task: tasks[index],
                        );
                      },
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        tasks[index].attributes.title,
                      ),
                      subtitle: Text('Description $index'),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddTask();
            },
          ));
          getTasks();
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
