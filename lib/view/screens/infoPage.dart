import 'dart:io';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rive/rive.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/utils/data_cache.dart';
import 'package:text_to_image/view/screens/payment_screen.dart';
import 'package:text_to_image/view/screens/splash_screen.dart';
import 'package:text_to_image/view/screens/update_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/animated_btn.dart';
import '../../utils/add_helper.dart';
import 'full_image_view_screen.dart';
import 'login_widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text(
            AppLanguage.INFO,
            style: TextStyle(
                fontFamily: AppFonts.POPPINS_SEMI_BOLD, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<AdminBaseController>(
            builder: (_) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  AppCacheImage(
                    onTap: (){
                      Get.to(MediaPreview(medias:AdminBaseController.userData.value.photoUrl ?? ""));

                    },
                    imageUrl:
                        AdminBaseController.userData?.value?.photoUrl ?? "",
                    width: 100,
                    height: 100,
                    round: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    AdminBaseController.userData?.value?.name ?? "",
                    style: TextStyle(fontFamily: AppFonts.POPPINS_BOLD),
                  ),
                  SizedBox(height: 15),
                  OptionItem(
                    title: AppLanguage.ACCOUNT,
                    items: [
                      {
                        "icon": Icons.email_outlined,
                        "title":
                            AdminBaseController?.userData.value.email ?? "",
                      },
                      {
                        "icon": Icons.phone,
                        "title":
                            AdminBaseController?.userData.value.phone ?? "",
                      },
                      {
                        "icon": Icons.account_circle,
                        "title": AppLanguage.UPDATE_PROFILE,
                        "callBack": () {
                          Get.to(UpdateProfile());
                        }
                      },
                      {
                        "icon": Icons.delete,
                        "title": AppLanguage.DELETE_ACCOUNT,
                        "callBack": () {
                          deleteUser();
                        }
                      },
                      {
                        "icon": Icons.star,
                        "title": AppLanguage.PURCHASE_STAR +
                            " (${AdminBaseController.userData.value.stars ?? 0})",
                        "callBack": () {
                          Get.to(PaymentScreen());
                        }
                      }
                    ],
                  ),
                  OptionItem(title: AppLanguage.REVIEWS, items: [
                    {
                      "icon": Icons.star_border,
                      "title": AppLanguage.GOTO_REVIEWS,
                      "callBack": () async {
                        final InAppReview inAppReview = InAppReview.instance;
                        /*if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
              */

                        await inAppReview.openStoreListing(
                            appStoreId: Platform.isAndroid
                                ? "com.fantechlabs.everlove1"
                                : "1642469291");
                      }
                    }
                  ]),
                  OptionItem(title: AppLanguage.LANGUAGE, items: [
                    {
                      "icon": Icons.language,
                      "title": AppLanguage.UPDATE_LANGUAGE,
                      "callBack": () async {
                        var isEnglish = DataCache.isEnglish();
                        var result = await showConfirmationDialog(
                            context: Get.context!,
                            title: AppLanguage.UPDATE_LANGUAGE,
                            message: AppLanguage.SELECT_LANGUAGE,
                            actions: [
                              AlertDialogAction(
                                  isDefaultAction: isEnglish,
                                  label: AppLanguage.ENGLISH,
                                  key: "0"),
                              AlertDialogAction(
                                  isDefaultAction: !isEnglish,
                                  label: AppLanguage.GERMAN,
                                  key: "1"),
                            ]);
                        if (result == null) return;
                        print(result);
                        if (result == "0")
                          DataCache.setLaguage(true);
                        else
                          DataCache.setLaguage(false);
                        Get.offAll(SplashScreen());
                      }
                    }
                  ]),
                  OptionItem(title: AppLanguage.SUPPORT, items: [
                    {
                      "icon": Icons.info_outline,
                      "title": AppLanguage.SUPPORT,
                      "callBack": () {
                        _launchUrl("https://scriptfy.ch/");
                      }
                    }
                  ]),
                  SizedBox(height: 30),
                  BannerCustomWidget(),
                  SizedBox(height: 30),


                ],
              ),
            ),
          ),
        ));
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
          const RiveAnimation.asset(
            "assets/shapes.riv",
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
                        children: const [
                          Text(
                            "Info Page!",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "InfoPage",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) => LoginWidget()))
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text("InfoPage"),
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  BaseController _baseController = BaseController(Get.context!, () {});

  void deleteUser() async {
    try {
      var result = await showOkCancelAlertDialog(
          context: Get.context!,
          title: AppLanguage.DELETE_ACCOUNT,
          message: AppLanguage.DO_YOU_REALLY_WANT_TO_DELETE);
      if (result == OkCancelResult.cancel) return;
      _baseController.hideProgress();
      var text = await showTextInputDialog(
          context: Get.context!,
          message: AppLanguage.ENTER_YOUR_PASSWORD_BEFORE_DELETING_ACCOUNT,
          textFields: [DialogTextField(hintText: "******")]);
      if (text == null || text.isEmpty || text[0] == null || text[0].isEmpty)
        return;
      _baseController.showProgress();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AdminBaseController.userData.value.email ?? "",
          password: text[0]);
      await FirebaseAuth.instance.currentUser?.delete();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(AdminBaseController.userData.value?.userId ?? "")
          .delete();
      await deleteFile(AdminBaseController.userData?.value?.photoUrl ?? "");

      _baseController.hideProgress();
      await FirebaseAuth.instance.signOut();
      await showOkAlertDialog(context: Get.context!, title: "Account deleted");

      Get.offAll(SplashScreen());
    } on Exception catch (e) {
      _baseController.hideProgress();
      showOkAlertDialog(
          context: Get.context!,
          title: AppLanguage.ERROR,
          message: e.toString());
    }
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 30,
          // color: Colors.grey.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: AppFonts.POPPINS_BOLD),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ...items.map((e) {
                    return GestureDetector(
                      onTap: e["callBack"],
                      child: SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            Icon(e["icon"]),
                            SizedBox(width: 12),
                            Expanded(
                                child: Text(
                              e["title"],
                              style: TextStyle(
                                  fontFamily: AppFonts.INTER_REGULAR,
                                  fontSize: 17),
                            )),
                            SizedBox(width: 20),
                            if (e["callBack"] != null) Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
