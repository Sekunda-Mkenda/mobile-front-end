// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? mobile;
  dynamic profile;
  String? role;
  String? gender;
  bool? isActive;
  dynamic deviceId;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserProfile({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.mobile,
    this.profile,
    this.role,
    this.gender,
    this.isActive,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
        deviceId: json["device_id"],
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
        "device_id": deviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
