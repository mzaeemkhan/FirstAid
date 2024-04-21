import 'package:expandable/expandable.dart';
import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/response/FirstAidModel.dart';
import 'package:first_aid/modules/widgets/custom_app_bar.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';
import '../widgets/common_widgets.dart';

class DetailsPage extends StatefulWidget {

  // region Variables
  final String title, heading, imageUrl, details;
  final List<FirstAidStepList> firstAidStepsList;
  // endregion

  DetailsPage({this.title, this.heading, this.details, this.imageUrl, this.firstAidStepsList});

  @override
  _DetailsPageState createState() => _DetailsPageState(title: title, heading: heading, details: details, imageUrl: imageUrl, firstAidStepsList: firstAidStepsList);
}

class _DetailsPageState extends State<DetailsPage> {

  // region Variables
  final String title, heading, imageUrl, details;
  final List<FirstAidStepList> firstAidStepsList;
  // endregion

  _DetailsPageState({@required this.title, @required this.heading, @required this.details, @required this.imageUrl, @required this.firstAidStepsList});

  FirstAidController firstAidController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      firstAidController = Get.find();
    }catch(exception){
      firstAidController = Get.put(FirstAidController());
    }
  }

  // region build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: customAppBar(
          widget.title,
          Icons.arrow_back,
              (){Navigator.pop(context, false);},
          [],
          null
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: firstAidController.languageEnglish ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            // region Image
            networkImageNew(checkValidString(imageUrl) != "" ? StringAssets.baseUrl + imageUrl : "", 250.0, MediaQuery.of(context).size.width, BoxFit.fill, AppColors.primaryColor, (){}),
            // endregion

            // region Heading
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: myText("about".trParams({
                      "name": "$title"
                    }), TextAlign.start, AppColors.primaryColor, 16, FontWeight.bold),
                  )
                ],
              ),
            ),
            // endregion

            // region Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: myText(details, TextAlign.start, AppColors.blackColor, 16, FontWeight.normal),
                  )
                ],
              ),
            ),
            // endregion

            // region Heading
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: myText(heading, TextAlign.start, AppColors.primaryColor, 16, FontWeight.bold),
                  )
                ],
              ),
            ),
            // endregion

            // region Expanded Item
            ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: AppColors.primaryColor,
                useInkWell: true,
              ),
              child: ListView.builder(
                itemCount: firstAidStepsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return buildExpanded(firstAidStepsList[index], index);
                },
              ),
            ),
            // endregion
          ],
        ),
      ),
      floatingActionButton: floatingAB(context),
    );
  }
  // endregion

  // region Expanded Widget
  Widget buildExpanded(FirstAidStepList _firstAidStepsList, int position) {
    return ExpandableNotifier(
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                    hasIcon: true,
                    iconSize: 30.0,
                  ),
                  // region Heading
                  header: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: myText(firstAidController.languageEnglish ? _firstAidStepsList.engStepNumber : _firstAidStepsList.urStepNumber, TextAlign.start, AppColors.primaryColor, 16, FontWeight.bold)),
                      ],
                    ),
                  ),
                  // endregion

                  collapsed: null,
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // region Image
                      checkValidString(_firstAidStepsList.imageUrl) != ""
                          ? networkImageNew(StringAssets.baseUrl + imageUrl, 200.0, MediaQuery.of(context).size.width, BoxFit.fill, AppColors.primaryColor, (){})
                          : Container(),
                      // endregion

                      // region Step Details
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: myText(firstAidController.languageEnglish ? _firstAidStepsList.engStepDetails : _firstAidStepsList.urStepDetails, TextAlign.start, AppColors.blackColor, 16, FontWeight.normal),
                            )
                          ],
                        ),
                      )
                      // endregion
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // endregion
}