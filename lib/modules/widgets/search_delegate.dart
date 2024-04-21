import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/response/FirstAidModel.dart';
import 'package:first_aid/modules/first_aid/first_aid_subheadings.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/app_colors.dart';
import 'package:first_aid/shared/constants/string_assets.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//region delegate class for search functionality
class MySearchModel extends SearchDelegate<FirstAidModel> {
  FirstAidController firstAidController;
  MySearchModel(this.firstAidController) : super(searchFieldLabel: "search_hint".tr);

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear, color: AppColors.whiteColor, size: 24.0,),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 24.0,),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListTile(
      title: myText(query, TextAlign.left, AppColors.primaryColor, 16, FontWeight.bold),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var myList;
    if(firstAidController.languageEnglish){
      myList = query.isEmpty ? firstAidController.firstAidList : firstAidController.firstAidList.where((element) => element.engName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    else{
      myList = query.isEmpty ? firstAidController.firstAidList : firstAidController.firstAidList.where((element) => element.urName.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return myList.isEmpty
        ? ListTile(
      title: myText("no_result_found".tr, TextAlign.left, AppColors.primaryColor, 16, FontWeight.bold),
    )
        : ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: myList.length,
      itemBuilder: (context, index) {
        final FirstAidModel myModel = myList[index];
        return InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FirstAidSubHeading(selectedModel: myModel,)));
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: AppColors.blackColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              )],
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: AppColors.whiteColor,
            ),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.smokeWhiteColor
                  ),
                  child: networkImageNew(checkValidString(myModel.icon) != "" ? StringAssets.baseUrl + myModel.icon : "", 70.0, 70.0, BoxFit.fill, AppColors.primaryColor, (){}),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: myText(firstAidController.languageEnglish ? myModel.engName : myModel.urName, TextAlign.left, AppColors.blackColor, 16, FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
//endregion