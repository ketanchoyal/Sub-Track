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
        barrierColor: Colors.black,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return cupertinoModalTransition(animation, child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
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
