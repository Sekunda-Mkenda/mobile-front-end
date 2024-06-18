// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? token;
  UserData? user;

  User({
    this.token,
    this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class UserData {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? mobile;
  bool? isActive;
  dynamic profile;
  String? role;
  String? gender;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.mobile,
    this.isActive,
    this.profile,
    this.role,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        profile: json["profile"],
        role: json["role"],
        gender: json["gender"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "profile": profile,
        "role": role,
        "gender": gender,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
