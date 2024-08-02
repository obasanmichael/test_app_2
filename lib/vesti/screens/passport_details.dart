import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PassportDetailScreen extends StatefulWidget {
  const PassportDetailScreen({super.key});

  @override
  State<PassportDetailScreen> createState() => _PassportDetailScreenState();
}

class _PassportDetailScreenState extends State<PassportDetailScreen> {
  Widget addHeight(double height) => SizedBox(height: height.h);
  Widget addWidth(double width) => SizedBox(width: width.w);
  final Map<String, bool> copiedStatus = {
    'firstName': false,
    'lastName': false,
    'passportNumber': false,
    'expiryDate': false,
  };

  void copyToClipboard(String text, String field) {
    Clipboard.setData(ClipboardData(text: text));
    setState(() {
      copiedStatus[field] = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        copiedStatus[field] = false;
      });
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
          'Password Document',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        child: Column(
          children: [
            Container(
              height: 216.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            addHeight(7),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete_outlined,
                        color: Color(0xffF04438),
                      ),
                      addWidth(2),
                      Text(
                        'Delete Passport',
                        style: TextStyle(color: Color(0xffF04438)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            addHeight(42),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffDFFFD0),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        height: 60.h,
                        width: 60.h,
                        child: Center(
                          child: SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: SvgPicture.asset(
                              'assets/svg/download.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    addHeight(10),
                    Text('Save')
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFBF3FF),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        height: 55.h,
                        width: 55.h,
                        child: Icon(Icons.visibility_outlined, color: Colors.purple,)
                      ),
                    ),
                    addHeight(10),
                    Text('View Passport')
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF6F7FF),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        height: 60.h,
                        width: 60.h,
                        child: Icon(Icons.share_outlined)
                      ),
                    ),
                    addHeight(10),
                    Text('Share')
                  ],
                ),
                
              ],
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //             child: buildCopyableField(
            //               label: 'First Name',
            //               text: 'Mimi-stephanie',
            //               field: 'firstName',
            //               copied: copiedStatus['firstName']!,
            //             ),
            //           ),
            //           addWidth(25),
            //           Expanded(
            //             child: buildCopyableField(
            //               label: 'Last Name',
            //               text: 'Ugeh',
            //               field: 'lastName',
            //               copied: copiedStatus['lastName']!,
            //             ),
            //           ),
            //         ],
            //       ),
            //       addHeight(13),
            //       buildCopyableField(
            //         label: 'Passport Number',
            //         text: 'A123457890',
            //         field: 'passportNumber',
            //         copied: copiedStatus['passportNumber']!,
            //       ),
            //       addHeight(13),
            //       buildCopyableField(
            //         label: 'Expiry Date',
            //         text: '30 December 2030',
            //         field: 'expiryDate',
            //         copied: copiedStatus['expiryDate']!,
            //       ),
            //       Spacer(),
            //       buildActionButton(
            //           'Download Image', Color(0xff67A948), Icons.download),
            //       addHeight(14),
            //       MyOutlinedButton(
            //           label: 'Share Passport Image', onPressed: () {})
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCopyableField({
    required String label,
    required String text,
    required String field,
    required bool copied,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () => copyToClipboard(text, field),
          child: DottedBorder(
            color: copied ? Color(0xff67A948) : Color(0xff936710),
            borderType: BorderType.RRect,
            radius: Radius.circular(5.r),
            dashPattern: [6, 3],
            child: Container(
              height: 45.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 3.h),
              decoration: BoxDecoration(
                color: copied ? Color(0xffF7FFF3) : Color(0xffFFF9F0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: copied ? Color(0xff67A948) : Color(0xff936710),
                    ),
                  ),
                  Text(
                    copied ? '- Copied -' : '- Click to copy -',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: copied ? Color(0xff67A948) : Color(0xff936710),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActionButton(String label, Color color, IconData icon,
      {bool border = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp),
          ),
          addWidth(3),
          Icon(
            icon,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
