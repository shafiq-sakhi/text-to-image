import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:text_to_image/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:text_to_image/view/screens/splash_screen.dart';

import 'app/routes/app_pages.dart';
import 'view/screens/welcome_screen.dart';

/* main() {
  runApp(const MyApp());
}*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await MobileAds.instance.initialize();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scriptfy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return  const MaterialApp(
//         home: Scaffold(
//           backgroundColor: Colors.white,
//           body: SplashScreen()
//         ),
//     );
//
//   }
// }
