import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/pino/biomass/dry_biomass_p.dart';
import 'package:version/presentation/screens/pino/biomass/herbaceous_biomass.dart';
import 'package:version/presentation/screens/pino/biomass/leaf_litter_biomass.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';

class BiomassPinoScreen extends StatefulWidget {
  const BiomassPinoScreen({
    super.key,
  });

  @override
  State<BiomassPinoScreen> createState() => _BiomassPinoScreenState();
}

class _BiomassPinoScreenState extends State<BiomassPinoScreen> {
  StateBiomassP? stateBiomassP;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassP = Provider.of<StateBiomassP>(context);
  }

  //Calculo de la biomass
  void _calculateBiomassResultP(StateBiomassP stateBiomassP) {
    final double totalBiomassP = stateBiomassP.totalBiomassP;

    final String formattedBiomassP = totalBiomassP.toStringAsFixed(2);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(
                'La biomasa total es: $formattedBiomassP T/ha',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonPinoScreen()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Dialogo informativo sobre el Aliso
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es la biomasa?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'En los sistemas silvopastoriles, la biomasa se refiere a la materia orgánica generada por la combinación de árboles, arbustos, pastos y ganado, optimizando el uso del suelo mediante la integración de la producción forestal y ganadera. Estos sistemas mejoran la fertilidad del suelo, facilitan un ciclo cerrado de nutrientes, capturan carbono, diversifican los ingresos y mejoran el microclima.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Dialogo de mensaje de error
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomassP stateBiomassP) {
    List<String> missingCalculations = [];

    if (!stateBiomassP.isDryBiomassCalculatedP) {
      missingCalculations.add('biomasa seca');
    }

    if (!stateBiomassP.isHerbaceousBiomassPCalculatedP) {
      missingCalculations.add('biomasa herbácea');
    }

    if (!stateBiomassP.isLeafLitterBiomassPCalculatedP) {
      missingCalculations.add('biomasa hojarasca');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener la biomasa total';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Cálculo incompletos'),
              content: Text(
                message,
                textAlign: TextAlign.justify,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //responsive
    final size = MediaQuery.of(context).size;
    //provider
    final stateBiomassP = Provider.of<StateBiomassP>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            //Imagen de fondo

            Positioned.fill(
                child: Image.asset(
              'assets/img/pino/biomass/biomasa_pino.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            )),

            //contenido central
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Logo de la app
                    Image.asset(
                      'assets/img/untrm_white_png.png',
                      color: Colors.white.withOpacity(0.7),
                      height: size.height * 0.2,
                    ),

                    //Título
                    SizedBox(height: size.height * 0.03),
                    const Text(
                      'Calculando la biomasa con Pino',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),

                    //Formula
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: size.width * 0.95,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 191, 192, 191)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'BVT(T/ha) = BM ARBÓREA + BN HERBÁCEA \n + BM HOJARASCA',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    //Color plomo 255, 191, 192, 191

                    //NOTA
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '*BVT: Biomasa vegetal total (T/ha)',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    //Biomasa seca
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(children: [
                        SizedBox(
                          width: size.width * 0.8,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  stateBiomassP.isDryBiomassCalculatedP
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 51, 79, 31)),
                            ),
                            onPressed: stateBiomassP.isDryBiomassCalculatedP
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DryBiomassP()),
                                    );
                                  },
                            child: const Text(
                              'Biomasa seca',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        if (stateBiomassP.isDryBiomassCalculatedP)
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DryBiomassP()));
                              },
                              icon: const Icon(Icons.edit))
                      ]),
                    ),

                    //Biomasa herbácea
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                stateBiomassP.resultHerbaceousBiomassP > 0
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed: () {
                            stateBiomassP.isHerbaceousBiomassPCalculatedP
                                ? null
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HerbaceousBiomassP()),
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
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(children: [
                        SizedBox(
                          width: size.width * 0.8,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  stateBiomassP.isLeafLitterBiomassPCalculatedP
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 51, 79, 31)),
                            ),
                            onPressed: () {
                              stateBiomassP.isLeafLitterBiomassPCalculatedP
                                  ? null
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LeafLitterBiomassP()),
                                    );
                            },
                            child: const Text(
                              'Biomasa hojarasca',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        if (stateBiomassP.isLeafLitterBiomassPCalculatedP)
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LeafLitterBiomassP()));
                              },
                              icon: const Icon(Icons.edit))
                      ]),
                    ),

                    //Calcular
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed: () async {
                            if (stateBiomassP.areCalculationsCompletedP) {
                              _calculateBiomassResultP(stateBiomassP);
                              //Guardar los datos en Firestore después de calcular
                              try {
                                //Obtener la ubicación antes de guardar
                                await stateBiomassP.getCurrentLocation();
                                //Guardamos en Firestore después de calcular y obtener la ubicación
                                await stateBiomassP.saveToFirestore();
                                //Para verificar si el widget aún esta montado
                                if (mounted) return;
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Datos guardados satisfactoriamente!')));
                              } catch (e) {
                                if (!mounted) return;
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Error al guardar datos: $e')));
                              }
                            } else {
                              _showMissingCalculationsDialog(
                                  context, stateBiomassP);
                            }
                          },
                          child: const Text(
                            'Calcular',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),

            //Botón informativo
            Positioned(
              top: size.height * 0.03,
              right: size.width * 0.01,
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
            )
          ],
        ),
      ),
    );
  }
}
