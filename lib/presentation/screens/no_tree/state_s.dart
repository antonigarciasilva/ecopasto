import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateST with ChangeNotifier {
  //Para validar la materia verde y seca
  double? greenS;
  double? dryMatterS;

  double? latitude;
  double? longitude;

  double? pms;

  bool get isGreenSCalculated => greenS != null;
  bool get isDryMatterSCalculated => dryMatterS != null;

  bool get isDryMatterS => pms != null;

  bool get areAllCalculationsCompletedS =>
      isDryMatterSCalculated && isGreenSCalculated;

  //Método para obtener la ubicación actual
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //Verificamos si los servicios de localización están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Si no están habilitados, puede que quieras mostrar un mensaje al usuario
      return Future.error('Los servicios de ubicación están deshabilitados');
    }

    //Verifica los permisos de localización

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //Los permisos están denegados, puede que quieras mostrar un mensaje
        return Future.error('Los permisos de ubicación están deshabilitados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //Los permisos están denegados de forma permanente, no puedes continuar
      return Future.error(
          'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos.');
    }

    //Obten la ubicación actual, para android, ios y web
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //alta precisión
      distanceFilter: 100, //Notificar cada 100 metros de cambio
    );

    //Obtener la ubicación actual con las configuracioones apropiadas
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    notifyListeners();
  }

  void setGreenS(double value) {
    greenS = value;
    notifyListeners();
  }

  void setDryMatterS(double value) {
    dryMatterS = value;
    notifyListeners();
  }

  void setPmsS(double value) {
    pms = value;
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

  //Metodo para guardar en firestore
  Future<void> saveToFirestore() async {
    //obtener el UID del usuario autenticado
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final data = {
      'userId': userId,
      'greenST': greenS,
      'dryMatter': pms,
      'dryMatterST': dryMatterS,

      'resultBiomassHerbaceous': resultHerbaceousBiomassST,

      'resultCarbonBiomass': resultCarbonBiomassST,
      'resultConversionCarbon': resultConversionCarbonST,
      'sumaTotal': sumaTotalST,
      // Para registrar el tiempo de almacenamiento
      'timestamp': FieldValue.serverTimestamp(),
      // Para asegurar la ubicación
      'latitude': latitude,
      'longitude': longitude,
    };
    try {
      await FirebaseFirestore.instance
          .collection('dataCalculationsSinArbol')
          .add(data);
      // ignore: avoid_print
      print("Datos almacenados correctamente en Firestore");
    } catch (e) {
      // ignore: avoid_print
      print("Error al almacenar data: $e");
    }
  }
}
