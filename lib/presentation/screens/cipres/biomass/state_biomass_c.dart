import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateBiomassC with ChangeNotifier {
  //Para hacer las validaciones de los botones

  double? greenCipres;
  double? dryMatterCipres;
  double? pmsC;

  double? dryBiomassC;
  double? herbaceousBiomassC;
  double? leafLitterBiomassC;

  double? latitude;
  double? longitude;

  double? dapC;

  double? psmC;
  double? pfmC;

//Datos suelos
  double? areaC;
  double? depthC;
  String? selectedSoilTypeC;
  double? soilDensity;
  double? totalSoilCarbonC;

  bool get isAreaC => areaC != null;
  bool get isDepthC => depthC != null;
  bool get isSelectedSoilTypeC => selectedSoilTypeC != null;
  bool get isSoilDensity => soilDensity != null;
  bool get isTotalSoilCarbonC => totalSoilCarbonC != null;

  bool get areDateCarbonC =>
      isAreaC && isDepthC && isSelectedSoilTypeC && isSoilDensity;

  bool get isDapC => dapC != null;
  bool get isPsmC => psmC != null;
  bool get isPfmC => pfmC != null;

  bool get isGreenCipresCalculated => greenCipres != null;
  bool get isDryMatterCipresCalculated => dryMatterCipres != null;
  bool get isPmsC => pmsC != null;

  bool get isDryBiomassCalculatedC => dryBiomassC != null;
  bool get isherbaceousCalculatedC => herbaceousBiomassC != null;
  bool get isleafLitterBiomassCCalculatedC => leafLitterBiomassC != null;

  bool get areAllCalculationsCompletedC =>
      isDryBiomassCalculatedC &&
      (resultHerbaceousBiomassC > 0) &&
      isleafLitterBiomassCCalculatedC;

  bool get areBaseCalculatedC =>
      isGreenCipresCalculated &&
      isDryMatterCipresCalculated &&
      isDryBiomassCalculatedC;

  bool get areAllCalculationsCompletedA =>
      isGreenCipresCalculated && isDryMatterCipresCalculated;

  bool get isConversionCarbonC => (resultCarbonBiomassC > 0);

  //Método para la ubicación
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //Verificamos la habilitación de los servicios
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //si no está habilitado se mostrará un mensaje
      return Future.error('Los servicios de ubicación están deshabilitados');
    }

    //Verificamos los permisos de localización
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //sí la ubicación está denegada entonces se va a mostrar
        return Future.error('Los permisos de ubicación está deshabilitado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //Los permisos están denegados , no puedes continuar
      return Future.error(
          'Los permisos de ubicación están denegeados permanentemente, no podemos solicitar permisos');
    }

    // Ubicación para android, IOS y web
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    //Obtenemos la ubicación actual con configuraciones
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    notifyListeners();
  }

  //Setters para suelos
  void setAreaC(double value) {
    areaC = value;
    notifyListeners();
  }

  void setDepthC(double value) {
    depthC = value;
    notifyListeners();
  }

  void setSelectedSoilTypeC(double value, String soilType) {
    selectedSoilTypeC = soilType;
    soilDensity = value;
    notifyListeners();
  }

  void setTotalSoilCarbonC(double value) {
    totalSoilCarbonC = value;
    notifyListeners();
  }

  //Para la respuesta de biomasa total y carbono
  void setDapC(double value) {
    dapC = value;
    notifyListeners();
  }

  void setPsmC(double value) {
    psmC = value;
    notifyListeners();
  }

  void setPfmC(double value) {
    pfmC = value;
    notifyListeners();
  }

  void setPmsC(double value) {
    pmsC = value;
    notifyListeners();
  }

  void setDryBiomassC(double value) {
    dryBiomassC = value;
    notifyListeners();
  }

  void setHerbaceousBiomassC(double value) {
    herbaceousBiomassC = value;
    notifyListeners();
  }

  void setLeafLitterBiomassC(double value) {
    leafLitterBiomassC = value;
    notifyListeners();
  }

  void setGreenCipres(double value) {
    greenCipres = value;
    notifyListeners();
  }

  void setDryMatterCipres(double value) {
    dryMatterCipres = value;
    notifyListeners();
  }

  double get totalBiomassC {
    return (dryBiomassC ?? 0) +
        (leafLitterBiomassC ?? 0) +
        (resultHerbaceousBiomassC);
  }

  double get resultCarbonBiomassC {
    return totalBiomassC * 0.5000;
  }

  double get resultHerbaceousBiomassC {
    return (((dryMatterCipres ?? 0) / (greenCipres ?? 0)) *
        (greenCipres ?? 0) *
        0.01);
  }

  double get resultConversionCarbonC {
    return resultCarbonBiomassC * 3.666;
  }

  double get sumaTotalC {
    return totalBiomassC + resultCarbonBiomassC + resultConversionCarbonC;
  }

  //Método para guardar en FireStore

  Future<void> saveToFirestore() async {
    final userIdC = FirebaseAuth.instance.currentUser?.uid;

    final data = {
      'userId': userIdC,
      'materiaVerdeC': greenCipres,
      'materiaSecaC': dryMatterCipres,
      'biomasaSecaC': dryBiomassC,
      'biomasaHojarasca': leafLitterBiomassC,
      'biomasaHerbacea': resultHerbaceousBiomassC,
      'biomasaTotal': totalBiomassC,
      'resultadoCarbonoBiomasa': resultCarbonBiomassC,
      'resultadoConversionCarbonoToCO2': resultConversionCarbonC,
      'totalBiomasa': sumaTotalC,
      //Para registrar el tiempo de calculo
      'fechaHora': FieldValue.serverTimestamp(),
      //Para la ubicación
      'latitud': latitude,
      'longitud': longitude,
      'dap': dapC,
      'pesoSecoHojarasca': psmC,
      'pesoFrescoHojarasca': pfmC,
      //suelos
      'area': areaC,
      'profundidad': depthC,
      'tipodesuelo': selectedSoilTypeC,
      'densidadesuelo': soilDensity,
      'totalSoilCarbon': totalSoilCarbonC,
    };
    try {
      await FirebaseFirestore.instance
          .collection('dataCalculationCipres')
          .add(data);
      // ignore: avoid_print
      print('Datos almacenados correctamente en Firestore');
    } catch (e) {
      // ignore: avoid_print
      print('Error al almacenar data: $e');
    }
  }
}
