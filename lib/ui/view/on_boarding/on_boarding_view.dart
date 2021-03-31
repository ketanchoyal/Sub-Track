import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/resources/resources.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'on_boarding_viewmodel.dart';

// TODO change image height based on screen size
// TODO Change align coordinates based on screen size
class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: AppColor.STLight,
      body: Navigator(
        onGenerateRoute: OnBoardingViewRouter().onGenerateRoute,
        key: StackedService.nestedNavigationKey(1)!,
      ),
      // body: ExtendedNavigator<OnBoardingViewRouter>(
      //   router: OnBoardingViewRouter(),
      //   initialRoute: OnBoardingViewRoutes.view1,
      //   navigatorKey: StackedService.nestedNavigationKey(1)!,
      // ),
    );
  }
}

class View1 extends StatelessWidget {
  const View1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => locator<OnBoardingViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: _STOnBoarding(
          index: 0,
          onSkipPressed: () {
            model.skip();
          },
          onBackPressed: () {},
          onPressed: () {
            model.navigate(1);
          },
        ),
      ),
    );
  }
}

class View2 extends StatelessWidget {
  const View2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => locator<OnBoardingViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: _STOnBoarding(
          index: 1,
          onSkipPressed: () {
            model.skip();
          },
          onBackPressed: () {
            model.back();
          },
          onPressed: () {
            model.navigate(2);
          },
        ),
      ),
    );
  }
}

class View3 extends StatelessWidget {
  const View3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      viewModelBuilder: () => locator<OnBoardingViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: _STOnBoarding(
          index: 2,
          onSkipPressed: () {
            model.skip();
          },
          onBackPressed: () {
            model.back();
          },
          onPressed: () {
            model.skip();
          },
        ),
      ),
    );
  }
}

class _STOnBoarding extends StatelessWidget {
  const _STOnBoarding({
    Key? key,
    required this.index,
    required this.onPressed,
    required this.onBackPressed,
    required this.onSkipPressed,
  }) : super(key: key);

  final int index;
  final Function() onPressed;
  final Function() onBackPressed;
  final Function() onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Hero(
              tag: "skip",
              transitionOnUserGestures: true,
              child: STButton(
                buttonType: ButtonType.SECONDARY,
                onPressed: onSkipPressed,
                buttonText: "Skip",
              ),
            ),
          ),
          if (index != 0)
            Align(
              alignment: Alignment.topLeft,
              child: Hero(
                tag: "back",
                transitionOnUserGestures: true,
                child: STButton(
                  buttonType: ButtonType.SECONDARY,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonText: "Back",
                ),
              ),
            ),
          Align(
            alignment: onBoardingData[index].alignment1,
            child: Image.asset(
              onBoardingData[index].image1,
              height: onBoardingData[index].image1Height,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: onBoardingData[index].alignment2,
            child: Hero(
              tag: index == 2 ? "" : "boy",
              transitionOnUserGestures: true,
              child: Image.asset(
                onBoardingData[index].image2,
                alignment: onBoardingData[index].alignment3,
                fit: BoxFit.cover,
                height: onBoardingData[index].image2Height,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.7, 0.55),
            child: Hero(
              tag: "title",
              transitionOnUserGestures: true,
              child: Text(
                onBoardingData[index].title,
                style: kOnBoardingTitleStyle,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.7, 0.8),
            child: Text(
              onBoardingData[index].subTitle,
              style: kBodyLargeStyle.copyWith(
                fontSize: 18,
                color: AppColor.STDarkLight,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.9, 1.0),
            child: Hero(
              tag: "counter",
              transitionOnUserGestures: true,
              child: SizedBox(
                height: 15,
                width: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: index == 0 ? 2 : 1,
                      child: Card(
                        color: index == 0
                            ? AppColor.STAccent
                            : AppColor.STAccentLight,
                        child: Container(),
                      ),
                    ),
                    Expanded(
                      flex: index == 1 ? 2 : 1,
                      child: Card(
                        color: index == 1
                            ? AppColor.STAccent
                            : AppColor.STAccentLight,
                        child: Container(),
                      ),
                    ),
                    Expanded(
                      flex: index == 2 ? 2 : 1,
                      child: Card(
                        color: index == 2
                            ? AppColor.STAccent
                            : AppColor.STAccentLight,
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.9, 1.0),
            child: Hero(
              tag: "nextBtn",
              transitionOnUserGestures: true,
              child: STButton(
                buttonType: ButtonType.ICON,
                icon: Center(
                  child: Icon(
                    index == 2 ? Icons.check : Icons.arrow_forward,
                    size: 30,
                  ),
                ),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<_OnBoardingModel> onBoardingData = [
  _OnBoardingModel(
    Assets.boy1,
    Assets.mobile1,
    "Track your \nSubscriptions",
    "Take Charge of your subscription \nnever get unexpected deductions",
    alignment1: Alignment(-1, -0.8),
    alignment2: Alignment(-0.8, 0.25),
    alignment3: Alignment(-2.0, 0.9),
    image1Height: 380,
    image2Height: 405,
  ),
  _OnBoardingModel(
    Assets.boy2,
    Assets.mobile2,
    "Everything \nyou need",
    "Choose from hundreds of existing \nservices or make one of your own",
    alignment1: Alignment(0.0, -0.8),
    alignment2: Alignment(0.0, 0.3),
    alignment3: Alignment(0.3, 0.0),
    image1Height: 480,
    image2Height: 380,
  ),
  _OnBoardingModel(
    Assets.boy3,
    Assets.notificatons,
    "Know before \nit’s too late",
    "Get notifications before you pay for \nyour next subscription ",
    alignment1: Alignment(0.0, -0.8),
    alignment2: Alignment(0.0, 0.3),
    alignment3: Alignment(0.3, 0.0),
    image1Height: 300,
    image2Height: 380,
  ),
];

class _OnBoardingModel {
  final String image2;
  final String image1;
  final String title;
  final String subTitle;
  final Alignment alignment1;
  final Alignment alignment2;
  final Alignment alignment3;
  final double image1Height;
  final double image2Height;

  _OnBoardingModel(
    this.image2,
    this.image1,
    this.title,
    this.subTitle, {
    required this.alignment1,
    required this.alignment2,
    required this.alignment3,
    required this.image1Height,
    required this.image2Height,
  });
}
