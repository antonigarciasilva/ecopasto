import 'package:flutter/material.dart';

class StateBiomass with ChangeNotifier {
//Para hacer las validaciones de los botones
  double? dryBiomass;
  double? herbaceousBiomass;
  double? leafLitterBiomass;

  bool get isDryBiomassCalculated => dryBiomass != null;
  bool get isHerbaceousBiomassCalculated => herbaceousBiomass != null;
  bool get isLeafLitterBiomassCalculated => leafLitterBiomass != null;

  bool get areAllCalculationsCompleted =>
      isDryBiomassCalculated &&
      isHerbaceousBiomassCalculated &&
      isLeafLitterBiomassCalculated;

  //Para la respuesta de biomasa total y carbono

  void setDryBiomass(double value) {
    dryBiomass = value;
    notifyListeners();
  }

  void setHerbaceousBiomass(double value) {
    herbaceousBiomass = value;
    notifyListeners();
  }

  void setLeafLitterBiomass(double value) {
    leafLitterBiomass = value;
    notifyListeners();
  }

  double get totalBiomass {
    return (dryBiomass ?? 0) +
        (herbaceousBiomass ?? 0) +
        (leafLitterBiomass ?? 0);
  }

  double get resultCarbonBiomass {
    return totalBiomass * 0.4270;
  }
}
