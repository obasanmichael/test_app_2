import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app_2/vesti/widgets/button.dart';
import 'package:test_app_2/vesti/widgets/textfield.dart';
import 'package:test_app_2/vesti/widgets/upload_success.dart';

class InformationCheckScreen extends StatefulWidget {
  const InformationCheckScreen({super.key});

  @override
  _InformationCheckScreenState createState() => _InformationCheckScreenState();
}

class _InformationCheckScreenState extends State<InformationCheckScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _passportNumberController;
  late TextEditingController _dobController;
  late TextEditingController _expirationDateController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _passportNumberController = TextEditingController();
    _dobController = TextEditingController();
    _expirationDateController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passportNumberController.dispose();
    _dobController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    Widget addHeight(double height) => SizedBox(height: height.h);
    Widget addWidth(double width) => SizedBox(width: width.w);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review your Passport Photo',
              style: TextStyle(
                color: Color(0xff518C36),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            addHeight(16),
            Text(
              'Please make sure the information below is exactly as it appears on your passport',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
            ),
            addHeight(32),
            MyTextField(
              labelText: 'First Name',
              controller: _firstNameController,
            ),
            addHeight(16),
            MyTextField(
              labelText: 'Last Name',
              controller: _lastNameController,
            ),
            addHeight(16),
            MyTextField(
              labelText: 'Passport Number',
              controller: _passportNumberController,
            ),
            addHeight(16),
            MyTextField(
              labelText: 'Date of Birth',
              controller: _dobController,
            ),
            addHeight(16),
            MyTextField(
              labelText: 'Expiration Date',
              controller: _expirationDateController,
            ),
            Spacer(),
            MyButton(
              label: 'Accept and Upload',
              onPressed: openUploadSuccessModal,
            ),
            addHeight(13),
          ],
        ),
      ),
    );
  }
}
