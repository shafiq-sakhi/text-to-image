import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:text_to_image/constants/constants.dart';
import 'package:text_to_image/controller/admin_base_controller.dart';
import 'package:text_to_image/utils/app_language.dart';
import 'package:text_to_image/utils/base_controller.dart';
import 'package:text_to_image/view/screens/welcome_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<StoreProduct> products = [];
  BaseController _baseController = BaseController(Get.context!, () {});

  Future<void> initPlatformState() async {
    products = (await Purchases.getProducts(["com.scriptfy.p1"],
        type: PurchaseType.inapp));
    print(products);
    products?.sort(((a, b) {
      return a.price.compareTo(b.price);
    }));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void purchaseStar(StoreProduct storeProduct) async {
    try {
      _baseController.showProgress();
      var cutomerInfo = await Purchases.purchaseProduct(storeProduct.identifier,
          type: PurchaseType.inapp);
      print(cutomerInfo);

      if ((cutomerInfo.entitlements.all["images_offer"]?.isActive ?? false) ==
          true) {
        print(storeProduct.description ?? "get desc null");
        var quantity = int.parse(storeProduct.description.split(" ")[1]);

        FirebaseFirestore.instance
            .collection("users")
            .doc(AdminBaseController.userData.value.userId ?? "")
            .set({"stars": FieldValue.increment(12)}, SetOptions(merge: true));
        _baseController.hideProgress();
        await showOkAlertDialog(
            context: Get.context!,
            title: AppLanguage.PURCHASE_STAR,
            message: AppLanguage.START_PURCHASED);
        Get.back();
      }
      else {
        _baseController.hideProgress();
      }

      print("data");
      print(cutomerInfo);
    } on Exception catch (e) {
      _baseController.hideProgress();
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kPinkGadient,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...products
                  .map((e) =>
                  Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/d3.png",
                            width: Get.size.width * 0.70,
                          ),
                          SizedBox(height: 10),
                          Text(
                            e.title,
                            style: TextStyle(
                                fontFamily: AppFonts.POPPINS_BOLD,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Text(
                            AppLanguage.PURCHASE_DESCRIPTION,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: AppFonts.INTER_REGULAR,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Text(
                            e.currencyCode + " " + e.priceString,
                            style: TextStyle(
                                fontFamily: AppFonts.POPPINS_BOLD,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          AppButton(
                              title: AppLanguage.CLICK_TO_BUY,
                              onClick: () {
                                purchaseStar(e);
                              }),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              AppLanguage.NOT_NOW,
                              style: TextStyle(
                                  fontFamily: AppFonts.POPPINS_SEMI_BOLD,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      )))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
