import 'package:flutter/material.dart';

class StateBiomassP with ChangeNotifier {
//Para los estados de los botones
  double? dryBiomassP;
  double? herbaceousBiomassP;
  double? leafLitterBiomassP;

  double? greenPino;
  double? dryMatterPino;

  bool get isGreenPinoCalculated => greenPino != null;
  bool get isDryMatterPinoCalculated => dryMatterPino != null;

  bool get isDryBiomassCalculatedP => dryBiomassP != null;
  bool get isHerbaceousBiomassPCalculatedP => herbaceousBiomassP != null;
  bool get isLeafLitterBiomassPCalculatedP => leafLitterBiomassP != null;

  bool get areCalculationsCompletedP =>
      isDryBiomassCalculatedP &&
      (resultHerbaceousBiomassP > 0) &&
      isLeafLitterBiomassPCalculatedP;

  bool get areCalculationsCompletedMatter =>
      isDryMatterPinoCalculated && isGreenPinoCalculated;

  void setDryBiomassP(double value) {
    dryBiomassP = value;
    notifyListeners();
  }

  void setHerbaceousBiomassP(double value) {
    herbaceousBiomassP = value;
    notifyListeners();
  }

  void setLeafLitterBiomassP(double value) {
    leafLitterBiomassP = value;
    notifyListeners();
  }

  void setGreenPino(double value) {
    greenPino = value;
    notifyListeners();
  }

  void setDryMatterPino(double value) {
    dryMatterPino = value;
    notifyListeners();
  }

  double get totalBiomassP {
    return (leafLitterBiomassP ?? 0) +
        (dryBiomassP ?? 0) +
        (resultHerbaceousBiomassP);
  }

  double get resultCarbonBiomassP {
    return totalBiomassP * 0.4270;
  }

  double get resultHerbaceousBiomassP {
    return (((dryMatterPino ?? 0) / (greenPino ?? 0)) *
        (greenPino ?? 0) *
        0.01);
  }

  double get resultConversionCarbonP {
    return (resultCarbonBiomassP * 3.666);
  }

  double get sumaTotalP {
    return totalBiomassP + resultCarbonBiomassP + resultConversionCarbonP;
  }
}
