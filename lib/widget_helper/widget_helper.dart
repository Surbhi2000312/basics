
import 'dart:io';

import 'package:basics/widget_helper/textbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
InputDecoration inputFieldDecoration(
    {double radius = 10,
          Color borderColor = Colors.grey,
          Color focusBorderColor = Colors.grey,
          String hint = '',
          Color hintColor = Colors.grey,
          Icon? icons,
          Color? filledColor,
          bool isRect = true,
          double fontSize = 14,
          FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never,
          bool isShowOutline = true}) {
      InputBorder outlineBorder;
      if (isShowOutline) {
            outlineBorder = OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: isRect
                    ? BorderRadius.circular(radius)
                    : BorderRadius.circular(radius));
      } else {
            outlineBorder = InputBorder.none;
      }
      return InputDecoration(
            counterText: '',
            border: outlineBorder,
            prefixIcon: icons,
            fillColor: filledColor,
            filled: filledColor != null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: hint,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            //     enabledBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: borderColor),
            //     borderRadius: BorderRadius.all(Radius.circular(radius))),
            focusedBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: focusBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            hintText: hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w500, color: hintColor, fontSize: fontSize),
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize),
      );
}
Widget edtRectField(
    {
      Key? key, // Add this line
      TextEditingController? control,
          String hint = '',
          validate,
          Icon? icons,
          bool isRect = true,
          int txtLength = 32,
          keyboardType,
          bool isReadOnly = false,
          bool isShowOutline = true,
          textCapitalization = TextCapitalization.words,
          Color borderColor = Colors.grey,
          Color focusBorderColor = Colors.grey,
          Color hintColor = Colors.grey,
          Color? filledColor,
          FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never,
          double radius = 0,
          Function()? onTap,
          void Function(String)? onChanged, // Add this line
           }) {
              return TextFormField(
          key: key, // Use the key here
          onTap: onTap,
          textCapitalization: textCapitalization,
          //TextCapitalization.words,
          controller: control,
          textInputAction: TextInputAction.next,
          maxLength: txtLength,
          validator: validate,
          keyboardType: keyboardType,
          //TextInputType.number,
          readOnly: isReadOnly,
          decoration: inputFieldDecoration(
              radius: radius,
              hint: hint,
              hintColor: hintColor,
              icons: icons,
              isRect: isRect,
              focusBorderColor: focusBorderColor,
              filledColor: filledColor,
              isShowOutline: isShowOutline,
              floatingLabelBehavior: floatingLabelBehavior,
              borderColor: borderColor),
  onChanged: onChanged, // Add this line
  );


}
Widget getCacheImage(
    {String? url = '',
      double height = 80,
      double width = 80,
      String placeHolder = "",
      bool isCircle = false,
      bool isShowBorderRadius = false,
      BoxFit fit = BoxFit.cover,
      String? assetPath,
      File? filePath})
{
  Container imgWidget;
  var border = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(height / 2)),
      border: Border.all(color: Colors.cyan, width: 2.0));
  if (assetPath?.isNotEmpty == true) {
    imgWidget = Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: isShowBorderRadius ? border : const BoxDecoration(),
        child: isCircle
            ? ClipOval(child: Image.asset(assetPath!, fit: fit))
            : Image.asset(assetPath!, fit: fit));
  } else if (filePath?.path.isNotEmpty == true) {
    imgWidget = Container(
        width: width,
        height: height,
        decoration: isShowBorderRadius ? border : const BoxDecoration(),
        child: ClipOval(child: Image.file(filePath!, fit: fit)));
  } else {
    Widget cachImg = CachedNetworkImage(
        fit: fit,
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        imageUrl: url ?? "",
        placeholder: (context, url) =>
            getPlaceHolder(placeHolder, height, width),
        errorWidget: (context, url, error) =>
            getPlaceHolder(placeHolder, height, width));
    imgWidget = Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: isShowBorderRadius ? border : const BoxDecoration(),
        child: isShowBorderRadius ? ClipOval(child: cachImg) : cachImg);
  }
  if (isCircle) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(height), child: imgWidget);
  } else {
    return imgWidget;
  }
}
Widget getPlaceHolder(
    String placeAssetsHolderPos, double height, double width) {
  return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: Image.asset(placeAssetsHolderPos));
}
showCustomDialog(String message, Function isGranted,
    {String title = "Test Case",
      String okBtn = "Yes",
      String cancelBtn = "Cancel"}) async =>
    showDialog<bool>(
        context: Get.context!,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: getTxtColor(
                msg: message, fontSize: 17, txtColor:Colors.black),
            title: getTxtBlackColor(
                msg: title, fontSize: 18, fontWeight: FontWeight.bold),
            actions: <Widget>[
              TextButton(
                  child: getTxtBlackColor(msg: okBtn, fontSize: 17),
                  onPressed: () async {
                    isGranted(true);
                    // await SPManager.clearPref();
                    // Get.offAllNamed(RoutersConst.login);
                  }),
              TextButton(
                  child: getTxtBlackColor(
                    msg: cancelBtn,
                    fontSize: 17,
                  ),
                  onPressed: () {
                    isGranted(false);
                  }),
            ],
          );
        });



onWillPop() async => showCustomDialog("Are you sure you want to exit this app?",
        (bool isGranted) async {
      if (isGranted) {
        Navigator.of(Get.context!).pop();
      } else {
        Get.back();
      }
    });

Widget raisedRoundColorBtn(String txt, Color color, Function() btnClick) =>
    ButtonTheme(
//  minWidth: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          btnClick();
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: getTxtWhiteColor(
            msg: 'Add Address', fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );

