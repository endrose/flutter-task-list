import 'package:flutter_task_list/model/add_task_request_model.dart';
import 'package:flutter_task_list/model/add_task_response_model.dart';
import 'package:flutter_task_list/model/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDataSource {
  Future<TasksResponseModel> getTasks() async {
    // source
    final response = await http.get(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
    );
    print(response);
    if (response.statusCode == 200) {
      return TasksResponseModel.fromJson(response.body);
    } else {
      return throw Exception('Failed to load tasks');
    }
  }

  Future<AddTasksResponseModel> addTasks(AddTasksRequestModel data) async {
    final response = await http.post(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
      body: data.toJson(),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return AddTasksResponseModel.fromJson(response.body);
    } else {
      return throw Exception('Failed to add task');
    }
  }

  Future<AddTasksResponseModel> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return AddTasksResponseModel.fromJson(response.body);
    } else {
      return throw Exception('Failed to delete task');
    }
  }

  Future<AddTasksResponseModel> updateTask(
      int id, AddTasksRequestModel data) async {
    final response = await http.put(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
      headers: {"Content-Type": "application/json"},
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return AddTasksResponseModel.fromJson(response.body);
    } else {
      return throw Exception('Failed to edit task');
    }
  }
}
