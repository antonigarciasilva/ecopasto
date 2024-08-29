import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateBiomass with ChangeNotifier {
//Para hacer las validaciones de los botones
  double? greenAliso;
  double? dryMatterAliso;

  double? dryBiomass;
  double? herbaceousBiomass;
  double? leafLitterBiomass;

  double? latitude;
  double? longitude;

  double? dap;

  double? psm;
  double? pfm;

  bool get isDapa => dap != null;
  bool get isPsm => psm != null;
  bool get isPfm => pfm != null;

  bool get isGreenSCalculated => greenAliso != null;
  bool get isDryMatterSCalculated => dryMatterAliso != null;

  bool get isDryBiomassCalculated => dryBiomass != null;

  bool get isLeafLitterBiomassCalculated => leafLitterBiomass != null;

  bool get isHerbaceousBiomassCalculated => herbaceousBiomass != null;

  bool get areAllCalculationsCompleted =>
      isDryBiomassCalculated &&
      (resultBiomassHerbaceous > 0) &&
      isLeafLitterBiomassCalculated;

  bool get areAllBaseCalculateCompleted =>
      isGreenSCalculated && isDryMatterSCalculated && isDryBiomassCalculated;

  bool get isConversionCarbon => (resultCarbonBiomass > 0);

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

  //Para la respuesta de biomasa total y carbono

  void setDap(double value) {
    dap = value;
    notifyListeners();
  }

  void setPsm(double value) {
    psm = value;
    notifyListeners();
  }

  void setPfm(double value) {
    pfm = value;
    notifyListeners();
  }

  void setGreenS(double value) {
    greenAliso = value;
    notifyListeners();
  }

  void setDryMatterAliso(double value) {
    dryMatterAliso = value;
    notifyListeners();
  }

  void setDryBiomass(double value) {
    dryBiomass = value;
    notifyListeners();
  }

  void setHerbaceous(double value) {
    herbaceousBiomass = value;
    notifyListeners();
  }

  void setLeafLitterBiomass(double value) {
    leafLitterBiomass = value;
    notifyListeners();
  }

  double get resultBiomassHerbaceous {
    return (((dryMatterAliso ?? 0) / (greenAliso ?? 0)) * (greenAliso ?? 0)) *
        0.01;
  }

  double get totalBiomass {
    return (dryBiomass ?? 0) +
        (resultBiomassHerbaceous) +
        (leafLitterBiomass ?? 0);
  }

  double get resultCarbonBiomass {
    return totalBiomass * 0.4270;
  }

  double get resultConversionCarbon {
    return resultCarbonBiomass * 3.666;
  }

  double get sumaTotal {
    return totalBiomass + resultCarbonBiomass + resultConversionCarbon;
  }

//Metodo para guardar en firestore
  Future<void> saveToFirestore() async {
    final data = {
      'greenAliso': greenAliso,
      'dryMatterAliso': dryMatterAliso,
      'dryBiomass': dryBiomass,

      'leafLitterBiomass': leafLitterBiomass,
      'resultBiomassHerbaceous': resultBiomassHerbaceous,
      'totalBiomass': totalBiomass,
      'resultCarbonBiomass': resultCarbonBiomass,
      'resultConversionCarbon': resultConversionCarbon,
      'sumaTotal': sumaTotal,
      // Para registrar el tiempo de almacenamiento
      'timestamp': FieldValue.serverTimestamp(),
      // Para asegurar la ubicación
      'latitude': latitude,
      'longitude': longitude,
      'dap': dap,
      'pesoSecoHojarasca': psm,
      'pesoFrescoHojarasca': pfm,
    };
    try {
      await FirebaseFirestore.instance
          .collection('biomassCalculationsAliso')
          .add(data);
      // ignore: avoid_print
      print("Datos almacenados correctamente en Firestore");
    } catch (e) {
      // ignore: avoid_print
      print("Error al almacenar data: $e");
    }
  }
}
