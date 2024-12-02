import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateBiomassP with ChangeNotifier {
//Para los estados de los botones
  double? dryBiomassP;
  double? herbaceousBiomassP;
  double? leafLitterBiomassP;

  double? greenPino;
  double? dryMatterPino;

  double? pmsP;

  double? latitude;
  double? longitude;

  double? dapP;

  double? psmP;
  double? pfmP;

//Datos suelos
  double? areaP;
  double? depthP;
  String? selectedSoilTypeP;
  double? soilDensityP;
  double? totalSoilCarbonP;

  bool get isPmsP => pmsP != null;
  bool get isAreaP => areaP != null;
  bool get isDepthP => depthP != null;
  bool get isSelectedSoilTypeP => selectedSoilTypeP != null;
  bool get isSoilDensityP => soilDensityP != null;
  bool get isTotalSoilCarbonP => totalSoilCarbonP != null;

  bool get areDateCarbonP =>
      isAreaP && isDepthP && isSelectedSoilTypeP && isSoilDensityP;

  bool get isDapP => dapP != null;
  bool get isPsmP => psmP != null;
  bool get isPfmP => pfmP != null;

  bool get isGreenPinoCalculated => greenPino != null;
  bool get isDryMatterPinoCalculated => dryMatterPino != null;

  bool get isDryBiomassCalculatedP => dryBiomassP != null;
  bool get isHerbaceousBiomassPCalculatedP => herbaceousBiomassP != null;
  bool get isLeafLitterBiomassPCalculatedP => leafLitterBiomassP != null;

  bool get areCalculationsCompletedP =>
      isDryBiomassCalculatedP &&
      (resultHerbaceousBiomassP > 0) &&
      isLeafLitterBiomassPCalculatedP;

  bool get areCalculationsP =>
      isGreenPinoCalculated &&
      isDryMatterPinoCalculated &&
      isDryBiomassCalculatedP;

  bool get areCalculationsCompletedMatter =>
      isDryMatterPinoCalculated && isGreenPinoCalculated;

/*
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

  */
  Future<void> getCurrentLocation() async {
    if (Platform.isAndroid) {
      bool serviceEnabled;
      LocationPermission permission;

      // Verificamos si los servicios de localización están habilitados
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Si no están habilitados, puedes mostrar un mensaje al usuario
        return Future.error('Los servicios de ubicación están deshabilitados');
      }

      // Verifica los permisos de localización
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Los permisos están denegados, muestra un mensaje
          return Future.error(
              'Los permisos de ubicación están deshabilitados.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Los permisos están denegados de forma permanente, no puedes continuar
        return Future.error(
            'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos.');
      }

      // Configuraciones de ubicación
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, // Alta precisión
        distanceFilter: 100, // Notificar cada 100 metros de cambio
      );

      // Obtener la ubicación actual con las configuraciones apropiadas
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      notifyListeners();
    } else {
      // En iOS (o cualquier otra plataforma), puedes omitir esta funcionalidad
    }
  }

  //Setters para suelos
  void setAreaP(double value) {
    areaP = value;
    notifyListeners();
  }

  void setDepthP(double value) {
    depthP = value;
    notifyListeners();
  }

  void setSelectedSoilTypeP(double value, String soilType) {
    selectedSoilTypeP = soilType;
    soilDensityP = value;
    notifyListeners();
  }

  void setTotalSoilCarbonP(double value) {
    totalSoilCarbonP = value;
    notifyListeners();
  }

  //Para la respuesta de biomasa total y carbono
  void setDapP(double value) {
    dapP = value;
    notifyListeners();
  }

  void setPmsP(double value) {
    pmsP = value;
    notifyListeners();
  }

  void setPsmP(double value) {
    psmP = value;
    notifyListeners();
  }

  void setPfmP(double value) {
    pfmP = value;
    notifyListeners();
  }

  void setDryBiomassP(double value) {
    dryBiomassP = value;
    notifyListeners();
  }

  void setHerbaceousBiomassP(double value) {
    herbaceousBiomassP = value;
    notifyListeners();
  }

  void setLeafLitterBiomassP(double value) {
    leafLitterBiomassP = value;
    notifyListeners();
  }

  void setGreenPino(double value) {
    greenPino = value;
    notifyListeners();
  }

  void setDryMatterPino(double value) {
    dryMatterPino = value;
    notifyListeners();
  }

  double get totalBiomassP {
    return (leafLitterBiomassP ?? 0) +
        (dryBiomassP ?? 0) +
        (resultHerbaceousBiomassP);
  }

  double get resultCarbonBiomassP {
    return totalBiomassP * 0.4270;
  }

  double get resultHerbaceousBiomassP {
    return (((dryMatterPino ?? 0) / (greenPino ?? 0)) *
        (greenPino ?? 0) *
        0.01);
  }

  double get resultConversionCarbonP {
    return (resultCarbonBiomassP * 3.666);
  }

  double get sumaTotalP {
    return totalBiomassP + resultCarbonBiomassP + resultConversionCarbonP;
  }

  //Método para guardar en FireStore

  Future<void> saveToFirestore() async {
    final userIdP = FirebaseAuth.instance.currentUser?.uid;

    final data = {
      'userId': userIdP,
      'materiaVerdeC': greenPino,
      'materiaSecaC': dryMatterPino,
      'biomasaSecaC': dryBiomassP,
      'biomasaHojarasca': leafLitterBiomassP,
      'biomasaHerbacea': resultHerbaceousBiomassP,
      'biomasaTotal': totalBiomassP,
      'resultadoCarbonoBiomasa': resultCarbonBiomassP,
      'resultadoConversionCarbonoToCO2': resultConversionCarbonP,
      'totalBiomasa': sumaTotalP,
      //Para registrar el tiempo de calculo
      'fechaHora': FieldValue.serverTimestamp(),
      //Para la ubicación
      'latitud': latitude,
      'longitud': longitude,
      'dap': dapP,
      'pesoSecoHojarasca': psmP,
      'pesoFrescoHojarasca': pfmP,
      //suelos
      'area': areaP,
      'profundidad': depthP,
      'tipodesuelo': selectedSoilTypeP,
      'densidadesuelo': soilDensityP,
      'totalSoilCarbon': totalSoilCarbonP,
    };
    try {
      await FirebaseFirestore.instance
          .collection('dataCalculationPino')
          .add(data);
      // ignore: avoid_print
      print('Datos almacenados correctamente en Firestore');
    } catch (e) {
      // ignore: avoid_print
      print('Error al almacenar data: $e');
    }
  }
}
