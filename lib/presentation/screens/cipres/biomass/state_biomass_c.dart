import 'package:flutter/material.dart';

class StateBiomassC with ChangeNotifier {
  double _resultdbac = 0.0;
  double _resulthbac = 0.0;
  double _resultbhac = 0.0;

  double get resultdbac => _resultdbac;
  double get resulthbac => _resulthbac;
  double get resultbhac => _resultbhac;

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
    return (_resultbhac) + (_resultdbac) + (_resulthbac);
  }

  double get resultCarbonBiomassC {
    return totalBiomassC * 0.5000;
  }
}
