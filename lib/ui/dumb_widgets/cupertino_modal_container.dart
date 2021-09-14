// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

/// Inspiration taken from [modal_bottom_sheet](https://github.com/jamesblasco/modal_bottom_sheet)

class PlatformContainer extends StatelessWidget {
  /// Widget to render
  final Widget child;
  final Color? backgroundColor;

  /// Add padding to the top of [child], this is also the height of visible
  /// content behind [child]
  ///
  /// Defaults to 10
  final double topPadding;

  const PlatformContainer(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.topPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (GetPlatform.isIOS || GetPlatform.isMacOS)
        ? _CupertinoBottomSheetContainer(
            child: child,
            backgroundColor: backgroundColor,
            topPadding: topPadding,
            key: key,
          )
        : child;
  }
}

class _CupertinoBottomSheetContainer extends StatelessWidget {
  /// Widget to render
  final Widget child;
  final Color? backgroundColor;

  /// Add padding to the top of [child], this is also the height of visible
  /// content behind [child]
  ///
  /// Defaults to 10
  final double topPadding;
  const _CupertinoBottomSheetContainer(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.topPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final topPadding = this.topPadding + topSafeAreaPadding;
    final radius = Radius.circular(12);
    final shadow =
        BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);
    final backgroundColor = this.backgroundColor ??
        CupertinoTheme.of(context).scaffoldBackgroundColor;

    final decoration =
        BoxDecoration(color: backgroundColor, boxShadow: [shadow]);

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        child: Container(
          decoration: decoration,
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, // Remove top Safe Area
            child: child,
          ),
        ),
      ),
    );
  }
}
