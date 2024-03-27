import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/biomass.dart';
import 'package:version/presentation/screens/aliso/cabon_biomass.dart';
import 'package:version/presentation/screens/aliso/dry_matter.dart';
import 'package:version/presentation/screens/aliso/green_matter.dart';

class AlisoScreen extends StatelessWidget {
  const AlisoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/img/cypress.jpg',
                fit: BoxFit.fitWidth,
                height: 299,
              ),
            ),

            //Título
            const SizedBox(height: 20.0),
            const Text(
              'Silvipastoreo con Aliso',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            //Materia verde
            const SizedBox(height: 20.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 51, 79, 31)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GreenMatterScreen()),
                    );
                  },
                  child: const Text(
                    'Materia verde',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            //Materia seca
            const SizedBox(height: 20.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 51, 79, 31)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DryMatterScreen()),
                    );
                  },
                  child: const Text(
                    'Materia seca',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            //Biomasa
            const SizedBox(height: 20.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 51, 79, 31)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BiomassScreen()),
                    );
                  },
                  child: const Text(
                    'Biomasa',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            //Carbono en la biomasa
            const SizedBox(height: 20.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 51, 79, 31)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CarbonBiomassScreen()),
                    );
                  },
                  child: const Text(
                    'Carbono en la biomasa',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
title: Row(
          children: <Widget>[
            Image.asset(
              'assets/img/cypress.jpg',
              height: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Silvipastoreo con aliso',
              style: TextStyle(fontSize: 12),
            )
          ],
        ), */
