import 'package:flutter/material.dart';

class StateBiomassO with ChangeNotifier {
  double _resultdbao = 0.0;
  double _resulthbao = 0.0;
  double _resultbhao = 0.0;

  double get resultdbao => _resultdbao;
  double get resulthbao => _resulthbao;
  double get resultbhao => _resultbhao;

  void setDryBiomassO(double value) {
    _resultdbao = value;
    notifyListeners();
  }

  void setHerbaceousBiomassO(double value) {
    _resulthbao = value;
    notifyListeners();
  }

  void setLeafLitterBiomassO(double value) {
    _resultbhao = value;
    notifyListeners();
  }

  double get totalBiomassO {
    return (_resultbhao) + (_resultdbao) + (_resulthbao);
  }

  double get resultCarbonBiomassO {
    return totalBiomassO * 0.5674;
  }
}
