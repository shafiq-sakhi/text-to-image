import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCat {
  static Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(Platform.isAndroid
        ? "goog_YbsyDytgvOqLxDFepQlIQPHbwWm"
        : "appl_vvfEMABGOWFdMGPWKAWmFXLTera");
    await Purchases.configure(configuration);
    await Purchases.enableAdServicesAttributionTokenCollection();
    Purchases.addCustomerInfoUpdateListener((purchaserInfo) async {
      print("customer_info " + purchaserInfo.toString());

      print("cutomer->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      var isPurchases =
          purchaserInfo.entitlements.all["ever_premium"]?.isActive ?? false;
      /*if (purchaserInfo.activeSubscriptions.isNotEmpty) {
        if (AdminBaseController.userData.value.memberShipType !=
            UserModel.MEMBER_PREMIUM_NON) {
          return;
        }

        var activeSubscription =
            isPurchases ? purchaserInfo.activeSubscriptions.first : "";
        print("customer_info" + purchaserInfo.activeSubscriptions.toString());
        // print(purchaserInfo.allExpirationDates);
        // print(purchaserInfo.allPurchaseDates);
        // print(purchaserInfo.entitlements.active);
        print("customer_info" + (isPurchases.toString() ?? ""));

        await NetWorkServices.updateMemberShip(
            packages[purchaserInfo.activeSubscriptions.first] ?? 0,
            AdminBaseController.userData.value.uid!);
      } else {
        if (AdminBaseController.userData.value.memberShipType ==
            UserModel.MEMBER_PREMIUM_NON) {
          return;
        }

        await NetWorkServices.updateMemberShip(UserModel.MEMBER_PREMIUM_NON,
            AdminBaseController.userData.value.uid!);
      }*/
    });
  }
}
