import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app_2/vesti/screens/passport_details.dart';
import 'package:test_app_2/vesti/widgets/button.dart';

class UploadSucessModal extends StatelessWidget {
  const UploadSucessModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
      // height: 400.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Color(0xff2B5219),
                  )),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/ani.gif',
              height: 100.h,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'Passport Uploaded Successfully',
            style: TextStyle(
                fontSize: 18.h,
                color: Color(0xff62943B),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          Text(
            textAlign: TextAlign.center,
            'Your Passport image has been uploaded successfully. You can now access it from your profile page',
            style: TextStyle(
                color: Color(0xff2B5219),
                fontSize: 14.sp,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 20.h),
          MyButton(
              label: 'View',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PassportDetailScreen()));
              }),
              SizedBox(height: 10.h)
        ],
      ),
    );
  }
}
