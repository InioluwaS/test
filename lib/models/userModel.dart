import 'package:flutter/material.dart';

class UserModel with ChangeNotifier{
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  UserModel({ @required this.firstName, @required this.lastName, @required this.phoneNumber, @required this.email});
}
