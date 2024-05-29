import 'package:flutter/material.dart';

import 'package:version/presentation/screens/cipres/biomass/dry_biomass_new.dart';
import 'package:version/presentation/screens/cipres/biomass/herbaceous_biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/leaf_litter_biomass_c.dart';
import 'package:version/presentation/screens/cipres/cipres_screen.dart';

class BiomassScreenC extends StatelessWidget {
  const BiomassScreenC({super.key});

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es la biomasa?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'En los sistemas silvopastoriles, la biomasa se refiere a la materia orgánica generada por la combinación de árboles, arbustos, pastos y ganado, optimizando el uso del suelo mediante la integración de la producción forestal y ganadera. Estos sistemas mejoran la fertilidad del suelo, facilitan un ciclo cerrado de nutrientes, capturan carbono, diversifican los ingresos y mejoran el microclima.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BiomassScreenC()));
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/cipres/biomass/biomass_c.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Possition of the botton
                  Positioned(
                    right: 5,
                    top: 50,
                    child: FilledButton.tonal(
                        onPressed: () => openDialog(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        child: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        )),
                  )
                ]),

                //Título
                const SizedBox(height: 25.0),
                const Text(
                  'Calculando la biomasa con Ciprés',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                //Formula
                const SizedBox(height: 25.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 191, 192, 191)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'BVT(Tm/ha) = BM ARBÓREA + BN HERBÁCEA \n + BM HOJARASCA',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                //Color plomo 255, 191, 192, 191

                //NOTA
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*BVT: Biomasa vegetal total (Tm/ha)',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),

                //Biomasa seca
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DryBiomassCNew()),
                        );
                      },
                      child: const Text(
                        'Biomasa seca',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Biomasa herbácea
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HerbaceousBiomassC()),
                        );
                      },
                      child: const Text(
                        'Biomasa herbácea',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Biomasa hojarasca
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LeafLitterBiomassC()),
                        );
                      },
                      child: const Text(
                        'Biomasa hojarasca',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //Guardar
                const SizedBox(height: 20.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 51, 79, 31)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CipresScreen()),
                        );
                      },
                      child: const Text(
                        'Calcular',
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
