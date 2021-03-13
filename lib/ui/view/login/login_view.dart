import 'package:flutter/material.dart';
	import 'package:stacked/stacked.dart';
	import './login_viewmodel.dart';
    
    class LoginView extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
			return ViewModelBuilder<LoginViewModel>.reactive(
			builder: (context, model, child) => Scaffold(),
			viewModelBuilder: () => LoginViewModel(),
			);
		}
	}