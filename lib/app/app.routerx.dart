part of 'app.router.dart';

// NOTE This file contains custom page map which are to be replaced in _pagesMap variable in app.router.dart file
// This cutom map will enable modal_bottom_sheet (cupertino style)

class StackedRouterX extends StackedRouter {
  @override
  Map<Type, StackedRouteFactory> get pagesMap => {
        ...Map.from(_pagesMap),
        ...customPagesMap,
      };

  final customPagesMap = <Type, StackedRouteFactory>{
    NewSubscription: (data) {
      return buildAdaptiveSheetRoute(
        child: NewSubscription(),
        data: data,
        fullscreenDialog: true,
        maintainState: true,
      );
      return PageRouteBuilder<dynamic>(
        settings: data,
        barrierDismissible: true,
        barrierLabel: data.name,
        opaque: false,
        transitionDuration: Duration(milliseconds: 335),
        reverseTransitionDuration: Duration(milliseconds: 335),
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) {
          // return NewSubscription();
          return CupertinoFullscreenDialogTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            child: NewSubscription(),
            linearTransition: true,
          );
        },
      );
    },
    ActiveSubscriptionView: (data) {
      var args = data.getArgs<ActiveSubscriptionViewArguments>(nullOk: false);
      return TransparentRoute<dynamic>(
        builder: (context) => ActiveSubscriptionView(
          key: args.key,
          selectedSubId: args.selectedSubId,
        ),
        settings: data,
        backgroundColor: Colors.transparent,
        fullscreenDialog: true,
        maintainState: true,
      );
    },
  };
}

PageRoute<T> buildAdaptiveSheetRoute<T>({
  required Widget child,
  RouteSettings? data,
  bool maintainState = true,
  bool fullscreenDialog = false,
}) {
  // no transitions for web
  if (kIsWeb) {
    return PageRouteBuilder(
      pageBuilder: (ctx, _, __) => child,
      settings: data,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  } else if ((GetPlatform.isIOS || GetPlatform.isMacOS)) {
    //https://gist.github.com/devkabiir/57de88ce8d64dff9d3e6fe0627a8b654
    return PageRouteBuilder(
      settings: data,
      barrierDismissible: true,
      barrierLabel: data != null ? data.name : "",
      opaque: false,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      transitionDuration: const Duration(milliseconds: 335),
      reverseTransitionDuration: const Duration(milliseconds: 335),
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        // return NewSubscription();
        return CupertinoFullscreenDialogTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          child: child,
          linearTransition: true,
        );
      },
    );
  } else {
    return PageRouteBuilder(
      settings: data,
      barrierDismissible: true,
      barrierLabel: data != null ? data.name : "",
      opaque: false,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      transitionDuration: Duration(milliseconds: 200),
      reverseTransitionDuration: Duration(milliseconds: 200),
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
