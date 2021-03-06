// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked_annotations.dart';
import 'package:sub_track/ui/view/active_subscription/active_subscription_view.dart';
import 'package:sub_track/ui/view/add_sub/add_sub_view.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_view.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/forgot_password/forgot_password_view.dart';
import 'package:sub_track/ui/view/home/home_view.dart';
import 'package:sub_track/ui/view/login/login_view.dart';
import 'package:sub_track/ui/view/new_subscription/new_subscription_view.dart';
import 'package:sub_track/ui/view/on_boarding/on_boarding_view.dart';
import 'package:sub_track/ui/view/other_select/other_select_view.dart';
import 'package:sub_track/ui/view/register/register_view.dart';
import 'package:sub_track/ui/view/select_category/select_category_view.dart';
import 'package:sub_track/ui/view/select_icon/select_icon_view.dart';
import 'package:sub_track/ui/view/setting/setting_view.dart';
import 'package:sub_track/ui/view/startup/startup_view.dart';

@StackedApp(
  logger: StackedLogger(),
  routes: [
    CupertinoRoute(page: DemoView),
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
    CupertinoRoute(
      page: NewSubscription,
      children: [
        CupertinoRoute(page: AddSubView, initial: true),
        CupertinoRoute(page: AddSubDetailsView),
        CupertinoRoute(page: SelectIconView),
        CupertinoRoute(page: SelectCategoryView),
        CupertinoRoute(page: OtherSelectView),
      ],
    ),
    CupertinoRoute(page: StartUpView, initial: true),
    StackedRoute(page: LoginView),
    StackedRoute(page: RegisterView),
    StackedRoute(page: HomeView),
    StackedRoute(page: ForgotPasswordView),
    AdaptiveRoute(
      page: ActiveSubscriptionView,
      fullscreenDialog: true,
      maintainState: true,
    ),
    AdaptiveRoute(
      page: SettingView,
      maintainState: true,
    ),
  ],
  // no asType function in null safety version
  // dependencies: [
  //   LazySingleton(classType: NavigationService),
  //   LazySingleton(classType: DialogService),
  //   LazySingleton(
  //     classType: BrandServiceStub,
  //     // asType: BrandService,
  //   ),
  //   LazySingleton(
  //     classType: UIServices,
  //   ),
  //   Singleton(classType: OnBoardingViewModel),
  //   // Singleton(classType: FirebaseAuthenticationService),
  // ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
