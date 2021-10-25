// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/view/register/register_view.dart';
import 'package:sub_track/ui/view/register/register_viewmodel.dart';

const String NameValueKey = 'name';
const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';

mixin $RegisterView on ConsumerState<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated() {
    nameController.addListener(() => _updateFormData());
    emailController.addListener(() => _updateFormData());
    passwordController.addListener(() => _updateFormData());
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData() => ref.read(registerViewModelCNP).setData(
        ref.read(registerViewModelCNP).formValueMap
          ..addAll({
            NameValueKey: nameController.text,
            EmailValueKey: emailController.text,
            PasswordValueKey: passwordController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController.dispose();
    nameFocusNode.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[NameValueKey];
  String? get emailValue => this.formValueMap[EmailValueKey];
  String? get passwordValue => this.formValueMap[PasswordValueKey];

  bool get hasName => this.formValueMap.containsKey(NameValueKey);
  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
  bool get hasPassword => this.formValueMap.containsKey(PasswordValueKey);
}

extension Methods on FormViewModel {}
