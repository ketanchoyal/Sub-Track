// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sub_track/ui/shared/auth_viewmodel.dart';
import 'package:sub_track/ui/view/add_sub_details/add_sub_details_viewmodel.dart';

import 'add_sub_details_view.dart';

const String NameValueKey = 'name';
const String CostValueKey = 'cost';
const String DescriptionValueKey = 'description';
const String SharedWithValueKey = 'sharedWith';

mixin $AddSubDetailsView on ConsumerState<AddSubDetailsView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sharedWithController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode costFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode sharedWithFocusNode = FocusNode();
  final FocusNode colorFocusNode = FocusNode();

  initControllers() {
    // ref.read(addSubDetailViewModelCNP).setBusy(true);
    nameController.text = widget.brand.title;
    costController.text = "0.0";
    sharedWithController.text = "0";
    // ref.read(addSubDetailViewModelCNP).setBusy(false);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated() {
    nameController.addListener(() => _updateFormData());
    costController.addListener(() => _updateFormData());
    descriptionController.addListener(() => _updateFormData());
    sharedWithController.addListener(() => _updateFormData());
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData() => (ref.read(addSubDetailViewModelCNP)).setData(
        (ref.read(addSubDetailViewModelCNP)).formValueMap
          ..addAll({
            NameValueKey: nameController.text,
            CostValueKey: costController.text,
            DescriptionValueKey: descriptionController.text,
            SharedWithValueKey: sharedWithController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController.dispose();
    costController.dispose();
    descriptionController.dispose();
    sharedWithController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[NameValueKey];
  String? get costValue => this.formValueMap[CostValueKey];
  String? get descriptionValue => this.formValueMap[DescriptionValueKey];
  String? get sharedWithValue => this.formValueMap[SharedWithValueKey];

  bool get hasName => this.formValueMap.containsKey(NameValueKey);
  bool get hasCost => this.formValueMap.containsKey(CostValueKey);
  bool get hasDescription => this.formValueMap.containsKey(DescriptionValueKey);
  bool get hasSharedWith => this.formValueMap.containsKey(SharedWithValueKey);
}

extension Methods on FormViewModel {}
