import 'package:flutter/material.dart';
	import 'package:stacked/stacked.dart';
	import './on_boarding_1_viewmodel.dart';
    
    class OnBoarding_1View extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
			return ViewModelBuilder<OnBoarding_1ViewModel>.reactive(
			builder: (context, model, child) => Scaffold(),
			viewModelBuilder: () => OnBoarding_1ViewModel(),
			);
		}
	}