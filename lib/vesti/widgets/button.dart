import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.isLoading = false,
    this.disabled = false,
    this.loadingIndicator,
    this.child,
  });

  final Icon? icon;
  final String? label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final bool isLoading;
  final bool disabled;
  final Widget? loadingIndicator;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = backgroundColor ?? const Color(0xff67A948);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 17.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          backgroundColor: disabled ? Colors.grey : defaultColor,
        ),
        onPressed: disabled || isLoading ? null : onPressed,
        child: isLoading
            ? loadingIndicator ??
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
      ),
    );
  }
}
