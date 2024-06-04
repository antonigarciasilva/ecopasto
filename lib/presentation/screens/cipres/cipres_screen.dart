import 'package:flutter/material.dart';

import 'package:version/presentation/screens/cipres/biomass/biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';
import 'package:version/presentation/screens/cipres/dry_matter_c.dart';
import 'package:version/presentation/screens/cipres/green_matter_c.dart';

class CipresScreen extends StatelessWidget {
  const CipresScreen({super.key});

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el Ciprés?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El árbol de ciprés (Cupressus spp.) en sistemas silvopastoriles es una especie de árbol conífero que se utiliza por su rápido crecimiento y su capacidad para proporcionar sombra y protección contra el viento. También puede ayudar a reducir la erosión del suelo y mejorar la biodiversidad en la zona.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CipresScreen()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/img/cipres/cypress.jpg',
                    fit: BoxFit.fitWidth,
                    height: 299,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 10,
                  child: FilledButton.tonal(
                    onPressed: () => openDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),

              //Título
              //const SizedBox(height: 5.0),
              const Text(
                'Silvipastoreo con Cipres',
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
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GreenMatterC()),
                      );
                    },
                    child: const Text(
                      '1. Materia verde',
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
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DryMatterC()),
                      );
                    },
                    child: const Text(
                      '2. Materia seca',
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
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BiomassScreenC()),
                      );
                    },
                    child: const Text(
                      ' 3. Biomasa',
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
                  width: 260,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 51, 79, 31)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarbonScreenC()),
                      );
                    },
                    child: const Text(
                      '4. Carbono en la biomasa',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
