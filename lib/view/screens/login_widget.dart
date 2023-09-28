import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/home_page.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/view/screens/singup_widget.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';

import '../../../constants/inpudecoration.dart';
import '../../utils/app_language.dart';

class LoginWidget extends StatefulWidget {
  //static const String id = 'login_screen';
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BaseController _baseController = BaseController(Get.context!, () {});

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.pinkLight,
        body: Container(
          decoration: kPinkGadient,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Opacity(
                    opacity: 0.15,
                    child: SvgPicture.asset(
                      "assets/svg/fan.svg",
                      fit: BoxFit.fitWidth,
                      width: Get.width,
                    )),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Opacity(
                    opacity: 0.15,
                    child: SvgPicture.asset(
                      "assets/svg/fan.svg",
                      fit: BoxFit.fitWidth,
                      width: Get.width,
                    )),
              ),

              GlassmorphicContainer(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 20,
                blur: 8,
                alignment: Alignment.bottomCenter,
                border: 0,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.2),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.5),
                    Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 70),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/icon.png',
                            fit: BoxFit.fitWidth,
                            width: Get.size.width * 0.40,
                          ),
                        ),
                        Text(AppLanguage.HI_WELCOME_BACK,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: AppFonts.URBANIST_BOLD,
                                color: Colors.white)),
                        Text(AppLanguage.HELO_AGAIN_YOU_HAVE_BEEN_MISSED,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppFonts.INTER_REGULAR,
                                color: Colors.white)),
                        SizedBox(height: 20),
                        GlassmorphicContainer(
                          width: double.infinity,
                          height: 238,
                          borderRadius: 20,
                          blur: 20,
                          padding: EdgeInsets.all(40),
                          alignment: Alignment.bottomCenter,
                          border: 1,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.blueDark.withOpacity(0.1),
                                AppColors.blueDark.withOpacity(0.05),
                              ],
                              stops: [
                                0.1,
                                1,
                              ]),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.blueDark.withOpacity(0.5),
                              AppColors.blueDark.withOpacity(0.5),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
                            child: Column(
                              children: [
                                InputFields(
                                  titleColor: Colors.white,
                                  title: AppLanguage.EMAIL,
                                  hint: AppLanguage.ENTER_YOUR_EMAIL,
                                  textEditingController: _emailController,
                                ),
                                SizedBox(height: 30),
                                InputFields(
                                  title: AppLanguage.PASSWORD,
                                  hint: AppLanguage.ENTER_YOU_PASSWORD,
                                  isPassword: true,
                                  titleColor: Colors.white,
                                  textEditingController: _passwordController,
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        AppButton(
                          title: AppLanguage.SIGNIN,
                          onClick: () async {
                            try {
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
                              if (_passwordController.text.trim().isEmpty) {
                                //throw ('Password field is empty');
                                Get.snackbar(AppLanguage.PASSWORD_IS_EMPTY, '',
                                    borderRadius: 10);
                                return;
                              }
                              if (_passwordController.text.trim().length < 8) {
                                //throw ('Password must be at least 8 characters');
                                Get.snackbar(AppLanguage.PASSWORD_LENGTH, '',
                                    borderRadius: 10);
                                return;
                              }
                              _baseController.showProgress();

                              final newUser = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());

                              if (!(newUser.user?.emailVerified ?? false)) {
                                await newUser.user?.sendEmailVerification();
                                _baseController.hideProgress();
                                await FirebaseAuth.instance.signOut();
                                showOkAlertDialog(
                                    context: Get.context!,
                                    title: AppLanguage.ERROR,
                                    message: AppLanguage
                                        .VERIICATION_EMAIL_SENT_PLEASE_VERIFY_EMAIL);
                                _baseController.hideProgress();
                                return;
                              }
                              var user = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(newUser.user?.uid ?? "")
                                  .get();
                              AdminBaseController.updateUser(
                                  UserModel.fromJson(user.data() ?? {}));
                              _baseController.hideProgress();

                              Get.offAll(() => MyHomePage());
                              /* Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));*/
                            } catch (e) {
                              _baseController.hideProgress();
                              showOkAlertDialog(
                                  context: Get.context!,
                                  title: AppLanguage.ERROR,
                                  message: e.toString());
                              print(e);
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLanguage.ALREAD_HAVE_ACCOUNT,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Get.to(SingupWidget());
                              },
                              child: Text(
                                AppLanguage.REGISTER,
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontFamily: AppFonts.URBANIST_BOLD,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Loing',
      //   ),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          // const RiveAnimation.asset(
          //   "assets/shapes.riv",
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                        height: 250,
                        width: 250,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-5.0, -5.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        child: Image.asset(
                          'assets/images/icon.png',
                          fit: BoxFit.cover,
                        ) //const FlutterLogo(size: 100.0),
                        ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: AppLanguage.ENTER_YOUR_EMAIL),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: mTextFieldDecoration.copyWith(
                          hintText: AppLanguage.ENTER_YOU_PASSWORD),
                    ),
                    const SizedBox(height: 15),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                    //       },
                    //       child: const Text(
                    //         "Forgot Password?",
                    //         style: TextStyle(
                    //             color: Colors.blue, fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: InkWell(
                          onTap: () async {
                            try {
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
                              if (_passwordController.text.trim().isEmpty) {
                                //throw ('Password field is empty');
                                Get.snackbar(AppLanguage.PASSWORD_IS_EMPTY, '',
                                    borderRadius: 10);
                                return;
                              }
                              if (_passwordController.text.trim().length < 8) {
                                //throw ('Password must be at least 8 characters');
                                Get.snackbar(AppLanguage.PASSWORD_LENGTH, '',
                                    borderRadius: 10);
                                return;
                              }
                              _baseController.showProgress();

                              final newUser = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());
                              var user = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(newUser.user?.uid ?? "")
                                  .get();
                              AdminBaseController.updateUser(
                                  UserModel.fromJson(user.data() ?? {}));
                              _baseController.hideProgress();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            } catch (e) {
                              _baseController.hideProgress();
                              showOkAlertDialog(
                                  context: Get.context!,
                                  title: AppLanguage.ERROR,
                                  message: e.toString());
                              print(e);
                            }
                          },

                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>Home()));

                          child: Container(
                            width: 350,
                            height: 55,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  //color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              // gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   stops: [0.0, 0.6, 0.9],
                              //   colors: [
                              //     Color(0xFFE25474),
                              //     Color(0xFF509EDD),
                              //     Color(0xFFE25474),
                              //   ],
                              // ),
                            ),
                            child: Align(
                                child: Text(
                              AppLanguage.SIGNIN,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal),
                            )),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(AppLanguage.DONT_HAVE_ACCOUNT),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingupWidget(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputFields extends StatefulWidget {
  const InputFields({
    super.key,
    required this.title,
    required this.hint,
    required this.textEditingController,
    this.isPassword = false,
    this.titleColor = Colors.black,
  });

  final String title;
  final String hint;
  final bool isPassword;
  final TextEditingController textEditingController;
  final Color titleColor;

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: widget.titleColor,
                fontFamily: AppFonts.INTER_REGULAR,
                fontSize: 14),
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: widget.textEditingController,
                obscureText: widget.isPassword && _passwordVisible,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hint,
                  suffixIcon: !widget.isPassword
                      ? null
                      : IconButton(
                          color: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
