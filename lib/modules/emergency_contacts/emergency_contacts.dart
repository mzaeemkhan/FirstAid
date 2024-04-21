import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/response/EmergencyContactModel.dart';
import 'package:first_aid/modules/widgets/custom_app_bar.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/image_assets.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';

class EmergencyContacts extends StatefulWidget {
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  FirstAidController firstAidController;

  // region initState Method
  @override
  void initState() {
    super.initState();
    try{
      firstAidController = Get.find();
      firstAidController.fetchEmergencyContactData();
    }catch(exception){
      firstAidController = Get.put(FirstAidController());
      firstAidController.fetchEmergencyContactData();
    }
  }
  // endregion

  // region build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
          "emergency_contacts".tr,
          Icons.arrow_back,
              (){Navigator.pop(context, false);},
          [],
          null
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            var result = snapshot.data;
            switch (result) {
              case ConnectivityResult.none:
                break;
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
                Timer(Duration(seconds: 5), () {
                  if(firstAidController.emergencyContactList.isEmpty && !firstAidController.isEmergencyContactLoading){
                    firstAidController.fetchEmergencyContactData();
                  }
                });
                break;
              default:
                break;
            }
            return buildBody();
          },
        ),
      ),
    );
  }
  // endregion

  // region buildBody
  Widget buildBody() {
    return GetBuilder<FirstAidController>(
      id: 'contact_screen',
      builder: (_) => firstAidController.isEmergencyContactLoading == true
          ? Container(
        color: Colors.white,
        child: Center(
          child: SpinKitFoldingCube(
            color: AppColors.primaryColor,
            size: 50.0,
          ),
        ),
      )
          : firstAidController.isEmergencyContactLoading == false && firstAidController.emergencyContactList.isEmpty
          ? Lottie.asset(ImageAssets.lottieNoData)
          :  Container(
          child: RefreshIndicator(
            onRefresh: pullRefresh,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: firstAidController.emergencyContactList.length,
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1/1,
                ),
                itemBuilder: (buildContext, position) {
                  EmergencyContactModel emergencyContactModel = firstAidController.emergencyContactList[position];
                  return buildContacts(emergencyContactModel);
                }),
          )),
    );
  }
  // endregion

  // region buildContacts
  buildContacts(EmergencyContactModel emergencyContactModel) {
    return InkWell(
      onTap: () {
        _callNumber(emergencyContactModel.phoneNumber);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: AppColors.blackColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 0),
          )],
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: AppColors.smokeWhiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(
              color: AppColors.whiteColor,
                child: networkImageNew(checkValidString(emergencyContactModel.imageUrl) != "" ? StringAssets.baseUrl + emergencyContactModel.imageUrl : "", double.infinity, double.infinity, BoxFit.contain, AppColors.primaryColor, (){}))),
            Row(
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: myTextWidgetMaxLine(emergencyContactModel.emergency, TextAlign.center, AppColors.blackColor, 16, FontWeight.bold, 3))),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // endregion

  Future<void> pullRefresh() async {
    firstAidController.fetchEmergencyContactData();
  }

  // region Call Method
  _callNumber(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }
  // endregion

}
