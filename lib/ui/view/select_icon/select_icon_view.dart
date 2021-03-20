import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/segment_controller.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './select_icon_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class SelectIconView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  showSearchBar() async {
    await _scrollController.animateTo(50,
        duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectIconViewModel>.reactive(
      viewModelBuilder: () => SelectIconViewModel(),
      onModelReady: (model) => {
        // _scrollController.addListener(() {
        //   showSearchBar();
        // })
      },
      builder: (context, model, child) => CupertinoPageScaffold(
        // backgroundColor: AppColor.STPureWhite,
        child: NestedScrollView(
          controller: _scrollController,
          // physics: BouncingScrollPhysics(),
          physics: ClampingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                border: Border(bottom: BorderSide.none),
                backgroundColor: AppColor.STPureWhite,
                automaticallyImplyLeading: false,
                transitionBetweenRoutes: true,
                largeTitle: STSegmentController<IconType>(
                  onValueChanged: model.selectIconType,
                  children: IconType.values
                      .map((e) => {e: e.convertToString})
                      .fold<Map<IconType, String>>(
                          {},
                          (previousValue, element) =>
                              {...previousValue, ...element}),
                  selectedValue: model.iconType,
                ),
                middle: Text(
                  "Select Icon",
                  style: kNavigationStyle,
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    CupertinoIcons.plus,
                    size: 30,
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 0, end: 0, top: 7),
                  child: GestureDetector(
                    onTap: () {
                      model.pop();
                    },
                    child: Text.rich(
                      TextSpan(
                        text:
                            String.fromCharCode(CupertinoIcons.back.codePoint),
                        style: TextStyle(
                          inherit: false,
                          color: CupertinoTheme.of(context).primaryColor,
                          fontSize: 30.0,
                          fontFamily: CupertinoIcons.back.fontFamily,
                          package: CupertinoIcons.back.fontPackage,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: AppColor.STPureWhite,
                  child: Column(
                    children: <Widget>[
                      verticalSpaceTiny,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: STTextField(
                          focusNode: FocusNode(),
                          padding: EdgeInsets.all(8),
                          type: TextFieldType.DEFAULT,
                          textInputAction: TextInputAction.search,
                          placeholder: "Search",
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              CupertinoIcons.search_circle_fill,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            child: Stack(
              children: [
                if (model.iconType == IconType.Services)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.STPureWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: 80,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Card(
                            elevation: 0,
                            color: Colors.black26,
                          ),
                        );
                      },
                    ).paddingA10(),
                  ).paddingA10(),
                if (model.iconType == IconType.Emoji)
                  Container(
                      decoration: BoxDecoration(
                        color: AppColor.STPureWhite,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [],
                      )),
              ],
            ),
          ),
        ),
      ).addModalContainer(additionalTopPadding: -10),
    );
  }
}
