// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/dumb_widgets/loading.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'other_select_viewmodel.dart';
import 'widgets/other_option_element.dart';

class OtherSelectView extends ConsumerStatefulWidget {
  const OtherSelectView({Key? key, required this.selected, required this.type})
      : super(key: key);
  final dynamic selected;
  final OtherDetailSelectType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OtherSelectViewState();
  }
}

class _OtherSelectViewState extends ConsumerState<OtherSelectView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      ref
          .read(otherSelectViewModelCNP)
          .setupType(widget.type, selected: widget.selected);
    });
  }

  Widget appbar(model, context) {
    return (GetPlatform.isIOS || GetPlatform.isMacOS)
        ? CupertinoNavigationBar(
            // border: Border(bottom: BorderSide.none),
            backgroundColor: AppColor.STPureWhite,
            automaticallyImplyLeading: false,
            transitionBetweenRoutes: true,
            middle: Text(widget.type.name),
            leading: Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 7),
              child: GestureDetector(
                onTap: () {
                  model.pop(selected: widget.selected);
                },
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
          )
        : AppBar(
            backgroundColor: AppColor.STAccent,
            title: Text(
              widget.type.name,
              style: kHeader3Style,
            ),
            leading: GestureDetector(
              onTap: () => model.pop(selected: widget.selected),
              child: Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(otherSelectViewModelCNP);
    // final isBusy =
    //     ref.watch(otherSelectViewModelCNP.select((value) => value.isBusy));
    return Scaffold(
      backgroundColor: AppColor.STLight,
      appBar: appbar(model, context) as PreferredSizeWidget,
      body: model.isBusy
          ? Stack(
              children: [
                Center(
                  child: STLoading(),
                ),
              ],
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: CupertinoFormSection.insetGrouped(
                    margin: EdgeInsets.all(8),
                    children: model
                        .getOptions()
                        .map((e) => OtherOptionViewElement(
                              selected: model.selected,
                              onTap: () {
                                model.pop(selected: e[1]);
                              },
                              option: e[0],
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
    );
  }
}
