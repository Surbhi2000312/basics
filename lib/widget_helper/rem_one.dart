import 'package:basics/color_const.dart';
import 'package:basics/model/TimeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widget_helper.dart';


starText(String msg, {bool isShowStar = true}) {
  return Container(
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.only(bottom: 7),
    child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: msg,
              style:
              const TextStyle(color: ColorConst.greyColor595959, fontSize: 14)),
          if (isShowStar)
            const TextSpan(
                text: '*', style: TextStyle(color: Colors.red, fontSize: 14))
        ])),
  );
}



getSnackbar(
    {String? title = "", String? subTitle = "", bool isSuccess = true})
{
  try {
    Get.snackbar(title ?? "", subTitle ?? "",
        backgroundColor:
        isSuccess ? ColorConst.greenColor : ColorConst.redColor,
        colorText: ColorConst.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3));
  } catch (exc) {

  }
}