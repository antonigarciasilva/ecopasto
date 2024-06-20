import 'package:flutter/material.dart';

class StateBiomassP with ChangeNotifier {
  double _resultdbap = 0.0;
  double _resulthbap = 0.0;
  double _resultbhap = 0.0;

  double get resultdbap => _resultdbap;
  double get resulthbap => _resulthbap;
  double get resultbhap => _resultbhap;

  void setDryBiomassP(double value) {
    _resultdbap = value;
    notifyListeners();
  }

  void setHerbaceousBiomassP(double value) {
    _resulthbap = value;
    notifyListeners();
  }

  void setLeafLitterBiomassP(double value) {
    _resultbhap = value;
    notifyListeners();
  }

  double get totalBiomassP {
    return (_resultbhap) + (_resultdbap) + (_resulthbap);
  }

  double get resultCarbonBiomassP {
    return totalBiomassP * 0.4270;
  }
}
