import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/leaf_litter_biomass.dart';
import 'package:version/presentation/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LeafLitterBiomassScreen(),
    );
  }
}
