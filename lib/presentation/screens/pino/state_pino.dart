import 'package:flutter/material.dart';

class StatePino with ChangeNotifier {
  //Validamos la meteria verde y seca

  double? greenPino;
  double? dryMatterPino;
  double? totalBiomassP;

  bool get isGreenPinoCalculated => greenPino != null;
  bool get isDryMatterPinoCalculated => dryMatterPino != null;
  bool get isTotalBiomassPCalculated => totalBiomassP != null;

  bool get areCalculationsCompletedP =>
      isDryMatterPinoCalculated &&
      isGreenPinoCalculated &&
      isTotalBiomassPCalculated;

  void setGreenPino(double value) {
    greenPino = value;
    notifyListeners();
  }

  void setDryMatterPino(double value) {
    dryMatterPino = value;
    notifyListeners();
  }

  void setTotalBiomassPPino(double value) {
    totalBiomassP = value;
    notifyListeners();
  }
}
