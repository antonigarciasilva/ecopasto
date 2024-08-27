import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

import 'package:version/presentation/screens/home/home_screen.dart';
import 'package:version/presentation/screens/no_tree/state_s.dart';

import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';

import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

//Pare importar firebase
import 'package:firebase_core/firebase_core.dart';

//import 'package:version/services/firebase_service.dart';
import 'firebase_options.dart';

//void main() => runApp(const MyApp());

//Para usar los provaiders en todo el proyecto se usa ProviderScope

Future<void> main() async {
  // Hacemos una función asincrona al main e inicializamos el firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateBiomass()),
      ChangeNotifierProvider(create: (context) => StateBiomassC()),
      ChangeNotifierProvider(create: (context) => StateBiomassP()),
      ChangeNotifierProvider(create: (context) => StateBiomassO()),
      ChangeNotifierProvider(create: (context) => StateST()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* @override
  void initState() {
    super.initState();

    //Llamamos al método savaToFireStore en initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //Obtenemos el stateBiomass del contexto usando provider
      StateBiomass stateBiomass =
          Provider.of<StateBiomass>(context, listen: false);

      //Guardamos los datos en fireStore
      await stateBiomass.saveToFirestore();
    });
  } */

  @override
  Widget build(BuildContext context) {
    //MaterialApp
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeScreen());
  }
}
