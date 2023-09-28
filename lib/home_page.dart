import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:text_to_image/app/modules/home/views/home_view.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/models/user_model.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/view/screens/infoPage.dart';
import 'package:text_to_image/view/screens/payment_screen.dart';
import 'package:text_to_image/view/screens/profile.dart';
import 'package:text_to_image/view/screens/splash_screen.dart';

import 'constants/constants.dart';
import 'payment_utils/revenue_cat.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  int _selectedIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeView(zoomDrawerController),
      InfoPage(),
      Profile(),
    ];
    RevenueCat.initPlatformState();
    attachUserListener();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener;

  void attachUserListener() {
    listener = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        return;
      }
      AdminBaseController.updateUser(UserModel.fromJson(event?.data() ?? {}));
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kPinkGadient,
      child: ZoomDrawer(
        controller: zoomDrawerController,
        menuScreen: buildMenu(),
        mainScreenScale: 0.1,
        mainScreen:
            Container(decoration: kPinkGadient, child: _pages[_selectedIndex]),
        borderRadius: 40.0,
        showShadow: false,
        angle: 0.0,
        drawerShadowsBackgroundColor: Colors.white,
        menuScreenWidth: double.infinity,
        slideWidth: MediaQuery.of(context).size.width * 0.5,
      ),
    );
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.orangeAccent.shade200,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: AppLanguage.HOME,
                  ),
                  GButton(
                    icon: Icons.info_outline,
                    text: AppLanguage.INFO,
                  ),
                  GButton(
                    icon: Icons.person,
                    text: AppLanguage.PROFILE,
                  ),
                ],
                selectedIndex: _selectedIndex,
                //tabActiveBorder: Border.all(color: Colors.black, width: 1),
                //tabBorder: Border.all(color: Colors.grey, width: 1),
                //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
                //activeColor: Colors.purple,
                //tabBackgroundColor: Colors.purple.withOpacity(0.1),
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      width: 500,
      decoration: kPinkGadient,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  AppLanguage.MENU,
                  style: TextStyle(
                      fontFamily: AppFonts.POPPINS_BOLD,
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
              Row(
                children: [
                  Image.asset("assets/home.png", width: 60),
                  Text(
                    AppLanguage.HOME,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.INTER_REGULAR,
                        fontSize: 20),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  zoomDrawerController.close?.call();
                  Get.to(InfoPage());
                },
                child: Row(
                  children: [
                    Image.asset("assets/info.png", width: 60),
                    Text(
                      AppLanguage.INFO,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.INTER_REGULAR,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  zoomDrawerController.close?.call();
                  Get.to(PaymentScreen());
                },
                child: GetBuilder<AdminBaseController>(
                  builder:(ctr)=>Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.stars,color: Colors.yellow,size: 30),
                      SizedBox(width: 17),
                      Text(
                        AppLanguage.STARS + " (${AdminBaseController.userData.value.stars??""})",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppFonts.INTER_REGULAR,
                            fontSize: 20),
                      )
                    ],
                  )
                  ,
                ),
              ),

              /* GestureDetector(
                onTap: () {
                  zoomDrawerController.close?.call();
                  Get.to(Profile());
                },
                child: Row(
                  children: [
                    Image.asset("assets/profile.png", width: 60),
                    Text(
                      AppLanguage.PROFILE,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.INTER_REGULAR,
                          fontSize: 20),
                    )
                  ],
                ),
              ),*/
              Expanded(child: Container()),
              GestureDetector(
                onTap: () async {
                  var result = await showOkCancelAlertDialog(
                      context: Get.context!,
                      title: AppLanguage.LOGOUT,
                      message: AppLanguage.DO_YOU_REALLY_WANT_TO_LOGOUT,
                      okLabel: AppLanguage.YES,
                      cancelLabel: AppLanguage.NO);
                  if (result == OkCancelResult.cancel) return;
                  FirebaseAuth.instance.signOut();
                  Get.offAll(SplashScreen());
                },
                child: Row(
                  children: [
                    Image.asset("assets/logout.png", width: 60),
                    Text(
                      AppLanguage.LOGOUT,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.INTER_REGULAR,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
