import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateBiomassO with ChangeNotifier {
  //Para los estados de los botones
  double? dryBiomassO;
  double? herbaceousBiomassO;
  double? leafLitterBiomassO;

  double? greenPona;
  double? dryMatterPona;

  double? latitude;
  double? longitude;

  double? dapO;
  double? afO;

  double? psmO;
  double? pfmO;

  bool get isDapO => dapO != null;
  bool get isAfO => afO != null;
  bool get isPsmO => psmO != null;
  bool get isPfmO => pfmO != null;

  bool get isGreenPonaCalculated => greenPona != null;
  bool get isDryMatterPonaCalculated => dryMatterPona != null;

  bool get isDryBiomassCalculatedO => dryBiomassO != null;
  bool get isHerbaceousBiomassCalculatedO => herbaceousBiomassO != null;
  bool get isLeafLitterBiomassCalculatedO => leafLitterBiomassO != null;

  bool get areAllCalculationsCompletedO =>
      isDryBiomassCalculatedO &&
      (resultHerbaceousBiomassO > 0) &&
      isLeafLitterBiomassCalculatedO;

  bool get areCalculatedCarbonoO =>
      isGreenPonaCalculated &&
      isDryMatterPonaCalculated &&
      isDryBiomassCalculatedO;

  bool get areAllCalculationsCompletedMatterO =>
      isGreenPonaCalculated && isDryMatterPonaCalculated;

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

  //Para la respuesta de biomasa total y carbono
  void setDapO(double value) {
    dapO = value;
    notifyListeners();
  }

  void setAfO(double value) {
    afO = value;
    notifyListeners();
  }

  void setPsmO(double value) {
    psmO = value;
    notifyListeners();
  }

  void setPfmO(double value) {
    pfmO = value;
    notifyListeners();
  }

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

  double get sumaTotalO {
    return totalBiomassO + resultCarbonBiomassO + resultConversionCarbonO;
  }

  //Método para guardar en FireStore

  Future<void> saveToFirestore() async {
    final userIdC = FirebaseAuth.instance.currentUser?.uid;

    final data = {
      'userId': userIdC,
      'materiaVerdeC': greenPona,
      'materiaSecaC': dryMatterPona,
      'biomasaSecaC': dryBiomassO,
      'biomasaHojarasca': leafLitterBiomassO,
      'biomasaHerbacea': resultHerbaceousBiomassO,
      'biomasaTotal': totalBiomassO,
      'resultadoCarbonoBiomasa': resultCarbonBiomassO,
      'resultadoConversionCarbonoToCO2': resultConversionCarbonO,
      'totalBiomasa': sumaTotalO,
      //Para registrar el tiempo de calculo
      'fechaHora': FieldValue.serverTimestamp(),
      //Para la ubicación
      'latitud': latitude,
      'longitud': longitude,
      'dap': dapO,
      'alturaFuste': afO,
      'pesoSecoHojarasca': psmO,
      'pesoFrescoHojarasca': pfmO
    };
    try {
      await FirebaseFirestore.instance
          .collection('dataCalculationPona')
          .add(data);
      // ignore: avoid_print
      print('Datos almacenados correctamente en Firestore');
    } catch (e) {
      // ignore: avoid_print
      print('Error al almacenar data: $e');
    }
  }
}
