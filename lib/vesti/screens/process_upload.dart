import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app_2/vesti/screens/information_check.dart';

class ProcessingUploadScreen extends StatefulWidget {
  const ProcessingUploadScreen({super.key});

  @override
  _ProcessingUploadScreenState createState() => _ProcessingUploadScreenState();
}

class _ProcessingUploadScreenState extends State<ProcessingUploadScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InformationCheckScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Passport Document',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Processing Upload',
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff518C36),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25.h),
            Text(
                'Please wait as we process your upload. This may take a few seconds'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
