import 'package:flutter/material.dart';

class StateST with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenS;
  double? dryMatterS;

  bool get isGreenSCalculated => greenS != null;
  bool get isDryMatterSCalculated => dryMatterS != null;

  bool get areAllCalculationsCompletedS =>
      isDryMatterSCalculated && isGreenSCalculated;

  void setGreenS(double value) {
    greenS = value;
    notifyListeners();
  }

  void setDryMatterS(double value) {
    dryMatterS = value;
    notifyListeners();
  }

  double get resultHerbaceousBiomassST {
    return (((dryMatterS ?? 0) / (greenS ?? 0)) * (greenS ?? 0) * 0.01);
  }

  double get resultCarbonBiomassST {
    return resultHerbaceousBiomassST * 0.4270;
  }

  double get resultConversionCarbonST {
    return resultCarbonBiomassST * 3.666;
  }

  double get sumaTotalST {
    return resultHerbaceousBiomassST +
        resultCarbonBiomassST +
        resultConversionCarbonST;
  }
}
