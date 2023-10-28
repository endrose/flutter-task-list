import 'dart:convert';

class AddTasksRequestModel {
  final Data data;

  AddTasksRequestModel({
    required this.data,
  });

  factory AddTasksRequestModel.fromJson(String str) =>
      AddTasksRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddTasksRequestModel.fromMap(Map<String, dynamic> json) =>
      AddTasksRequestModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  final String title;
  final String description;

  Data({
    required this.title,
    required this.description,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
