import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/utils/app_language.dart';

import 'login_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    /* _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: kPinkGadient,
        child: Stack(
          children: [
            SizedBox(width: double.infinity, height: double.infinity),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Opacity(
                  opacity: 0.15,
                  child: SvgPicture.asset(
                    "assets/svg/fan.svg",
                    fit: BoxFit.fitWidth,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: double.infinity),
                      SvgPicture.asset(
                        "assets/svg/z.svg",
                        width: Get.size.width * 0.50,
                      ),
                      SizedBox(
                        height: Get.size.height * 0.065,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Text(
                        AppLanguage.WELCOME_TO_SCRIPTFY,
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: AppFonts.POPPINS_SEMI_BOLD,
                            height: 1.2,
                            color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Text(
                        AppLanguage.ABOUT_APP,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.INTER_REGULAR,
                            height: 1.2,
                            color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      AppButton(
                        onClick: () {
                          Get.to(() => LoginWidget());
                        },
                        title: AppLanguage.LETS_GO,
                      ),
                      SizedBox(height: 15),
                      Text(
                        AppLanguage.WELCOME_DESCRITION,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppFonts.URBANIST_MEDIUAM,
                            height: 1.2,
                            color: Colors.white),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    return Scaffold(
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
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 300,
                      child: Column(
                        children:  [
                          Text(
                            AppLanguage.WELCOME_TO_SCRIPTFY,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(AppLanguage.ABOUT_APP,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    /*      AnimatedBtn(
                      press: () {

                        Future.delayed(
                          const Duration(milliseconds: 800),
                              () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) => LoginWidget())) //InfoPage()
                                .then((value) => setState(() {
                                      isShowSignInDialog = false;
                                    }));
                            // showCustomDialog(
                            //   context,
                            //   onValue: (_) {
                            //     setState(() {
                            //       isShowSignInDialog = false;
                            //     });
                            //   },
                            // );
                          },
                        );
                      },
                    ),
              */
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(AppLanguage.WELCOME_DESCRITION),
                    )
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

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onClick,
  });

  final String title;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
            AppColors.blueDark,
            AppColors.blueMedium,
            AppColors.blueLight
          ])),
      child: MaterialButton(
        height: 56,
        minWidth: double.infinity,
        onPressed: onClick,
        child: Text(title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.INTER_MEDIUM,
              fontSize: 20),
        ),
      ),
    );
  }
}
