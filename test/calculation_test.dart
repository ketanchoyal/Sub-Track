import 'package:sub_track/app/app.locatorx.dart';
import 'package:sub_track/core/services/calculation_service.dart';

void main() {
  setupLocator();
  CalculationService _calculationService = locator<CalculationService>();
}
