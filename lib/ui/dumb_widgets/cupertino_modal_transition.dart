import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/view/home/home_view.dart';

cupertinoModalTransition(
  animation,
  child,
) {
  return _CupertinoModalTransition(
    animation: animation,
    behindChild: HomeView()
      ..build(StackedService.navigatorKey!.currentState!.context),
    child: child,
  );
}

/// Inspiration taken from [modal_bottom_sheet](https://github.com/jamesblasco/modal_bottom_sheet)
class _CupertinoModalTransition extends StatelessWidget {
  /// Animation that [child] will use for entry or leave
  final Animation<double> animation;

  /// Animation curve to be applied to [animation]
  ///
  /// Defaults to [Curves.easeOut]
  final Curve? animationCurve;

  /// Widget that will be displayed at the top
  final Widget child;

  /// Widget that will be displayed behind [child]
  ///
  /// Usually this is the route that shows this model
  final Widget behindChild;

  const _CupertinoModalTransition({
    Key? key,
    required this.animation,
    required this.child,
    required this.behindChild,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var startRoundCorner = 0.0;
    final paddingTop = MediaQuery.of(context).padding.top;
    if (Theme.of(context).platform == TargetPlatform.iOS && paddingTop > 20) {
      startRoundCorner = 38.5;
      // See: https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: animationCurve ?? Curves.easeOut,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      /// Because the first element of the stack below is a black coloured
      /// container, this is required
      value: SystemUiOverlayStyle.light,
      child: AnimatedBuilder(
        animation: curvedAnimation,
        child: child,
        builder: (context, child) {
          final progress = curvedAnimation.value;
          final yOffset = progress * paddingTop;
          final scale = 1 - progress / 10;
          final radius = progress == 0
              ? 0.0
              : (1 - progress) * startRoundCorner + progress * 12;
          return Stack(
            children: [
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(color: Colors.black),
              ),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: behindChild,
                    ),
                  ),
                ),
              ),
              child!,
            ],
          );
        },
      ),
    );
  }
}
