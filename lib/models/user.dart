import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String? image;
  @HiveField(4)
  DateTime? birthDay;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.image,
      required this.birthDay});

  factory User.fromJson(Map<String, dynamic> data) => User(
      id: data['id'],
      fullName: data["fullName"],
      email: data["email"],
      image: data['image']['url'],
      birthDay: DateTime.tryParse(data['age']));
}

User userFromJson(String str) => User.fromJson(jsonDecode(str));
