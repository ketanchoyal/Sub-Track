import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/segment_controller.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './select_icon_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

import 'widgets/emoji_group.dart';

class SelectIconView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SelectIconViewState();
  }
}

class _SelectIconViewState extends ConsumerState<SelectIconView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ref.read(selectIconViewModelCNP).fetchBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(selectIconViewModelCNP);
    final isBusy =
        ref.watch(selectIconViewModelCNP.select((value) => value.isBusy));
    final iconType =
        ref.watch(selectIconViewModelCNP.select((value) => value.iconType));
    final showMoreSmiley = ref
        .watch(selectIconViewModelCNP.select((value) => value.showMoreSmiley));
    final showMorePeople = ref
        .watch(selectIconViewModelCNP.select((value) => value.showMorePeople));
    final showMoreSymbols = ref
        .watch(selectIconViewModelCNP.select((value) => value.showMoreSymbols));
    final showMoreFlags = ref
        .watch(selectIconViewModelCNP.select((value) => value.showMoreFlags));
    final showMoreObject = ref
        .watch(selectIconViewModelCNP.select((value) => value.showMoreObject));

    return CupertinoPageScaffold(
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
                padding:
                    const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
                child: GestureDetector(
                  onTap: model.pop,
                  child: Text.rich(
                    TextSpan(
                      text: String.fromCharCode(CupertinoIcons.back.codePoint),
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
                  selectedValue: iconType,
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
              if (iconType == IconType.Services)
                if (isBusy)
                  Center(
                    child: STLoading(),
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
                        return GestureDetector(
                          onTap: () {
                            model.selectService(model.brands![index]);
                          },
                          child: Card(
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
                          ),
                        );
                      },
                    ).paddingA10(),
                  ).paddingA10(),
              if (iconType == IconType.Emoji)
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
                        EmojisGroup(
                          categoryName: "Smiley",
                          emojis: model.simileyEmojiList,
                          onPressed: model.selectEmoji,
                          onShowMorePressed: model.toogleShowMoreSmiley,
                          showMore: showMoreSmiley,
                        ),
                        EmojisGroup(
                          categoryName: "Objects",
                          emojis: model.objectEmojiList,
                          onPressed: model.selectEmoji,
                          onShowMorePressed: model.toogleShowMoreObjects,
                          showMore: showMoreObject,
                        ),
                        EmojisGroup(
                          categoryName: "Symbols",
                          emojis: model.symbolEmojiList,
                          onPressed: model.selectEmoji,
                          onShowMorePressed: model.toogleShowMoreSymbols,
                          showMore: showMoreSymbols,
                        ),
                        EmojisGroup(
                          categoryName: "Flags",
                          emojis: model.flagEmojiList,
                          onPressed: model.selectEmoji,
                          onShowMorePressed: model.toogleShowMoreFlags,
                          showMore: showMoreFlags,
                        ),
                        EmojisGroup(
                          categoryName: "People",
                          emojis: model.peopleEmojiList,
                          onPressed: model.selectEmoji,
                          onShowMorePressed: model.toogleShowMorePeople,
                          showMore: showMorePeople,
                        ),
                      ],
                    ),
                  ).paddingA10(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
