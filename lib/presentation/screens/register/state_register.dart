import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateRegister with ChangeNotifier {
  String? nameUsuario;
  String? lastNameUsuario;
  String? phoneNumberR;
  String? emailControllerR;
  String? passwordControllerR;
  String? genero;

  double? latitude;
  double? longitude;

  bool get isNameUsuario => nameUsuario != null;
  bool get isLastNameUsuario => lastNameUsuario != null;
  bool get isPhoneNumberR => phoneNumberR != null;
  bool get isEmailControllerR => emailControllerR != null;
  bool get isPasswordControllerR => passwordControllerR != null;
  bool get isGenero => genero != null;

  bool get areAllDataCompleted =>
      isNameUsuario &&
      isLastNameUsuario &&
      isPhoneNumberR &&
      isEmailControllerR &&
      isPasswordControllerR &&
      isGenero;

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

  //Funciones que actualizan los valores y notifyListeners reactiva los widgets
  void setNameUsuario(String value) {
    nameUsuario = value;
    notifyListeners();
  }

  void setLastNameUsuario(String value) {
    lastNameUsuario = value;
    notifyListeners();
  }

  void setPhoneNumberR(String value) {
    phoneNumberR = value;
    notifyListeners();
  }

  void setEmailControllerR(String value) {
    emailControllerR = value;
    notifyListeners();
  }

  void setPasswordControllerR(String value) {
    passwordControllerR = value;
    notifyListeners();
  }

  void setGenero(String value) {
    genero = value;
    notifyListeners();
  }

  //Método para guardar en firestore

  Future<void> saveToFirestore() async {
    final data = {
      'nombre_usuario': nameUsuario,
      'apellido_usuario': lastNameUsuario,
      'numero_celular': phoneNumberR,
      'correo_electronico': emailControllerR,
      'contraseña': passwordControllerR,
      'genero': genero,
      'latitud': latitude,
      'fechahora': FieldValue.serverTimestamp(),
      'longitud': longitude,
    };

    try {
      await FirebaseFirestore.instance.collection('dataUsuarios').add(data);
      // ignore: avoid_print
      print('Datos almacenados correctamente en Firestore');
    } catch (e) {
      // ignore: avoid_print
      print('Error al almacenar data: $e');
    }
  }
}
