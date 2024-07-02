import 'package:flutter/material.dart';

class StateST with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenS;
  double? dryMatterS;

  bool get isGreenSCalculated => greenS != null;
  bool get isDryMatterSCalculated => dryMatterS != null;

  bool get areAllCalculationsCompletedS =>
      isDryMatterSCalculated && isGreenSCalculated;

  void setGreenS(double value) {
    greenS = value;
    notifyListeners();
  }

  void setDryMatterS(double value) {
    dryMatterS = value;
    notifyListeners();
  }
}
