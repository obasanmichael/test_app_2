import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffEAEAEA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffEAEAEA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffEAEAEA)),
        ),
        filled: true,
        fillColor: Color(0xffF9FAF9),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Color(0xff98A2B3),
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        fontSize: 16.sp,
        color: Color(0xff98A2B3),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
