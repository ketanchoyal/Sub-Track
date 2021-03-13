import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/ui/dumb_widgets/buttons.dart';
import 'package:sub_track/ui/resources/resources.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';
import 'on_boarding1_viewmodel.dart';

class OnBoarding1View extends StatelessWidget {
  final String heroTag = "tag";
  final int index = 2;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoarding1ViewModel>.reactive(
      viewModelBuilder: () => OnBoarding1ViewModel(),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        backgroundColor: AppColor.STLight,
        // body: Column(
        //   children: [Body()],
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: STButton(
                  buttonType: ButtonType.SECONDARY,
                  onPressed: () {},
                  buttonText: "Skip",
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
                child: Image.asset(
                  onBoardingData[index].image2,
                  alignment: onBoardingData[index].alignment3,
                  fit: BoxFit.cover,
                  height: onBoardingData[index].image2Height,
                ),
              ),
              Align(
                alignment: Alignment(-0.7, 0.55),
                child: Text(
                  onBoardingData[index].title,
                  style: kOnBoardingTitleStyle,
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
                child: SizedBox(
                  height: 15,
                  width: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          color: AppColor.STAccent,
                          child: Container(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          color: AppColor.STAccentLight,
                          child: Container(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          color: AppColor.STAccentLight,
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.9, 1.0),
                child: STButton(
                  buttonType: ButtonType.ICON,
                  icon: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
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
    image2Height: 400,
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

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final String open1 = 'open';

//   int count = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Container(
//             child: NotificationListener<OverscrollIndicatorNotification>(
//                 onNotification: (OverscrollIndicatorNotification overscroll) {
//                   overscroll.disallowGlow();
//                   return true;
//                 },
//                 child: PageView.builder(
//                     reverse: true,
//                     pageSnapping: false,
//                     controller: PageController(viewportFraction: 0.85),
//                     itemCount: count,
//                     itemBuilder: (context, i) {
//                       if (i == 0) {
//                         return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Page(
//                                           open: open1,
//                                         )),
//                               );
//                               count++;
//                             },
//                             child: Hero(
//                                 tag: open1,
//                                 child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left:
//                                             MediaQuery.of(context).size.height *
//                                                 0.015,
//                                         right:
//                                             MediaQuery.of(context).size.height *
//                                                 0.015,
//                                         top: MediaQuery.of(context).size.width *
//                                             0.08,
//                                         bottom:
//                                             MediaQuery.of(context).size.width *
//                                                 0.15),
//                                     child: Material(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         color: Colors.white,
//                                         elevation: 8.0,
//                                         child: InkWell(
//                                           child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Icon(
//                                                   Icons.add,
//                                                   size: 30.0,
//                                                   color: Colors.black,
//                                                 )
//                                               ]),
//                                         )))));
//                       } else {
//                         return RCard(i);
//                       }
//                     }))));
//   }
// }

// class RCard extends StatefulWidget {
//   final int count;

//   RCard(this.count);

//   @override
//   RCardState createState() => RCardState();
// }

// class RCardState extends State<RCard> {
//   late int count;
//   late String open2;
//   @override
//   void initState() {
//     super.initState();
//     open2 = 'open$count';
//     count = widget.count;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: open2,
//       child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Page(
//                         open: open2,
//                       )),
//             );
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.height * 0.015,
//                 right: MediaQuery.of(context).size.height * 0.015,
//                 top: MediaQuery.of(context).size.width * 0.08,
//                 bottom: MediaQuery.of(context).size.width * 0.15),
//             child: Material(
//                 borderRadius: BorderRadius.circular(40.0),
//                 color: Colors.white,
//                 elevation: 8.0,
//                 child: Padding(
//                   padding:
//                       EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
//                 )),
//           )),
//     );
//   }
// }

// class Page extends StatelessWidget {
//   final String open;

//   Page({required this.open});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Hero(tag: open, child: Material()),
//       onTap: () {
//         Navigator.pop(context);
//       },
//     );
//   }
// }
