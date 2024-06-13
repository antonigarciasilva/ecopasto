import 'package:flutter/material.dart';

class StateBiomass with ChangeNotifier {
  double _resultdba = 0.0;
  double _resulthba = 0.0;
  double _resultbha = 0.0;

  double get resultdba => _resultdba;
  double get resulthba => _resulthba;
  double get resultbha => _resultbha;

  void setDryBiomass(double value) {
    _resultdba = value;
    notifyListeners();
  }

  void setHerbaceousBiomass(double value) {
    _resulthba = value;
    notifyListeners();
  }

  void setLeafLitterBiomass(double value) {
    _resultbha = value;
    notifyListeners();
  }

  double get totalBiomass {
    return (_resultbha) + (_resultdba) + (_resulthba);
  }
}
