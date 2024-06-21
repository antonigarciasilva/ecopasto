import 'package:flutter/material.dart';

class StateBiomassP with ChangeNotifier {
//Para los estados de los botones
  double? dryBiomassP;
  double? herbaceousBiomassP;
  double? leafLitterBiomassP;

  bool get isDryBiomassCalculatedP => dryBiomassP != null;
  bool get isHerbaceousBiomassPCalculatedP => herbaceousBiomassP != null;
  bool get isLeafLitterBiomassPCalculatedP => leafLitterBiomassP != null;

  bool get areCalculationsCompleted =>
      isDryBiomassCalculatedP &&
      isHerbaceousBiomassPCalculatedP &&
      isLeafLitterBiomassPCalculatedP;

  //Para calcular la biomasa total
  double _resultdbap = 0.0;
  double _resulthbap = 0.0;
  double _resultbhap = 0.0;

  double get resultdbap => _resultdbap;
  double get resulthbap => _resulthbap;
  double get resultbhap => _resultbhap;

  void setDryBiomassP(double value) {
    _resultdbap = value;
    dryBiomassP = value;
    notifyListeners();
  }

  void setHerbaceousBiomassP(double value) {
    _resulthbap = value;
    herbaceousBiomassP = value;
    notifyListeners();
  }

  void setLeafLitterBiomassP(double value) {
    _resultbhap = value;
    leafLitterBiomassP = value;
    notifyListeners();
  }

  double get totalBiomassP {
    return (_resultbhap) + (_resultdbap) + (_resulthbap);
  }

  double get resultCarbonBiomassP {
    return totalBiomassP * 0.4270;
  }
}
