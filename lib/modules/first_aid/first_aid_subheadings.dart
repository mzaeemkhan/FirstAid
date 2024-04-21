import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/response/FirstAidModel.dart';
import 'package:first_aid/modules/widgets/custom_app_bar.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';
import '../detail/details_screen.dart';
import '../widgets/common_widgets.dart';

class FirstAidSubHeading extends StatefulWidget {
  FirstAidModel selectedModel;
  FirstAidSubHeading({Key key, this.selectedModel}) : super(key: key);

  @override
  _FirstAidSubHeadingState createState() => _FirstAidSubHeadingState();
}

class _FirstAidSubHeadingState extends State<FirstAidSubHeading> {
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
          firstAidController.languageEnglish ? widget.selectedModel.engName : widget.selectedModel.urName,
          Icons.arrow_back,
              (){Navigator.pop(context, false);},
          [],
          null
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount:  widget.selectedModel.firstAidLists.length,
            padding: EdgeInsets.all(10.0),
            itemBuilder: (buildContext, position) {
              FirstAidList firstAid =  widget.selectedModel.firstAidLists[position];
              return _buildSubHeading(firstAid, position);
            }),
      ),
      floatingActionButton: floatingAB(context),
    );
  }
  // endregion

  // region buildList
  _buildSubHeading(FirstAidList firstAid, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(
              title: firstAidController.languageEnglish ? firstAid.engListName : firstAid.urListName,
              heading: firstAidController.languageEnglish ? firstAid.engHeading : firstAid.urHeading,
              details: firstAidController.languageEnglish ? firstAid.engDetail : firstAid.urDetail,
              imageUrl: widget.selectedModel.icon,
              firstAidStepsList: firstAid.firstAidStepLists,
            )));
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
          color: AppColors.whiteColor,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: networkImageNew(checkValidString(widget.selectedModel.icon) != "" ? StringAssets.baseUrl + widget.selectedModel.icon : "",
                      90.0, 90.0, BoxFit.fill, AppColors.primaryColor, (){}),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: myText(firstAidController.languageEnglish ? firstAid.engListName : firstAid.urListName, TextAlign.start, AppColors.blackColor, 16, FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: myText(firstAidController.languageEnglish ? firstAid.engDetail : firstAid.urDetail, TextAlign.start, AppColors.blackColor, 16, FontWeight.normal),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
// endregion
}