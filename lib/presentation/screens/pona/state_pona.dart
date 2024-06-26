import 'package:flutter/material.dart';

class StatePona with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenPona;
  double? dryMatterPona;
  double? totalBiomassO;

  bool get isGreenPonaCalculated => greenPona != null;
  bool get isDryMatterPonaCalculated => dryMatterPona != null;
  bool get isTotalBiomassCalculatedO => totalBiomassO != null;

  bool get areAllCalculationsCompletedO =>
      isGreenPonaCalculated &&
      isDryMatterPonaCalculated &&
      isTotalBiomassCalculatedO;

  void setGreenPona(double value) {
    greenPona = value;
    notifyListeners();
  }

  void setDryMatterPona(double value) {
    dryMatterPona = value;
    notifyListeners();
  }

  void setTotalBiomassO(double value) {
    totalBiomassO = value;
    notifyListeners();
  }
}
