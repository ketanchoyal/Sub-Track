import 'package:flutter/material.dart';
	import 'package:stacked/stacked.dart';
	import './other_select_view_viewmodel.dart';
    
    class OtherSelectViewView extends StatelessWidget {
		@override
		Widget build(BuildContext context) {
			return ViewModelBuilder<OtherSelectViewViewModel>.reactive(
			builder: (context, model, child) => Scaffold(),
			viewModelBuilder: () => OtherSelectViewViewModel(),
			);
		}
	}