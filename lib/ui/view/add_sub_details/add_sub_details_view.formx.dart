// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sub_track/core/models/brand/brand.dart';

const String NameValueKey = 'name';
const String CostValueKey = 'cost';
const String DescriptionValueKey = 'description';
const String SharedWithValueKey = 'sharedWith';

mixin $AddSubDetailsView on StatelessWidget {
  TextEditingController? nameController;
  TextEditingController? costController;
  TextEditingController? descriptionController;
  TextEditingController? sharedWithController;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode costFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode sharedWithFocusNode = FocusNode();
  final FocusNode colorFocusNode = FocusNode();

  initControllers(FormViewModel model, Brand brand) {
    model.setBusy(true);
    nameController = TextEditingController(text: brand.title);
    costController = TextEditingController(text: "0.0");
    descriptionController = TextEditingController();
    sharedWithController = TextEditingController(text: "0");
    model.setBusy(false);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    nameController!.addListener(() => _updateFormData(model));
    costController!.addListener(() => _updateFormData(model));
    descriptionController!.addListener(() => _updateFormData(model));
    sharedWithController!.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            NameValueKey: nameController!.text,
            CostValueKey: costController!.text,
            DescriptionValueKey: descriptionController!.text,
            SharedWithValueKey: sharedWithController!.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController!.dispose();
    costController!.dispose();
    descriptionController!.dispose();
    sharedWithController!.dispose();
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
