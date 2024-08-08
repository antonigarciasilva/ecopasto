import 'package:flutter/material.dart';

class StateBiomassC with ChangeNotifier {
  //Para hacer las validaciones de los botones

  double? greenCipres;
  double? dryMatterCipres;

  double? dryBiomassC;
  double? herbaceousBiomassC;
  double? leafLitterBiomassC;

  bool get isGreenCipresCalculated => greenCipres != null;
  bool get isDryMatterCipresCalculated => dryMatterCipres != null;

  bool get isDryBiomassCalculatedC => dryBiomassC != null;
  bool get isherbaceousCalculatedC => herbaceousBiomassC != null;
  bool get isleafLitterBiomassCCalculatedC => leafLitterBiomassC != null;

  bool get areAllCalculationsCompletedC =>
      isDryBiomassCalculatedC &&
      (resultHerbaceousBiomassC > 0) &&
      isleafLitterBiomassCCalculatedC;

  bool get areBaseCalculatedC =>
      isGreenCipresCalculated &&
      isDryMatterCipresCalculated &&
      isDryBiomassCalculatedC;

  bool get areAllCalculationsCompletedA =>
      isGreenCipresCalculated && isDryMatterCipresCalculated;

  void setDryBiomassC(double value) {
    dryBiomassC = value;
    notifyListeners();
  }

  void setHerbaceousBiomassC(double value) {
    herbaceousBiomassC = value;
    notifyListeners();
  }

  void setLeafLitterBiomassC(double value) {
    leafLitterBiomassC = value;
    notifyListeners();
  }

  void setGreenCipres(double value) {
    greenCipres = value;
    notifyListeners();
  }

  void setDryMatterCipres(double value) {
    dryMatterCipres = value;
    notifyListeners();
  }

  double get totalBiomassC {
    return (dryBiomassC ?? 0) +
        (leafLitterBiomassC ?? 0) +
        (resultHerbaceousBiomassC);
  }

  double get resultCarbonBiomassC {
    return totalBiomassC * 0.5000;
  }

  double get resultHerbaceousBiomassC {
    return (((dryMatterCipres ?? 0) / (greenCipres ?? 0)) *
        (greenCipres ?? 0) *
        0.01);
  }

  double get resultConversionCarbonC {
    return resultCarbonBiomassC * 3.666;
  }

  double get sumaTotalC {
    return totalBiomassC + resultCarbonBiomassC + resultConversionCarbonC;
  }
}
