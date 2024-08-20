
import 'package:flutter/material.dart';
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
    {TextEditingController? control,
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
          Function()? onTap}) {
      return TextFormField(
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
              borderColor: borderColor));
}