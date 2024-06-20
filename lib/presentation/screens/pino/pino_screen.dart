import 'package:flutter/material.dart';

import 'package:version/presentation/screens/pino/biomass/biomass.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';
import 'package:version/presentation/screens/pino/dry_matter_p.dart';
import 'package:version/presentation/screens/pino/green_matter_p.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

class PinoScreen extends StatelessWidget {
  const PinoScreen({super.key});

  //Funcion de boton informativo
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el Pino?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El árbol de pino (Pinus spp.) en sistemas silvopastoriles es una especie de árbol conífero ampliamente utilizada por su madera, resina y otros productos forestales. En sistemas silvopastoriles, el pino proporciona sombra, protección contra el viento y mejora la calidad del suelo. Además, puede ser utilizado como fuente de alimento y forraje para animales en sistemas agroforestales.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PinoScreen()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Silvopastoreo con Pino',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const SideMenu(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/pino/pino.jpg',
                      fit: BoxFit.fitWidth,
                      height: 299,
                    ),
                  ),

                  //Posición del botton
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

                /* //Título
                //const SizedBox(height: 5.0),
                const Text(
                  'Silvipastoreo con Pino',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ), */

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
                              builder: (context) => const GreenMatterP()),
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
                              builder: (context) => const DryMatterP()),
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
                              builder: (context) => const BiomassPinoScreen()),
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
                              builder: (context) => const CarbonPinoScreen()),
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
      ),
    );
  }
}
