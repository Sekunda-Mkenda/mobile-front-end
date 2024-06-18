// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String? id;
  List<TaskItem>? taskItems;
  String? number;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  String? weight;
  String? status;

  Task({
    this.id,
    this.taskItems,
    this.number,
    this.title,
    this.startDate,
    this.endDate,
    this.description,
    this.weight,
    this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        taskItems: json["task_items"] == null
            ? []
            : List<TaskItem>.from(
                json["task_items"]!.map((x) => TaskItem.fromJson(x))),
        number: json["number"],
        title: json["title"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        description: json["description"],
        weight: json["weight"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_items": taskItems == null
            ? []
            : List<dynamic>.from(taskItems!.map((x) => x.toJson())),
        "number": number,
        "title": title,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "weight": weight,
        "status": status,
      };
}

class TaskItem {
  String? id;
  dynamic attachment;
  String? title;
  String? description;
  String? type;
  String? amount;
  int? quantity;
  String? unit;
  String? task;

  TaskItem({
    this.id,
    this.attachment,
    this.title,
    this.description,
    this.type,
    this.amount,
    this.quantity,
    this.unit,
    this.task,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        id: json["id"],
        attachment: json["attachment"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        amount: json["amount"],
        quantity: json["quantity"],
        unit: json["unit"],
        task: json["task"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attachment": attachment,
        "title": title,
        "description": description,
        "type": type,
        "amount": amount,
        "quantity": quantity,
        "unit": unit,
        "task": task,
      };
}
