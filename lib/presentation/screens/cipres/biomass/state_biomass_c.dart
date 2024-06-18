import 'package:flutter/material.dart';

class StateBiomassC with ChangeNotifier {
  double? _resultdbac;
  double? _resulthbac;
  double? _resultbhac;

  double? get resultdbac => _resultdbac;
  double? get resulthbac => _resulthbac;
  double? get resultbhac => _resultbhac;

  void setDryBiomassC(double value) {
    _resultdbac = value;
    notifyListeners();
  }

  void setHerbaceousBiomassC(double value) {
    _resulthbac = value;
    notifyListeners();
  }

  void setLeafLitterBiomassC(double value) {
    _resultbhac = value;
    notifyListeners();
  }

  double get totalBiomassC {
    return (_resultbhac ?? 0) + (_resultdbac ?? 0) + (_resulthbac ?? 0);
  }

  double get resultCarbonBiomassC {
    return totalBiomassC * 0.5000;
  }
}
