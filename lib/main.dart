import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/aliso_screen.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';

import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';

import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

//void main() => runApp(const MyApp());

//Para usar los provaiders en todo el proyecto se usa ProviderScope

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateBiomass()),
      ChangeNotifierProvider(create: (context) => StateBiomassC()),
      ChangeNotifierProvider(create: (context) => StateBiomassP()),
      ChangeNotifierProvider(create: (context) => StateBiomassO()),
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
      home: AlisoScreen(),
    );
  }
}
