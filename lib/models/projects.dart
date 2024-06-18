// To parse this JSON data, do
//
//     final projectList = projectListFromJson(jsonString);

import 'dart:convert';

ProjectList projectListFromJson(String str) =>
    ProjectList.fromJson(json.decode(str));

String projectListToJson(ProjectList data) => json.encode(data.toJson());

class ProjectList {
  Links? links;
  int? count;
  int? lastPage;
  int? current;
  List<ProjectsData>? data;

  ProjectList({
    this.links,
    this.count,
    this.lastPage,
    this.current,
    this.data,
  });

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        count: json["count"],
        lastPage: json["lastPage"],
        current: json["current"],
        data: json["data"] == null
            ? []
            : List<ProjectsData>.from(json["data"]!.map((x) => ProjectsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "count": count,
        "lastPage": lastPage,
        "current": current,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProjectsData {
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

  ProjectsData({
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
  });

  factory ProjectsData.fromJson(Map<String, dynamic> json) => ProjectsData(
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
      };
}

class Links {
  dynamic next;
  dynamic previous;

  Links({
    this.next,
    this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };
}
