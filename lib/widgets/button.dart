import 'package:flutter/material.dart';
import 'package:todo_app_with_api/styles/colors.dart';

Widget customButton({
  VoidCallback? tap,
  bool? status = false,
  String? text = 'Save',
  bool? isValid = false,
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Container(
      alignment: Alignment.center,
      height: 48,
      width: MediaQuery.of(context!).size.width,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: status == false ? primaryColor : grey,
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        status == false ? text! : 'Please wait...',
        style: TextStyle(
          color: white,
          fontSize: 18,
        ),
      ),
    ),
  );
}
