import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  Image image;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      this.phoneNumber,
      required this.image,});
}
