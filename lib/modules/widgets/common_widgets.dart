import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/constants/app_colors.dart';
import '../emergency_contacts/emergency_contacts.dart';

Widget assetImageWidget(String _imageData, BoxFit boxFit) {
  return Image.asset(
    _imageData,
    fit: boxFit,
  );
}

Widget circleAvatarWidget(String _imageData, BoxFit boxFit) {
  return CircleAvatar(
    radius: 25.0,
    backgroundColor: AppColors.whiteColor,
    child: Container(
      padding: EdgeInsets.all(3.0),
      child: assetImageWidget(_imageData, boxFit),
    ),
  );
}

Widget svgPictureWidget(String _imageData, String label, BoxFit boxFit, Color _color) {
  return SvgPicture.asset(
    _imageData,
    semanticsLabel:label,
    fit: boxFit,
    color: _color,
  );
}

Widget floatingAB(BuildContext context) {
  return FloatingActionButton(
    child: iconWidget(Icons.phone, AppColors.whiteColor),
    backgroundColor: AppColors.primaryColor,
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmergencyContacts()));
    },
  );
}

Widget iconWidget(IconData iconData, Color _color) {
  return Icon(
      iconData,
    color: _color,
  );
}