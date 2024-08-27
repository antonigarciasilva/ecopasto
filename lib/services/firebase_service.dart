//Aqui vamos a crear el CRUD con firestore

import 'package:cloud_firestore/cloud_firestore.dart';

//Instanciamos a firestore
FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addCity(
    {required String cityId, required Map<String, String> cityData}) async {
  try {
    //agregamos el documento de la colección 'cities'
    await db.collection("cities").doc(cityId).set(cityData);
    // ignore: avoid_print
    print("Document successfully written");

    //Verificamos si el documento se escribió correctamente
    final writtenDoc = await db.collection("cities").doc(cityId).get();
    if (writtenDoc.exists) {
      // ignore: avoid_print
      print("Document written and verified");
    } else {
      // ignore: avoid_print
      print("Document written but not found during verification.");
    }
  } catch (e) {
    //Manejo de los errores
    if (e is FirebaseException && e.code == 'unavailable') {
      // ignore: avoid_print
      print("Firestore service unavailable: $e");
    } else {
      // ignore: avoid_print
      print("Error writting document: $e");
    }
    // ignore: avoid_print
    print("Error writing document:: $e");
  }
}
