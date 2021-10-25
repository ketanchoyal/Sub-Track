// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/view/forgot_password/forgot_password_viewmodel.dart';

import 'forgot_password_view.dart';

const String EmailValueKey = 'email';

mixin $ForgotPasswordView on ConsumerState<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated() {
    emailController.addListener(() => _updateFormData());
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData() => ref.read(forgotPasswordViewModelCNP).setData(
        ref.read(forgotPasswordViewModelCNP).formValueMap
          ..addAll({
            EmailValueKey: emailController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    emailController.dispose();
    emailFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get emailValue => this.formValueMap[EmailValueKey];

  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
}

extension Methods on FormViewModel {}
