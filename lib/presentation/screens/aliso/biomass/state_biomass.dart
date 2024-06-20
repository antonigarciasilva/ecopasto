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
  double _resultdba = 0.0;
  double _resulthba = 0.0;
  double _resultbha = 0.0;

  double get resultdba => _resultdba;
  double get resulthba => _resulthba;
  double get resultbha => _resultbha;

  void setDryBiomass(double value) {
    _resultdba = value;
    dryBiomass = value;
    notifyListeners();
  }

  void setHerbaceousBiomass(double value) {
    _resulthba = value;
    herbaceousBiomass = value;
    notifyListeners();
  }

  void setLeafLitterBiomass(double value) {
    _resultbha = value;
    leafLitterBiomass = value;
    notifyListeners();
  }

  double get totalBiomass {
    return (_resultbha) + (_resultdba) + (_resulthba);
  }

  double get resultCarbonBiomass {
    return totalBiomass * 0.4270;
  }
}
