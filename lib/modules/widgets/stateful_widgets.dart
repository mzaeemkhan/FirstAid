import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/image_assets.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';
import '../setting/settings_screen.dart';
import 'common_widgets.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      color: AppColors.whiteColor,
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _buildDrawerHeader(),
                ListTile(
                  leading: Container(
                      width: 24.0,
                      height: 24.0,
                      child: svgPictureWidget(ImageAssets.iconSettings, 'Settings', BoxFit.fill, AppColors.primaryColor)
                  ),
                  title: Row(
                    children: [
                      Flexible(child: myText('settings'.tr, TextAlign.left, AppColors.primaryColor, 16, FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
                ListTile(
                  leading: Container(
                      width: 24.0,
                      height: 24.0,
                      child: svgPictureWidget(ImageAssets.iconAboutUs, 'About Us', BoxFit.fill, AppColors.primaryColor)
                  ),
                  title: Row(
                    children: [
                      Flexible(child: myText('about_us'.tr, TextAlign.left, AppColors.primaryColor, 16, FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    launchURL();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // region DrawerHeader
  Widget _buildDrawerHeader() {
    return Container(
      color: AppColors.primaryColor,
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36.0,
              backgroundColor: AppColors.whiteColor,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: assetImageWidget(ImageAssets.iconAtruleLogo, BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: myText(StringAssets.textAtrule, TextAlign.center, AppColors.whiteColor, 16, FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
// endregion
}

