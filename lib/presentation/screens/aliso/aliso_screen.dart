import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/biomass/biomass.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';
import 'package:version/presentation/screens/aliso/dry_matter.dart';
import 'package:version/presentation/screens/aliso/green_matter.dart';

class AlisoScreen extends StatelessWidget {
  const AlisoScreen({super.key});

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el Aliso?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El árbol de aliso (Alnus acuminata) en sistemas silvopastoriles es una especie arbórea utilizada por sus beneficios ambientales y productivos. Proporciona sombra, mejora la calidad del suelo y puede utilizarse como fuente de alimento y forraje para animales en sistemas agroforestales.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AlisoScreen()));
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
              //Botón informativo
              Stack(children: [
                //imagen de la pantalla
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/img/aliso/aliso.jpg',
                    fit: BoxFit.fitWidth,
                    height: 299,
                  ),
                ),

                Positioned(
                  right: 5,
                  top: 50,
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
                            builder: (context) => const GreenMatterScreen()),
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
                            builder: (context) => const DryMatterScreen()),
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
                            builder: (context) => const BiomassAlderScreen()),
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
                            builder: (context) => const CarbonScreen()),
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
