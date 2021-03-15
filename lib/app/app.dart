// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked/src/code_generation/router/transitions_builders.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/home/home_view.dart';
import 'package:sub_track/ui/view/login/login_view.dart';
import 'package:sub_track/ui/view/on_boarding/on_boarding_view.dart';
import 'package:sub_track/ui/view/on_boarding/on_boarding_viewmodel.dart';
import 'package:sub_track/ui/view/register/register_view.dart';
import 'package:sub_track/ui/view/startup/startup_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: DemoView),
    CupertinoRoute(page: StartUpView, initial: true),
    CupertinoRoute(
      page: OnBoardingView,
      path: "/onBoarding",
      children: [
        CupertinoRoute(
          page: View1,
          initial: true,
          fullscreenDialog: true,
        ),
        CupertinoRoute(
          page: View2,
          path: "/2",
          fullscreenDialog: true,
        ),
        CupertinoRoute(
          page: View3,
          fullscreenDialog: false,
          path: "/3",
        ),
      ],
    ),
    StackedRoute(page: LoginView),
    StackedRoute(page: RegisterView),
    StackedRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    Singleton(classType: OnBoardingViewModel),
    // Singleton(classType: FirebaseAuthenticationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}

//Custom Route for Cupertino Modal Bottom Sheet
// class MaterialWithModalsPageRoute<T> extends StackedRoute<T> {
//   /// passed to the title property in [CupertinoPageRoute]
//   final String? title;

//   const MaterialWithModalsPageRoute(
//       {bool? initial,
//       bool? fullscreenDialog,
//       bool? maintainState,
//       String? path,
//       this.title,
//       String? name,
//       required Type page,
//       List<Type>? guards,
//       List<StackedRoute>? children})
//       : super(
//             initial: initial,
//             fullscreenDialog: fullscreenDialog,
//             maintainState: maintainState,
//             path: path,
//             name: name,
//             page: page,
//             guards: guards,
//             children: children);
// }
