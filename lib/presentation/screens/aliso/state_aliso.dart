/*import 'package:flutter/material.dart';

class StateS with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenAliso;
  double? dryMatterAliso;
  double? totalBiomass;

  bool get isGreenSCalculated => greenAliso != null;
  bool get isDryMatterSCalculated => dryMatterAliso != null;

  bool get areAllCalculationsCompletedA =>
      isGreenSCalculated && isDryMatterSCalculated;

  void setGreenS(double value) {
    greenAliso = value;
    notifyListeners();
  }

  void setDryMatterAliso(double value) {
    dryMatterAliso = value;
    notifyListeners();
  }

  void setTotalBiomas(double value) {
    totalBiomass = value;
    notifyListeners();
  }

  double get resultBiomassHerbaceous {
    return ((dryMatterAliso ?? 0) / (greenAliso ?? 0) * (greenAliso ?? 0)) *
        0.01;
  }
}
*/