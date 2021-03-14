import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import './home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text(
                  'Summary',
                ),
                padding: EdgeInsetsDirectional.only(end: 5),
                trailing: CircleAvatar(
                  backgroundColor: AppColor.STPureWhite.withOpacity(0.4),
                  radius: 18,
                  child: Center(
                    child: Text(
                      "KC",
                      style: kBodyBoldStyle.copyWith(
                        color: AppColor.STDark,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          floatHeaderSlivers: true,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: AppColor.STPureWhite.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
