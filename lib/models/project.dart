// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

ProjectDetail projectFromJson(String str) =>
    ProjectDetail.fromJson(json.decode(str));

String projectToJson(ProjectDetail data) => json.encode(data.toJson());

class ProjectDetail {
  String? id;
  String? title;
  String? description;
  dynamic cover;
  DateTime? startDate;
  DateTime? endDate;
  String? region;
  String? district;
  dynamic ward;
  String? budget;
  String? status;
  DateTime? createdAt;
  String? manager;
  List<Task>? tasks;

  ProjectDetail({
    this.id,
    this.title,
    this.description,
    this.cover,
    this.startDate,
    this.endDate,
    this.region,
    this.district,
    this.ward,
    this.budget,
    this.status,
    this.createdAt,
    this.manager,
    this.tasks,
  });

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => ProjectDetail(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        cover: json["cover"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        region: json["region"],
        district: json["district"],
        ward: json["ward"],
        budget: json["budget"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        manager: json["manager"],
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "cover": cover,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "region": region,
        "district": district,
        "ward": ward,
        "budget": budget,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "manager": manager,
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Task {
  String? id;
  List<TaskItem>? taskItems;
  String? number;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  String? progressPercentage;
  String? status;
  DateTime? createdAt;

  Task({
    this.id,
    this.taskItems,
    this.number,
    this.title,
    this.startDate,
    this.endDate,
    this.description,
    this.progressPercentage,
    this.status,
    this.createdAt,
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
        progressPercentage: json["progressPercentage"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "progressPercentage": progressPercentage,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
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
  DateTime? createdAt;
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
    this.createdAt,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "task": task,
      };
}
