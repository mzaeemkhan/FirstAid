import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/response/FirstAidModel.dart';
import 'package:first_aid/modules/widgets/custom_app_bar.dart';
import 'package:first_aid/modules/widgets/search_delegate.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/image_assets.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';
import '../first_aid/first_aid_subheadings.dart';
import '../widgets/common_widgets.dart';
import '../widgets/stateful_widgets.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // region Variables
  FirstAidController firstAidController;
  final key = new GlobalKey<ScaffoldState>();
  // final TextEditingController _searchQuery = new TextEditingController();
  // Widget appBarTitle = directionalityWidget(
  //     StringAssets.isLangEnglish ? TextDirection.ltr : TextDirection.rtl,
  //     textWidget(
  //         StringAssets.isLangEnglish ? StringAssets.eTextFirstAid : StringAssets.uTextFirstAid,
  //         StringAssets.isLangEnglish ? AppStyles.eAppBarStyle : AppStyles.uAppBarStyle));

  Icon actionIcon = iconWidget(Icons.search, AppColors.whiteColor);
  bool isSearching;
  // String _searchText = "";
  // endregion

  // _MainPageState() {
  //   _searchQuery.addListener(() {
  //     if (_searchQuery.text.isEmpty) {
  //       setState(() {
  //         isSearching = false;
  //         _searchText = "";
  //         _buildSearchList();
  //       });
  //     } else {
  //       setState(() {
  //         isSearching = true;
  //         _searchText = _searchQuery.text;
  //         _buildSearchList();
  //       });
  //     }
  //   });
  // }

  Future<void> pullRefresh() async {
    firstAidController.fetchFirstAidData();
  }

  // region initState Method
  @override
  void initState() {
    super.initState();
    // isSearching = false;
    try{
      firstAidController = Get.find();
      firstAidController.fetchFirstAidData();
    }catch(exception){
      firstAidController = Get.put(FirstAidController());
      firstAidController.fetchFirstAidData();
    }
  }
  // endregion

  // region Build AppBar
  // Widget buildAppBar(BuildContext context) {
  //   return AppBar(
  //       centerTitle: true,
  //       title: myText("first_aid".tr, TextAlign.left, AppColors.whiteColor, 16.0, FontWeight.bold),
  //       backgroundColor: AppColors.primaryColor,
  //       actions: <Widget>[
  //
  //       ]);
  // }
  // endregion

  // region build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: key,
      appBar: customAppBar(
          "first_aid".tr,
          Icons.dehaze_rounded,
              (){key.currentState.openDrawer();},
          [
            IconButton(
              icon: actionIcon,
              onPressed: () {
                // setState(() {
                //   if (this.actionIcon.icon == Icons.search) {
                //     this.actionIcon = iconWidget(Icons.close, AppColors.whiteColor);
                //     this.appBarTitle = directionalityWidget(
                //         StringAssets.isLangEnglish ? TextDirection.ltr : TextDirection.rtl,
                //         searchTextFieldWidget(_searchQuery,
                //             StringAssets.isLangEnglish ? AppStyles.eSearchStyle : AppStyles.uSearchStyle,
                //             StringAssets.isLangEnglish ? StringAssets.eSearchText : StringAssets.uSearchText)
                //     );
                //     _handleSearchStart();
                //   }
                //   else {
                //     _handleSearchEnd();
                //   }
                // });
                showSearch(context: context, delegate: MySearchModel(firstAidController));
              },
            ),
          ],
          null
      ),
      drawer: DrawerWidget(),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          var result = snapshot.data;
          switch (result) {
            case ConnectivityResult.none:
              break;
            case ConnectivityResult.mobile:
            case ConnectivityResult.wifi:
              Timer(Duration(seconds: 5), () {
                if(firstAidController.firstAidList.isEmpty && !firstAidController.isFirstAidDataLoading){
                  firstAidController.fetchFirstAidData();
                }
              });
              break;
            default:
              break;
          }
          return buildBody();
        },
      ),
      floatingActionButton: floatingAB(context),
    );
  }
  // endregion

  // region buildBody
  Widget buildBody() {
    return GetBuilder<FirstAidController>(
      builder: (_) => firstAidController.isFirstAidDataLoading == true
          ? Container(
        color: Colors.white,
        child: Center(
          child: SpinKitFoldingCube(
            color: AppColors.primaryColor,
            size: 50.0,
          ),
        ),
      )
          : firstAidController.isFirstAidDataLoading == false && firstAidController.firstAidList.isEmpty
          ? Lottie.asset(ImageAssets.lottieNoData)
          :  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
            onRefresh: pullRefresh,
            child: AnimationLimiter(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: firstAidController.firstAidList.length,
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 13,
                    childAspectRatio: 1/1,
                    //childAspectRatio: 0.9/1.0,
                  ),
                  itemBuilder: (buildContext, position) {
                    FirstAidModel firstAidModel = firstAidController.firstAidList[position];
                    return UiItem(firstAidModel, position, firstAidController.firstAidList.length, firstAidController);
                  }),
            ),
          )),
    );
  }
  // endregion

  // region Search Handling
  // void _handleSearchStart() {
  //   setState(() {
  //     isSearching = true;
  //   });
  // }

  // void _handleSearchEnd() {
  //   setState(() {
  //     this.actionIcon = iconWidget(Icons.search, AppColors.whiteColor);
  //     this.appBarTitle = directionalityWidget(
  //       StringAssets.isLangEnglish ? TextDirection.ltr : TextDirection.rtl,
  //       textWidget(
  //           StringAssets.isLangEnglish ? StringAssets.eTextFirstAid : StringAssets.uTextFirstAid,
  //           StringAssets.isLangEnglish ? AppStyles.eAppBarStyle : AppStyles.uAppBarStyle),
  //     );
  //     isSearching = false;
  //     _searchQuery.clear();
  //   });
  // }
  // endregion

  // region Search Building
  // List<FirstAidModel> _buildSearchList() {
  //   if (_searchText.isEmpty) {
  //     return _firstAidController.searchList = _firstAidController.firstAidList;
  //   }
  //   else {
  //     if(StringAssets.isLangEnglish) {
  //       _firstAidController.searchList = _firstAidController.firstAidList
  //           .where((element) =>
  //           element.engName.toLowerCase().contains(_searchText.toLowerCase()))
  //           .toList();
  //     }
  //     else {
  //       _firstAidController.searchList = _firstAidController.firstAidList
  //           .where((element) =>
  //           element.urName.contains(_searchText))
  //           .toList();
  //     }
  //
  //     return _firstAidController.searchList;
  //   }
  // }
  // endregion
}

class UiItem extends StatelessWidget {

  // region Variables
  final FirstAidModel firstAidModel;
  final int index, length;
  FirstAidController firstAidController;
  UiItem(this.firstAidModel, this.index, this.length, this.firstAidController);
  // endregion

  // region build Method
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FirstAidSubHeading(selectedModel: firstAidModel,)));
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Container(
                  color: AppColors.whiteColor,
                  child: networkImageNew(checkValidString(firstAidModel.icon) != "" ? StringAssets.baseUrl + firstAidModel.icon : "", double.infinity, double.infinity, BoxFit.contain, AppColors.primaryColor, (){}))),
              Row(
                children: [
                  Expanded(child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: myTextWidgetMaxLine(firstAidController.languageEnglish ? firstAidModel.engName : firstAidModel.urName, TextAlign.center, AppColors.blackColor, 16, FontWeight.bold, 3))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  // endregion
}