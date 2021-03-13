// ignore: import_of_legacy_library_into_null_safe
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/ui/view/demo/demo_view.dart';
import 'package:sub_track/ui/view/startup/startup_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: DemoView, initial: true),
    CupertinoRoute(page: StartUpView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    // Singleton(classType: FirebaseAuthenticationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
