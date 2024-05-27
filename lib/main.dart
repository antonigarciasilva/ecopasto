import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/biomass/dry_biomass_new.dart';
import 'package:version/presentation/screens/pona/carbon/soil_carbon_pona_n.dart';

import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

void main() => runApp(const MyApp());

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
