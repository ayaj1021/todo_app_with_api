import 'package:flutter/material.dart';
import 'package:todo_app_with_api/styles/colors.dart';

void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(
      message!,
      style: TextStyle(color: white),
    ),
    backgroundColor: primaryColor,
  ));
}

// void errorMessage({String? message, BuildContext? context}) {
//   ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
//     content: Text(
//       message!,
//       style: TextStyle(color: white),
//     ),
//     backgroundColor: Colors.red,
//   ));
// }
