import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'package:get/get.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  // service.registerSnackbarConfig(SnackbarConfig(
  //   backgroundColor: AppColors.error,
  //   animationDuration: Duration(milliseconds: 400),
  //   isDismissible: true,
  //   maxWidth: double.infinity,
  //   snackPosition: SnackPosition.TOP,
  // ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.Success,
    config: SnackbarConfig(
      isDismissible: true,
      animationDuration: Duration(seconds: 1),
      backgroundColor: AppColor.STSuccess,
      textColor: AppColor.STPureWhite,
      borderRadius: 10,
      forwardAnimationCurve: Curves.bounceIn,
      // reverseAnimationCurve: Curves.bounceOut,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.check_rounded,
        color: Colors.white,
      ),
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.Info,
    config: SnackbarConfig(
      isDismissible: true,
      animationDuration: Duration(seconds: 1),
      backgroundColor: AppColor.STAccent,
      textColor: AppColor.STPureWhite,
      borderRadius: 10,
      icon: Icon(
        Icons.info_rounded,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.bounceIn,
      // reverseAnimationCurve: Curves.bounceOut,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.Error,
    config: SnackbarConfig(
      isDismissible: true,
      backgroundColor: AppColor.STFailure,
      animationDuration: Duration(seconds: 1),
      textColor: AppColor.STPureWhite,
      borderRadius: 10,
      margin: EdgeInsets.all(15),
      icon: Icon(
        Icons.cancel_rounded,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.bounceIn,
      // reverseAnimationCurve: Curves.bounceOut,
      padding: EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );
}

enum SnackbarType { Success, Error, Info }
