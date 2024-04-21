import 'package:flutter/material.dart';

Widget myText(String title, TextAlign textAlign, Color color, double fontSize, FontWeight fontWeight){
  return Text(
      title != null ? title : "",
      textAlign: textAlign,
      style: myTextStyle(fontSize, color, fontWeight)
  );
}

Widget myTextWidgetMaxLine(String title, TextAlign textAlign, Color color, double fontSize, FontWeight fontWeight, int maxLines){
  return Text(
      title != null ? title : "",
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: myTextStyle(fontSize, color, fontWeight)
  );
}

TextStyle myTextStyle(double fontSize, Color textColor, FontWeight fontWeight) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor
  );
}