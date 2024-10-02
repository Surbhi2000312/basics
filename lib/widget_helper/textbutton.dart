import 'package:flutter/material.dart';


Text getTxtBlackColor(
    {required String? msg,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign? textAlign}) =>
    Text(msg ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        style: _getFontStyle(
            txtColor: Colors.black,
            fontSize: fontSize,
            fontWeight: fontWeight));

TextStyle _getFontStyle(
    {Color? txtColor,
      double? fontSize,
      FontWeight? fontWeight,
      String? fontFamily,
      TextDecoration? txtDecoration,
      Color? decorationColor}) =>
    TextStyle(
        color: txtColor,
        fontSize: fontSize,
        decoration: txtDecoration ?? TextDecoration.none,
        decorationColor: decorationColor,
        fontWeight: fontWeight ?? FontWeight.normal);



ElevatedButton btnCorner(String msg, Function() click,
    {FontWeight fontWeight = FontWeight.normal,
          double fontSize = 14,
          Color textColor = Colors.white,
          Color bgColor = Colors.blue}) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)))),
        onPressed: () => click(),
        child: getTxtColor(
            msg: msg ?? "",
            fontWeight: fontWeight,
            fontSize: fontSize,
            txtColor: textColor)
    );

Text getTxtWhiteColor(
    {required String msg,
      double fontSize = 14,
      FontWeight fontWeight = FontWeight.normal,
      int? maxLines,
      TextAlign? textAlign,
      TextDecoration? txtDecoration,
      Color? decorationColor}) =>
    Text(msg,
        maxLines: maxLines,
        textAlign: textAlign,
        style: _getFontStyle(
            txtColor: Colors.white,
            fontSize: fontSize,
            txtDecoration: txtDecoration,
            decorationColor: decorationColor,
            fontWeight: fontWeight));

Text getTxtColor(
    {required String? msg,
          required Color txtColor,
          double fontSize = 14,
          FontWeight fontWeight = FontWeight.normal,
          int maxLines = 1,
          TextAlign textAlign = TextAlign.start}) =>
    Text(msg ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        style: _getFontStyle(
            txtColor: txtColor, fontSize: fontSize, fontWeight: fontWeight));



Widget customList({
  required String sectionTitle,
  required List<dynamic> itemList,
  String? sectionSubTitle,
  String? dayText,
  double fontSize = 25,
}) {
  return Column(
    children: [
      SizedBox(height: 40),
      getTxtBlackColor(msg: sectionTitle),
      SizedBox(
        child: itemList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getTxtBlackColor(msg: dayText),
                      getTxtBlackColor(msg: "index ${index}"),
                      getTxtBlackColor(
                          msg: itemList[index],
                          fontSize: fontSize)
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}
class CustomListSection extends StatelessWidget {
  final String sectionTitle;
  final List<dynamic> itemList;
  final String? sectionSubTitle;
  final double fontSize;

  const CustomListSection({
    Key? key,
    required this.sectionTitle,
    required this.itemList,
    required this.sectionSubTitle,
    this.fontSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        getTxtBlackColor(msg: sectionTitle),
        getTxtBlackColor(msg: sectionSubTitle),
        SizedBox(
          // height: 500,
          child: itemList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            padding: EdgeInsets.only(bottom: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        getTxtBlackColor(msg: "index ${index}"),
                        getTxtBlackColor(
                            msg: itemList[index],
                            fontSize: fontSize)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
