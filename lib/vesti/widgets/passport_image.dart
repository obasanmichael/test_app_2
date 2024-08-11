import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassportImage extends StatelessWidget {
  final File passportImage;
  final VoidCallback onCancel;

  const PassportImage({
    required this.passportImage,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Center(
            child: Image.file(
              height: 200.h,
              width: double.infinity,
              passportImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFEE4E2),
              ),
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Color(0xffD92D20),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
