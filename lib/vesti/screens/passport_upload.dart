import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_app_2/vesti/screens/passport_review.dart';
import 'package:test_app_2/vesti/widgets/passport_image.dart';
import 'package:test_app_2/vesti/widgets/text_tiles.dart';

class PassportUploadScreen extends ConsumerStatefulWidget {
  const PassportUploadScreen({super.key});

  @override
  _PassportUploadScreenState createState() => _PassportUploadScreenState();
}

class _PassportUploadScreenState extends ConsumerState<PassportUploadScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  
  Future<void> _selectImage(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.gallery) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      }
    } else if (status.isDenied) {
      _showPermissionDeniedDialog(source);
    } else if (status.isPermanentlyDenied) {
      _showPermissionPermanentlyDeniedDialog();
    }
  }


  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showPermissionDeniedDialog(ImageSource source) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text(
              'This app needs permission to access your ${source == ImageSource.gallery ? 'gallery' : 'camera'} to select a passport image.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _selectImage(source); // Re-attempt permission request
              },
            ),
          ],
        );
      },
    );
  }

  void _showPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Permanently Denied'),
          content: Text(
              'Permission to access your gallery or camera has been permanently denied. Please enable it in your device settings.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); 
              },
            ),
          ],
        );
      },
    );
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget addHeight(double height) => SizedBox(height: height.h);
    Widget addWidth(double width) => SizedBox(width: width.w);
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
              'Always have your international passport handy!',
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
            _image == null
                ? DottedBorder(
                    padding: EdgeInsets.all(20),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(15.r),
                    color: Colors.grey,
                    strokeWidth: 2,
                    dashPattern: [6, 6],
                    child: SizedBox(
                        width: double.infinity,
                        height: 200.h,
                        child: Center(
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
                                    _showImageSourceDialog(context);
                                  },
                                  child: Text(
                                    'Add image',
                                    style: TextStyle(
                                        color: Color(0xff67A948),
                                        fontSize: 14.sp),
                                  ))
                            ],
                          ),
                        )),
                  )
                : PassportImage(
                    passportImage: File(_image!.path),
                    onCancel: _removeImage,
                  ),
            addHeight(25.h),
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
                          'Please ensure the following before uploading your international passport:',
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
                      Icons.perm_identity_outlined,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 17.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    )),
                    backgroundColor: Color(0xff67A948)),
                onPressed: _image == null
                    ? null
                    : () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassportReviewScreen(
                                      imagePath: _image!.path,
                                    )));
                      },
                child: Text(
                  'Upload image',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
