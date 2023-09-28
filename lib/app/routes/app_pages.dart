import 'package:get/get.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';

import '../modules/chat_image/bindings/chat_image_binding.dart';
import '../modules/chat_image/views/chat_image_view.dart';
import '../modules/chat_text/bindings/chat_text_binding.dart';
import '../modules/chat_text/views/chat_text_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.Splash;

  static final routes = [
    GetPage(
      name: _Paths.Splash,
      page: () => const WelcomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(null),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_IMAGE,
      page: () => const ChatImageView(),
      binding: ChatImageBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_TEXT,
      page: () => const ChatTextView(),
      binding: ChatTextBinding(),
    ),
  ];
}
