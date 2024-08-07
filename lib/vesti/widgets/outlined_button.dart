import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    super.key,
    this.label,
    this.icon,
    required this.onPressed,
    this.borderColor,
    this.isLoading = false,
    this.disabled = false,
    this.loadingIndicator,
    this.child,
  });

  final Icon? icon;
  final String? label;
  final void Function()? onPressed;
  final Color? borderColor;
  final bool isLoading;
  final bool disabled;
  final Widget? loadingIndicator;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Color defaultBorderColor = borderColor ?? const Color(0xff3E6F26);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: disabled ? Colors.grey : defaultBorderColor),
          padding: EdgeInsets.symmetric(vertical: 17.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: disabled || isLoading ? null : onPressed,
        child: isLoading
            ? loadingIndicator ??
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: disabled ? Colors.grey : defaultBorderColor,
                  ),
                )
            : child ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) icon!,
                    if (icon != null) SizedBox(width: 10.w),
                    if (label != null)
                      Text(
                        label!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: defaultBorderColor,
                        ),
                      ),
                  ],
                ),
      ),
    );
  }
}
