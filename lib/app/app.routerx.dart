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
  };
}
