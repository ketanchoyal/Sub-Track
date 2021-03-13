import 'package:flutter/material.dart';
	import 'package:stacked/stacked.dart';
	import './register_viewmodel.dart';
    
    class RegisterView extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
			return ViewModelBuilder<RegisterViewModel>.reactive(
			builder: (context, model, child) => Scaffold(),
			viewModelBuilder: () => RegisterViewModel(),
			);
		}
	}