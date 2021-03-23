import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/dumb_widgets/segment_controller.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './select_icon_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

import 'widgets/emoji_group.dart';

class SelectIconView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectIconViewModel>.reactive(
      viewModelBuilder: () => SelectIconViewModel(),
      onModelReady: (model) => model.fetchBrands(),
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
                largeTitle: Text("Select Icon"),
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
                    onTap: model.pop,
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
                  child: STSegmentController<IconType>(
                    onValueChanged: model.selectIconType,
                    children: IconType.values
                        .map((e) => {e: e.convertToString})
                        .fold<Map<IconType, String>>(
                            {},
                            (previousValue, element) =>
                                {...previousValue, ...element}),
                    selectedValue: model.iconType,
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: STTextField(
                          focusNode: FocusNode(),
                          padding: EdgeInsets.all(8),
                          type: TextFieldType.DEFAULT,
                          textInputAction: TextInputAction.search,
                          placeholder: "Search",
                          onChanged: model.searchKeyword,
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
            bottom: false,
            child: Stack(
              children: [
                if (model.iconType == IconType.Services)
                  if (model.isBusy)
                    Center(
                      child: CupertinoActivityIndicator(
                        animating: model.isBusy,
                        radius: 15,
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.STPureWhite,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: screenWidth(context) ~/ 70,
                        ),
                        itemCount: model.brands?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            // color: Colors.transparent,
                            shape: kRoundedCardBorder(
                                side: kDefaultCardBorderSide),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.network(
                                model.brands![index].iconUrl!,
                                semanticsLabel: model.brands![index].iconName,
                                placeholderBuilder: (BuildContext context) =>
                                    const CupertinoActivityIndicator(
                                  animating: true,
                                ),
                                color: model.brands![index].hex.toColor(),
                              ),
                            ),
                          );
                        },
                      ).paddingA10(),
                    ).paddingA10(),
                if (model.iconType == IconType.Emoji)
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        // color: AppColor.STPureWhite,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          EmojiGroup(
                            categoryName: "Smiley",
                            emojis: model.simileyEmojiList,
                            onPressed: (emoji) {
                              print(emoji);
                            },
                            onShowMorePressed: model.toogleShowMoreSmiley,
                            showMore: model.showMoreSmiley,
                          ),
                          EmojiGroup(
                            categoryName: "Objects",
                            emojis: model.objectEmojiList,
                            onPressed: (emoji) {
                              print(emoji);
                            },
                            onShowMorePressed: model.toogleShowMoreObjects,
                            showMore: model.showMoreObject,
                          ),
                          EmojiGroup(
                            categoryName: "Symbols",
                            emojis: model.symbolEmojiList,
                            onPressed: (emoji) {
                              print(emoji);
                            },
                            onShowMorePressed: model.toogleShowMoreSymbols,
                            showMore: model.showMoreSymbols,
                          ),
                          EmojiGroup(
                            categoryName: "Flags",
                            emojis: model.flagEmojiList,
                            onPressed: (emoji) {
                              print(emoji);
                            },
                            onShowMorePressed: model.toogleShowMoreFlags,
                            showMore: model.showMoreFlags,
                          ),
                          EmojiGroup(
                            categoryName: "People",
                            emojis: model.peopleEmojiList,
                            onPressed: (emoji) {
                              print(emoji);
                            },
                            onShowMorePressed: model.toogleShowMorePeople,
                            showMore: model.showMorePeople,
                          ),
                        ],
                      ),
                    ).paddingA10(),
                  ),
              ],
            ),
          ),
        ),
      ).addModalContainer(additionalTopPadding: -10),
    );
  }
}
