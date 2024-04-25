import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/dry_biomass.dart';
import 'package:version/presentation/screens/aliso/dry_matter.dart';
import 'package:version/presentation/screens/login/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: DryBiomassScreen(),
    );
  }
}
