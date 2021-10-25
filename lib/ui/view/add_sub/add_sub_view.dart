// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/dumb_widgets/add_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './add_sub_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubView extends ConsumerStatefulWidget {
  // final ScrollController scrollController = ScrollController();
  @override
  ConsumerState<AddSubView> createState() => _AddSubViewState();
}

class _AddSubViewState extends ConsumerState<AddSubView> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ref.read(addSubViewModelCNP).fetchBrands();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(addSubViewModelCNP);
    final isBusy =
        ref.watch(addSubViewModelCNP.select((value) => value.isBusy));
    // final brands =
    //     ref.watch(addSubViewModelCNP.select((value) => value.brands));
    return CupertinoPageScaffold(
      backgroundColor: AppColor.STPureWhite,
      resizeToAvoidBottomInset: false,
      child: NestedScrollView(
        // controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            if (GetPlatform.isAndroid)
              SliverToBoxAdapter(
                child: AppBar(
                  backgroundColor: AppColor.STAccent,
                  title: Text(
                    'Add Subscription',
                    style: kHeader3Style,
                  ),
                  leading: GestureDetector(
                    onTap: model.pop,
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 25,
                    ),
                  ),
                ),
              ),
            if (GetPlatform.isIOS || GetPlatform.isMacOS)
              CupertinoSliverNavigationBar(
                stretch: false,
                backgroundColor: AppColor.STPureWhite,
                border: Border(bottom: BorderSide.none),
                transitionBetweenRoutes: true,
                largeTitle: Text(
                  'Add Subscription',
                ),
                automaticallyImplyLeading: false,
                leading: SizedBox(),
                trailing: GestureDetector(
                  onTap: model.pop,
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 30,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  verticalSpaceTiny,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: STTextField(
                      focusNode: _focusNode,
                      padding: EdgeInsets.all(8),
                      onChanged: model.searchKeyword,
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
          ];
        },
        floatHeaderSlivers: true,
        body: isBusy
            ? Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: "plusButton",
                      transitionOnUserGestures: true,
                      child: STLoading(),
                    ),
                  ),
                ],
              )
            : MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  // physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.brands?.length ?? 0,
                  controller: (GetPlatform.isIOS || GetPlatform.isMacOS)
                      ? model.$uiServices.scrollController
                      : null,
                  // controller: ModalScrollController.of(context),
                  itemBuilder: (context, index) {
                    return STAddSubCard(
                      onTap: () {
                        model.navigateToAddDetails(brand: model.brands![index]);
                      },
                      brand: model.brands![index],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
