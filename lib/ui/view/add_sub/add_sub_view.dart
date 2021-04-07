import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/add_subscription_card.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/dumb_widgets/text_fields.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './add_sub_viewmodel.dart';
import 'package:sub_track/ui/shared/shared.dart';

class AddSubView extends StatelessWidget {
  // final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSubViewModel>.reactive(
      viewModelBuilder: () => AddSubViewModel(),
      onModelReady: (model) => model.fetchBrands(),
      builder: (context, model, child) => CupertinoPageScaffold(
        backgroundColor: AppColor.STPureWhite,
        resizeToAvoidBottomInset: false,
        child: NestedScrollView(
          // controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
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
          body: model.isBusy
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
                    controller: model.uiService.scrollController,
                    // controller: ModalScrollController.of(context),
                    itemBuilder: (context, index) {
                      return STAddSubCard(
                        onTap: () {
                          model.navigateToAddDetails(
                              brand: model.brands![index]);
                        },
                        brand: model.brands![index],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
