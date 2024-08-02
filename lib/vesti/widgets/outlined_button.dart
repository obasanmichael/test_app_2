import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton(
      {super.key, required this.label, this.icon, required this.onPressed});

  final Icon? icon;
  final String label;
  final void Function() onPressed;
  // final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(color: Color(0xff3E6F26)),
            padding: EdgeInsets.symmetric(vertical: 17.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            )),
            backgroundColor: Colors.white),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            if (icon != null) SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Color(0xff3E6F26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
