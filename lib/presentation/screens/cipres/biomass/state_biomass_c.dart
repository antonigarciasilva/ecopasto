import 'package:flutter/material.dart';

class StateBiomassC with ChangeNotifier {
  //Para hacer las validaciones de los botones

  double? dryBiomassC;
  double? herbaceousBiomassC;
  double? leafLitterBiomassC;

  bool get isDryBiomassCalculatedC => dryBiomassC != null;
  bool get isherbaceousCalculatedC => herbaceousBiomassC != null;
  bool get isleafLitterBiomassCCalculatedC => leafLitterBiomassC != null;

  bool get areAllCalculationsCompleted =>
      isDryBiomassCalculatedC &&
      isherbaceousCalculatedC &&
      isleafLitterBiomassCCalculatedC;

//Para la respuesta de biomasa y carbono
  double? _resultdbac;
  double? _resulthbac;
  double? _resultbhac;

  double? get resultdbac => _resultdbac;
  double? get resulthbac => _resulthbac;
  double? get resultbhac => _resultbhac;

  void setDryBiomassC(double value) {
    _resultdbac = value;
    dryBiomassC = value;
    notifyListeners();
  }

  void setHerbaceousBiomassC(double value) {
    _resulthbac = value;
    herbaceousBiomassC = value;
    notifyListeners();
  }

  void setLeafLitterBiomassC(double value) {
    _resultbhac = value;
    leafLitterBiomassC = value;
    notifyListeners();
  }

  double get totalBiomassC {
    return (_resultbhac ?? 0) + (_resultdbac ?? 0) + (_resulthbac ?? 0);
  }

  double get resultCarbonBiomassC {
    return totalBiomassC * 0.5000;
  }
}
