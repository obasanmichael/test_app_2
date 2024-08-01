import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app_2/vesti/providers/passport_provider.dart';
import 'package:test_app_2/vesti/screens/information_check.dart';
import 'package:test_app_2/vesti/widgets/text_tiles.dart';

class PassportUploadScreen extends ConsumerStatefulWidget {
  const PassportUploadScreen({super.key});

  @override
  _PassportUploadScreenState createState() => _PassportUploadScreenState();
}

class _PassportUploadScreenState extends ConsumerState<PassportUploadScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> attemptSelectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget addHeight(double height) => SizedBox(height: height.h);
    Widget addWidth(double width) => SizedBox(width: width.w);

    // final passportUploadState = ref.watch(passportNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Passport Document',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Always have your Passport photo\nhandy!',
              style: TextStyle(
                  color: Color(0xff518C36),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
            addHeight(16),
            Text(
              'Upload a copy of your passport and access it easily anytime you need it.',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
            ),
            addHeight(25),
            DottedBorder(
              padding: EdgeInsets.all(20),
              borderType: BorderType.RRect,
              radius: Radius.circular(15.r),
              color: Colors.grey,
              strokeWidth: 2,
              dashPattern: [6, 6],
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: _image == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 30,
                              color: Color(0xff3E6F26),
                            ),
                            addHeight(10),
                            Text(
                              'Upload Passport image\nJpeg and PNG only | 2MB max size',
                              textAlign: TextAlign.center,
                            ),
                            addHeight(10),
                            TextButton(
                                onPressed: () async {
                                  attemptSelectImage();
                                },
                                child: Text(
                                  'Add image',
                                  style: TextStyle(
                                      color: Color(0xff67A948),
                                      fontSize: 14.sp),
                                ))
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Image.file(
                            File(_image!.path),
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
              ),
            ),
            addHeight(34.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xffF3F9FB),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(0xff98A2B3),
                        size: 20,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          'Please ensure the following before uploading your passport image:',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  addHeight(8),
                  TextTiles(
                    icon: Icon(
                      Icons.wb_sunny_outlined,
                      color: Color(0xff3E6F26),
                      size: 20,
                    ),
                    text: ' Use good lighting to avoid shadows or glare.',
                  ),
                  addHeight(8),
                  TextTiles(
                    icon: Icon(
                      Icons.card_travel_outlined,
                      color: Color(0xff3E6F26),
                      size: 20,
                    ),
                    text: ' The image must be clear and in focus.',
                  ),
                  addHeight(8),
                  TextTiles(
                    icon: Icon(
                      Icons.visibility_outlined,
                      color: Color(0xff3E6F26),
                      size: 20,
                    ),
                    text:
                        'All details, including text and photo, should be fully visible and readable. The image should be upright and not tilted.',
                  ),
                ],
              ),
            ),
            addHeight(30),
            passportUploadState.when(
              data: (_) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 17.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      )),
                      backgroundColor: Color(0xff67A948)),
                  onPressed: () async {
                    if (_image != null) {
                      // Replace these details with actual user input or state
                      const userId = 'a00a51da-0b33-4ad2-af77-b85ee1b95c45';
                      const firstName = 'Teni';
                      const lastName = 'Olawande';
                      const passportNumber = '3839393939';
                      const dateOfBirth = '10-2-1998';
                      const expirationDate = '10-2-2000';

                    await ref
                          .read(passportNotifierProvider.notifier)
                          .uploadPassportImage(
                            passportImagePath: _image!.path,
                          );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InformationCheckScreen()));
                    }
                  },
                  child: Text(
                    'Upload image',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}