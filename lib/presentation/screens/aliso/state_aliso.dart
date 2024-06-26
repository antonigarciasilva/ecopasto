import 'package:flutter/material.dart';

class StateAliso with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenAliso;
  double? dryMatterAliso;
  double? totalBiomass;

  bool get isGreenAlisoCalculated => greenAliso != null;
  bool get isDryMatterAlissoCalculated => dryMatterAliso != null;
  bool get isTotalBiomassCalculated => totalBiomass != null;

  bool get areAllCalculationsCompletedA =>
      isGreenAlisoCalculated &&
      isDryMatterAlissoCalculated &&
      isTotalBiomassCalculated;

  void setGreenAliso(double value) {
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
}
