import 'package:flutter/material.dart';

class StateBiomassO with ChangeNotifier {
  //Para los estados de los botones
  double? dryBiomassO;
  double? herbaceousBiomassO;
  double? leafLitterBiomassO;

  double? greenPona;
  double? dryMatterPona;

  bool get isGreenPonaCalculated => greenPona != null;
  bool get isDryMatterPonaCalculated => dryMatterPona != null;

  bool get isDryBiomassCalculatedO => dryBiomassO != null;
  bool get isHerbaceousBiomassCalculatedO => herbaceousBiomassO != null;
  bool get isLeafLitterBiomassCalculatedO => leafLitterBiomassO != null;

  bool get areAllCalculationsCompletedO =>
      isDryBiomassCalculatedO &&
      (resultHerbaceousBiomassO > 0) &&
      isLeafLitterBiomassCalculatedO;

  bool get areAllCalculationsCompletedMatterO =>
      isGreenPonaCalculated && isDryMatterPonaCalculated;

  void setDryBiomassO(double value) {
    dryBiomassO = value;
    notifyListeners();
  }

  void setHerbaceousBiomassO(double value) {
    herbaceousBiomassO = value;
    notifyListeners();
  }

  void setLeafLitterBiomassO(double value) {
    leafLitterBiomassO = value;
    notifyListeners();
  }

  void setGreenPona(double value) {
    greenPona = value;
    notifyListeners();
  }

  void setDryMatterPona(double value) {
    dryMatterPona = value;
    notifyListeners();
  }

  double get totalBiomassO {
    return (leafLitterBiomassO ?? 0) +
        (dryBiomassO ?? 0) +
        (resultHerbaceousBiomassO);
  }

  double get resultCarbonBiomassO {
    return totalBiomassO * 0.5674;
  }

  double get resultHerbaceousBiomassO {
    return (((dryMatterPona ?? 0) / (greenPona ?? 0)) *
        (greenPona ?? 0) *
        0.01);
  }

  double get resultConversionCarbonO {
    return resultCarbonBiomassO * 3.666;
  }
}
