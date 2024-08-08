import 'package:flutter/material.dart';

class StateBiomass with ChangeNotifier {
//Para hacer las validaciones de los botones
  double? greenAliso;
  double? dryMatterAliso;

  double? dryBiomass;
  double? herbaceousBiomass;
  double? leafLitterBiomass;

  bool get isGreenSCalculated => greenAliso != null;
  bool get isDryMatterSCalculated => dryMatterAliso != null;

  bool get isDryBiomassCalculated => dryBiomass != null;

  bool get isLeafLitterBiomassCalculated => leafLitterBiomass != null;

  bool get isHerbaceousBiomassCalculated => herbaceousBiomass != null;

  bool get areAllCalculationsCompleted =>
      isDryBiomassCalculated &&
      (resultBiomassHerbaceous > 0) &&
      isLeafLitterBiomassCalculated;

  bool get areAllBaseCalculateCompleted =>
      isGreenSCalculated && isDryMatterSCalculated && isDryBiomassCalculated;

  bool get isConversionCarbon => (resultCarbonBiomass > 0);

  //Para la respuesta de biomasa total y carbono

  void setGreenS(double value) {
    greenAliso = value;
    notifyListeners();
  }

  void setDryMatterAliso(double value) {
    dryMatterAliso = value;
    notifyListeners();
  }

  void setDryBiomass(double value) {
    dryBiomass = value;
    notifyListeners();
  }

  void setHerbaceous(double value) {
    herbaceousBiomass = value;
    notifyListeners();
  }

  void setLeafLitterBiomass(double value) {
    leafLitterBiomass = value;
    notifyListeners();
  }

  double get resultBiomassHerbaceous {
    return (((dryMatterAliso ?? 0) / (greenAliso ?? 0)) * (greenAliso ?? 0)) *
        0.01;
  }

  double get totalBiomass {
    return (dryBiomass ?? 0) +
        (resultBiomassHerbaceous) +
        (leafLitterBiomass ?? 0);
  }

  double get resultCarbonBiomass {
    return totalBiomass * 0.4270;
  }

  double get resultConversionCarbon {
    return resultCarbonBiomass * 3.666;
  }

  double get sumaTotal {
    return totalBiomass + resultCarbonBiomass + resultConversionCarbon;
  }
}
