import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/aliso/state_aliso.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/state_cipres.dart';

import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/state_pino.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';
import 'package:version/presentation/screens/pona/state_pona.dart';
import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

//void main() => runApp(const MyApp());

//Para usar los provaiders en todo el proyecto se usa ProviderScope

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateBiomass()),
      ChangeNotifierProvider(create: (context) => StateBiomassC()),
      ChangeNotifierProvider(create: (context) => StateBiomassP()),
      ChangeNotifierProvider(create: (context) => StateBiomassO()),
      ChangeNotifierProvider(create: (context) => StateS()),
      ChangeNotifierProvider(create: (context) => StatePino()),
      ChangeNotifierProvider(create: (context) => StateCipres()),
      ChangeNotifierProvider(create: (context) => StatePona()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: NewSelectSilvoScreen(),
    );
  }
}
