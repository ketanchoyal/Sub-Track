import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/app/app.router.dart';
import 'package:sub_track/core/services/auth_service.dart';
import 'package:sub_track/core/services/calculation_service.dart';
import 'package:sub_track/ui/services/ui_services.dart';

import 'base_viewmodel.dart';

mixin $SharedVariables on BaseViewModel {
  Ref get ref;

  NavigationService get $navigationService => ref.read(navigationServiceP);
  UIServices get $uiServices => ref.read(uiServicesP);
  FirebaseAuthenticationService get $firebaseAuthenticationService =>
      ref.read(firebaseAuthServiceP);
  CalculationService get $calculationService => ref.read(calculationServiceP);
}
