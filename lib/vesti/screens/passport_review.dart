import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app_2/vesti/widgets/button.dart';
import 'package:test_app_2/vesti/widgets/outlined_button.dart';
import 'package:test_app_2/vesti/widgets/upload_success.dart';

class PassportReviewScreen extends StatelessWidget {
  const PassportReviewScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Widget addHeight(double height) => SizedBox(height: height.h);
    Widget addWidth(double width) => SizedBox(width: width.w);

    void openUploadSuccessModal() {
      showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: UploadSucessModal(),
            )
          ]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Password Document',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review your Passport Photo',
              style: TextStyle(
                  color: Color(0xff518C36),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
            addHeight(16),
            Text(
              'Please ensure all the Information and details on the passport are clear and visible before uploading.',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
            ),
            addHeight(67),
            Container(
              height: 216.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            addHeight(80),
            MyButton(
                label: 'Photo is clear and visible',
                onPressed: openUploadSuccessModal),
            addHeight(13),
            MyOutlinedButton(
                label: 'Use another photo',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
