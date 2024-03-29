import 'package:flutter/material.dart';
import 'package:todo_app_with_api/styles/colors.dart';

Widget customTextField({
  String? title,
  String? hint,
  TextEditingController? controller,
  int? maxLines = 1,
}) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightGrey,
        ),
        child: TextFormField(
          autocorrect: false,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      )
    ],
  );
}
