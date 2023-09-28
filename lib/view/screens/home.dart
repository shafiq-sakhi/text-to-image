import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rive/rive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_cache_image.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/view/screens/payment_screen.dart';
import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import '../../controller/image_controller/image_controller.dart';

class HomeArtify extends StatefulWidget {
  const HomeArtify({super.key});

  @override
  State<HomeArtify> createState() => _HomeArtifyState();
}

class _HomeArtifyState extends State<HomeArtify> {
  late RiveAnimationController _btnAnimationController;
  final ImageController _imageController = Get.put(ImageController());
  final TextEditingController _imageTextController = TextEditingController();
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  bool isShowSignInDialog = false;
  BaseController baseController=BaseController(Get.context!, (){

  });

  var images;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          backgroundColor: AppColors.pinkLight,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.pinkLight,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/donload_icon.png",
                          width: 45,
                        ),
                        onTap: () => _imageController.downloadAllImages(
                          context,
                          _imageController.data.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10)
            ],
            title: Row(
              children: [
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguage.SCRIPTARTIFY,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppFonts.POPPINS_SEMI_BOLD),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
          ),

          /* appBar: AppBar(
            title: Text(
              AppLanguage.SCRIPTARTIFY,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.library_books,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            actions: <Widget>[
              */ /* Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Share.share(_imageController.data.value);
                    },
                  ),
                ),
              ),*/ /*
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.save_alt,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () => _imageController.downloadAllImages(
                      context,
                      _imageController.data.value,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
            backgroundColor: Colors.purple[100],
            elevation: 0,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),*/
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(
                          color: AppColors.pinkLight.withOpacity(0.2))),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Scrollbar(
                                        child: TextField(
                                          controller: _imageTextController,
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: AppLanguage
                                                  .DESCRIBE_THE_PICTURE_AS_BEST_AS_PISSIBLE),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                            height: 20,
                            width: 2,
                            color: AppColors.pinkLight.withOpacity(0.17)),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () async {
                              if (_imageTextController.text.isEmpty) return;
                              if ((AdminBaseController.userData.value.stars ??
                                      0) <=
                                  0) {
                                await showOkAlertDialog(
                                    context: Get.context!,
                                    title: AppLanguage.ERROR,
                                    message: AppLanguage.FREE_CREDIT_FINSHED);
                                Get.to(PaymentScreen());
                                return;
                              }

                              _imageController.getImage(
                                  imageText: _imageTextController.text);
                              _imageTextController.text = "";
                            },
                            child: Image.asset(
                              "assets/search_button.png",
                              width: 35,
                            )),
                        const SizedBox(width: 6)
                      ],
                    ),
                  ),
                ),
                Expanded(child: Obx(
                  () {
                    if (_imageController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (_imageController?.data?.isEmpty ?? true)
                      return Center(
                          child:
                              SvgPicture.asset("assets/svg/image_search.svg"));
                    else {
                      return Center(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          shrinkWrap: true,
                          children: [
                            ..._imageController.image.value.data
                                    ?.map((element) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                AppCacheImage(
                                                    imageUrl:
                                                        element?.url ?? "",
                                                    width: double.infinity,
                                                    height: 100),
                                                Positioned(
                                                  top: 10,
                                                  right: 0,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .blueDark,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons.share,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () async{
                                                              baseController.showProgress();
                                                              final url = Uri.parse(element?.url??"");
                                                              final response = await http.get(url);
                                                              var path='${(await getTemporaryDirectory()).path}/myItem.png';
                                                              await File(path).writeAsBytes(response.bodyBytes);
                                                              // await Share.shareFiles(['/yourPath/myItem.png'], text: 'Image Shared');
                                                              baseController.hideProgress();
                                                              Share.shareXFiles([XFile(path)
                                                              ]);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .blueDark,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons.save_alt,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () =>
                                                                _imageController
                                                                    .downloadImage(
                                                              context,
                                                              element?.url ??
                                                                  "",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    ?.toList() ??
                                []
                          ],
                        ),
                      );
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _imageController.data.value.isNotEmpty
                                ? NetworkImage(
                                    _imageController.data.value,
                                  )
                                : NetworkImage(
                                    'https://images.unsplash.com/photo-1636390785299-b4df455163dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                                  ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }
                  },
                ))
/*
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 30,
                                  keyboardType: TextInputType.multiline,
                                  autocorrect: true,
                                  controller: _imageTextController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _imageTextController.clear();
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: AppLanguage
                                        .DESCRIBE_THE_PICTURE_AS_BEST_AS_PISSIBLE,
                                    contentPadding: const EdgeInsets.all(10.0),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Obx(
                              () {
                                return _imageController.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepOrangeAccent[100],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () async {
                                          await _imageController.getImage(
                                            imageText: _imageTextController.text
                                                .trim(),
                                          );
                                        },
                                        child: Text(AppLanguage.CREATE),
                                      );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(child: Obx(
                          () {
                            if (_imageController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (_imageController?.data?.isEmpty ?? true)
                              return Center(
                                  child: Text(AppLanguage.SEARC_AND_DOWNLOAD));
                            else {
                              return GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: [
                                  ..._imageController.image.value.data
                                          ?.map((element) => Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  AppCacheImage(
                                                      imageUrl:
                                                          element?.url ?? "",
                                                      width: double.infinity,
                                                      height: 100),
                                                  Positioned(
                                                    top: 10,
                                                    right: 0,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                    .deepOrangeAccent[
                                                                100],
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.share,
                                                                size: 25,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                Share.share(
                                                                    element?.url ??
                                                                        "");
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                    .deepOrangeAccent[
                                                                100],
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.save_alt,
                                                                size: 25,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () =>
                                                                  _imageController
                                                                      .downloadImage(
                                                                context,
                                                                element?.url ??
                                                                    "",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ))
                                          ?.toList() ??
                                      []
                                ],
                              );
                              return Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        _imageController.data.value.isNotEmpty
                                            ? NetworkImage(
                                                _imageController.data.value,
                                              )
                                            : NetworkImage(
                                                'https://images.unsplash.com/photo-1636390785299-b4df455163dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                                              ),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            }
                          },
                        ))
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          // bottomNavigationBar: CurvedNavigationBar(
          //   index: _currentIndex,
          //   backgroundColor: Colors.deepOrangeAccent[100]!,
          //   color: Colors.purple.shade50,
          //   onTap: (index) {
          //     setState(() {
          //       _currentIndex = index;
          //     });
          //   },
          //   letIndexChange: (index) => true,
          //   items: [
          //     Icon(Icons.home),
          //     Icon(Icons.info),
          //   ],
          // ),
        ),
      );
}
