import 'package:flutter/material.dart';

class StateBiomassO with ChangeNotifier {
  //Para los estados de los botones
  double? dryBiomassO;
  double? herbaceousBiomassO;
  double? leafLitterBiomassO;

  bool get isDryBiomassCalculatedO => dryBiomassO != null;
  bool get isHerbaceousBiomassCalculatedO => herbaceousBiomassO != null;
  bool get isLeafLitterBiomassCalculatedO => leafLitterBiomassO != null;

  bool get areAllCalculationsCompletedO =>
      isDryBiomassCalculatedO &&
      isHerbaceousBiomassCalculatedO &&
      isLeafLitterBiomassCalculatedO;

  //Para calcular la biomasa total
  double _resultdbao = 0.0;
  double _resulthbao = 0.0;
  double _resultbhao = 0.0;

  double get resultdbao => _resultdbao;
  double get resulthbao => _resulthbao;
  double get resultbhao => _resultbhao;

  void setDryBiomassO(double value) {
    _resultdbao = value;
    dryBiomassO = value;
    notifyListeners();
  }

  void setHerbaceousBiomassO(double value) {
    _resulthbao = value;
    herbaceousBiomassO = value;
    notifyListeners();
  }

  void setLeafLitterBiomassO(double value) {
    _resultbhao = value;
    leafLitterBiomassO = value;
    notifyListeners();
  }

  double get totalBiomassO {
    return (_resultbhao) + (_resultdbao) + (_resulthbao);
  }

  double get resultCarbonBiomassO {
    return totalBiomassO * 0.5674;
  }
}
