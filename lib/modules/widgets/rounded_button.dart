import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  String text;
  Function press;
  double textSize;
  Color colorButton, colorSplash, textColor;
  EdgeInsetsGeometry edgeInsetsGeometry;
  double radius;

  MyRoundedButton({
    Key key,
    this.text,
    this.textSize,
    this.press,
    this.colorButton,
    this.colorSplash,
    this.textColor,
    this.edgeInsetsGeometry,
    this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(edgeInsetsGeometry),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              // side: BorderSide(color: Colors.red)
            )
        ),
        backgroundColor: MaterialStateProperty.all(colorButton),
        overlayColor: MaterialStateProperty.all(colorSplash),
        animationDuration: Duration(
            milliseconds: 3,
            microseconds: 0
        ),
      ),
      onPressed: press,
      child: myText(
          text, TextAlign.center, textColor, textSize, FontWeight.bold),
    );
  }
}