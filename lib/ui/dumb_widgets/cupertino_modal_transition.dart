import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animator/animator.dart';
import 'dart:io';

// FileService _fileService = locator<FileService>();
// cupertinoModalTransition(
//   animation,
//   child,
// ) {
//   return CupertinoModalTransition(
//     animation: animation,
//     behindChild: Container(
//       color: Colors.red,
//     ),
//     child: child,
//   );
// }

/// Inspiration taken from [modal_bottom_sheet](https://github.com/jamesblasco/modal_bottom_sheet)
class CupertinoModalTransition extends StatelessWidget {
  /// Widget that will be displayed at the top
  final Widget child;
  final AnimatorKey<double> animatorKey;

  CupertinoModalTransition({
    Key? key,
    required this.child,
    required this.animatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
        animatorKey: animatorKey,
        tween: Tween<double>(begin: 0.0, end: 1.0),
        cycles: 1,
        duration: Duration(milliseconds: 335),
        builder: (context, animatorState, _) {
          var startRoundCorner = 0.0;
          final paddingTop = MediaQuery.of(context).padding.top;
          if (Theme.of(context).platform == TargetPlatform.iOS &&
              paddingTop > 20) {
            startRoundCorner = 38.5 * animatorState.value;
            // See: https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
          }
          return AnnotatedRegion<SystemUiOverlayStyle>(
            /// Because the first element of the stack below is a black coloured
            /// container, this is required
            value: SystemUiOverlayStyle.light,
            child: AnimatedBuilder(
              animation: animatorState.controller,
              child: child,
              builder: (context, child) {
                // animatorKey.controller.forward();
                final progress = animatorState.value;
                final yOffset = Platform.isIOS ? progress * paddingTop : 0.0;
                final scale = Platform.isIOS ? 1 - progress / 10 : 1.0;
                final radius = Platform.isIOS
                    ? progress == 0
                        ? 0.0
                        : (1 - progress) * startRoundCorner + progress * 12
                    : 0.0;
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        animatorKey.controller.reverse();
                        // Navigator.of(context).pop();
                      },
                      child: Container(color: Colors.black),
                    ),
                    Transform.translate(
                      offset: Offset(0, yOffset),
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: child,
                        ),
                      ),
                    ),
                    // child!,
                  ],
                );
              },
            ),
          );
        });
  }
}
