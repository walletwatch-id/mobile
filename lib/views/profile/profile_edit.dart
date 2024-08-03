import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/auth.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/utils/transtition_fade.dart';
import 'package:walletwatch_mobile/common/widgets/custom_text_field.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/views/home/home.dart';

class ProfileEdit extends StatefulWidget {
  final VoidCallback refresh;
  const ProfileEdit(
      {super.key, required this.refresh});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    _loadPage();
    EasyLoading.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
  }

  void _loadPage() {
    _nameController.text = user.name;
    _emailController.text = user.email;
  }

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        final fUser = await fetchUser();

        if (fUser != null) {
          user = fUser;
          widget.refresh();
        }
        return;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: lightColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(
                  title: "Edit Profile",
                  textColor: darkColor,
                  popAction: () async {
                    final fUser = await fetchUser();

                    if (fUser != null) {
                      user = fUser;
                      widget.refresh();
                    }
                  },
                  settingAction: () {
                    //
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => _showPicker(context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.r)),
                                  border: Border.all(
                                      color: primaryColor, width: 1.w),
                                ),
                                child: CircleAvatar(
                                  radius: 60.r,
                                  backgroundColor: Colors.green,
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: Image.file(
                                            _image!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: user.image),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.r)),
                                    border: Border.all(
                                        color: primaryColor, width: 1.5.w),
                                  ),
                                  child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Text('Nama',
                          style: AppFontStyle.authLabelText
                              .copyWith(color: primaryColor)),
                      CustomTextField(
                        controller: _nameController,
                        hintText: "Nama..",
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        color: secondaryColor,
                        startIcon: Icon(
                          Icons.person,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text('Email',
                          style: AppFontStyle.authLabelText
                              .copyWith(color: primaryColor)),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email..",
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        color: secondaryColor,
                        startIcon: Icon(
                          Icons.email,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text('Nomor Telepon',
                          style: AppFontStyle.authLabelText
                              .copyWith(color: primaryColor)),
                      CustomTextField(
                        controller: _phoneNumberController,
                        hintText: "Nomor Telepon..",
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        color: secondaryColor,
                        startIcon: Icon(
                          Icons.phone,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                          border: Border.all(
                            color: borderColor,
                            width: 1.5.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: MaterialButton(
                            onPressed: () async {
                              EasyLoading.show(status: 'loading...');
                              await updateUser(
                                name: _nameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                picture: _image,
                              );
                              EasyLoading.dismiss();
                            },
                            child: Text("Update Profil",
                                style: AppFontStyle.homeSubTitleText
                                    .copyWith(color: lightColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
