import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';

import '../../constants/constants.dart';
import '../../constants/inpudecoration.dart';
import '../../models/user_model.dart';
import '../../utils/app_language.dart';
import 'login_widget.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _image;
  BaseController _baseController = BaseController(Get.context!, () {});
  PhoneNumber number = PhoneNumber(
      isoCode: (AdminBaseController.userData.value.code ?? "CH"));

  @override
  void initState() {
    super.initState();
    _nameController.text = AdminBaseController.userData.value.name ?? "";
    _phoneController.text = AdminBaseController.userData.value.phone ?? "";
    _emailController.text = AdminBaseController.userData.value.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetBuilder<AdminBaseController>(
        builder: (_) =>
            Scaffold(
              // appBar: AppBar(
              //   title: Text(AppLanguage.REGISTER),
              //   centerTitle: true,
              // ),
              appBar: AppBar(
                title: Text(AppLanguage.UPDATE_PROFILE,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: AppFonts.URBANIST_BOLD,
                        color: Colors.black)),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                backgroundColor: AppColors.backGroundColor,
              ),

              backgroundColor: AppColors.backGroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: MaterialButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () async {
                                            ImagePicker imagePicker = ImagePicker();
                                            XFile? file = await imagePicker
                                                .pickImage(
                                                source: ImageSource.gallery);
                                            print('${file?.path}');

                                            if (file == null) return;
                                            setState(() {
                                              _image = File(file?.path ?? "");
                                            });
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(50)),
                                              child: _image == null
                                                  ? AppCacheImage(
                                                  imageUrl: AdminBaseController
                                                      .userData
                                                      .value
                                                      .photoUrl ??
                                                      "",
                                                  width: 100,
                                                  height: 100)
                                                  : Image.file(
                                                _image!, fit: BoxFit.cover,))),
                                    ),
                                    // const FlutterLogo(
                                    //   size: 120,
                                    // ),
                                    const SizedBox(height: 30),
                                    InputFields(
                                      title: AppLanguage.FULNAME,
                                      hint: AppLanguage.ENTER_YOUR_NAME,
                                      textEditingController: _nameController,
                                    ),
                                    const SizedBox(height: 20),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        AppLanguage.PHONE_NUMBER,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFonts.INTER_REGULAR,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          color: Colors.white),
                                      child: InternationalPhoneNumberInput(
                                        onInputChanged: (_number) {
                                          number = _number;
                                        },
                                        initialValue: number,
                                        textFieldController: _phoneController,
                                        inputDecoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: AppLanguage
                                                .ENTER_YOUR_PHONE),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    InputFields(
                                      title: AppLanguage.EMAIL,
                                      hint: AppLanguage.ENTER_YOUR_EMAIL,
                                      textEditingController: _emailController,
                                    ),

                                    const SizedBox(height: 30),
                                    AppButton(
                                        title: AppLanguage.UPDATE_PROFILE,
                                        onClick: () {
                                          update();
                                          // signUp();
                                        }),
                                    /*      Buttons(
                                  title: AppLanguage.REGISTER,
                                  color: Colors.blue,
                                  onPressed: () {
                                    if (_image == null) {
                                      Get.snackbar(
                                          AppLanguage.SELECT_YOUR_IMAGE, '',
                                          borderRadius: 10);
                                      return;
                                    }
                                    signUp();
                                  },
                                ),*/
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 100,
                width: 100,
                child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${file?.path}');

                      if (file == null) return;
                      setState(() {
                        _image = File(file?.path ?? "");
                      });
                    },
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50)),
                        child: _image == null
                            ? AppCacheImage(
                            imageUrl:
                            AdminBaseController.userData.value.photoUrl ??
                                "",
                            width: 100,
                            height: 100)
                            : Image.file(_image!))),
              ),
              // const FlutterLogo(
              //   size: 120,
              // ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: mTextFieldDecoration.copyWith(
                    hintText: AppLanguage.ENTER_YOUR_NAME),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: mTextFieldDecoration.copyWith(
                    hintText: AppLanguage.ENTER_YOUR_PHONE),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: mTextFieldDecoration.copyWith(
                    hintText: AppLanguage.ENTER_YOUR_EMAIL),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  update();
                },
                child: Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addDetails(
      String image_url, String name, String phone, String email) async {
    try {
      // validate user input
      var userId = (AdminBaseController.userData.value.userId ?? "").isEmpty
          ? FirebaseAuth.instance.currentUser?.uid ?? ""
          : (AdminBaseController.userData.value.userId ?? "");
      var userModel = UserModel.fromJson({
      'PhotoUrl': image_url,
      'Name': name,
      'Phone': phone,
      'Email': email,
      'code':number.isoCode,
      "UserId":userId
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({
        'PhotoUrl': image_url,
        'Name': name,
        'Phone': phone,
        'Email': email,
        'code': number.isoCode,
        "UserId":userId
      }, SetOptions(merge: true));
      AdminBaseController.updateUser(userModel);
      _baseController.hideProgress();
      Get.snackbar(
        AppLanguage.YOUR_ACCOUNT_UPDATED_SUCCESSFULLY,
        '',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        borderRadius: 10,
      );
      Get.back();
    } catch (e) {
      _baseController.hideProgress();

      Get.snackbar('$e', '', borderRadius: 10);
      print(e);
    }
  }

  String imageUrl = "";

  Future update() async {
    try {
      // validate user input

      if (_nameController.text.trim().isEmpty) {
        Get.snackbar(
          AppLanguage.NAME_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      if (_phoneController.text.trim().isEmpty) {
        Get.snackbar(
          AppLanguage.PHONE_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      if (_emailController.text.trim().isEmpty) {
        //throw ('Email field is empty');
        Get.snackbar(
          AppLanguage.EMAIL_IS_EMPTY,
          '',
          borderRadius: 10,
        );
        return;
      }
      // if (!EmailValidator.validate(_emailController.text.trim())) {
      //   throw ('Invalid email address');
      // }

      _baseController.showProgress();
      // create user
      var userId = (AdminBaseController.userData.value.userId ?? "").isEmpty
          ? FirebaseAuth.instance.currentUser?.uid ?? ""
          : (AdminBaseController.userData.value.userId ?? "");
      if (_image != null)
        imageUrl = await uploadUserImage(userId,
                _image?.path ?? "") ??
            "";
      else
        imageUrl = AdminBaseController.userData.value.photoUrl ?? "";

      // add details to firestore database
      addDetails(imageUrl, _nameController.text.trim(),
          _phoneController.text.trim(), _emailController.text.trim());
    } on FirebaseException catch (e) {
      _baseController.hideProgress();
      Get.snackbar('$e', '', borderRadius: 10);
      //print(e.message);
    } catch (e) {
      _baseController.hideProgress();

      print(e);
    }
  }
}
