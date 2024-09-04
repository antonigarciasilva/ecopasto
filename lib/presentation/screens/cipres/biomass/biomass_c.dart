import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/cipres/biomass/dry_biomass_new.dart';
import 'package:version/presentation/screens/cipres/biomass/herbaceous_biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/leaf_litter_biomass_c.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class BiomassScreenC extends StatefulWidget {
  const BiomassScreenC({
    super.key,
  });

  @override
  State<BiomassScreenC> createState() => _BiomassScreenCState();
}

class _BiomassScreenCState extends State<BiomassScreenC> {
  StateBiomassC? stateBiomassC;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassC = Provider.of<StateBiomassC>(context);
  }

//Calculando la biomasa
  void _calculateBiomassResultC(StateBiomassC stateBiomassC) {
    final double totalBiomassC = stateBiomassC.totalBiomassC;

    final String formattedBiomassC = totalBiomassC.toStringAsFixed(2);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(
                'La biomasa total es: $formattedBiomassC T/ha',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CarbonScreenC()),
                      );
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

  //Mostrar dialogo de las cosas que faltan para calcular la biomasa total
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomassC stateBiomassC) {
    List<String> missingCalculations = [];

    if (!stateBiomassC.isDryBiomassCalculatedC) {
      missingCalculations.add('biomasa seca');
    }

    if (!stateBiomassC.isherbaceousCalculatedC) {
      missingCalculations.add('biomasa herbácea');
    }

    if (!stateBiomassC.isleafLitterBiomassCCalculatedC) {
      missingCalculations.add('biomasa hojarasca');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener la biomasa total';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Calculos incompletos'),
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
    final stateBiomassC = Provider.of<StateBiomassC>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //imagen de fondo
          Positioned.fill(
              child: Image.asset(
            'assets/img/cipres/biomass/cipres_b.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          )),
          //Contenido total
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Logo de la app
                  Image.asset(
                    'assets/img/only_logo.png',
                    height: 100,
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la biomasa con Ciprés',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),

                  //Formula
                  const SizedBox(height: 25.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BVT(T/ha) = BM ARBÓREA + BN HERBÁCEA \n + BM HOJARASCA',
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
                          '*BVT: Biomasa vegetal total (T/ha)',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //Biomasa seca
                  const SizedBox(height: 20.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 240,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            stateBiomassC
                                                    .isDryBiomassCalculatedC
                                                ? Colors.grey
                                                : const Color.fromARGB(
                                                    255, 51, 79, 31)),
                                  ),
                                  onPressed:
                                      stateBiomassC.isDryBiomassCalculatedC
                                          ? null
                                          : () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DryBiomassCNew()),
                                              );
                                            },
                                  child: const Text(
                                    'Biomasa seca',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              if (stateBiomassC.isDryBiomassCalculatedC)
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DryBiomassCNew()));
                                    },
                                    icon: const Icon(Icons.edit))
                            ],
                          ),
                        ]),
                  ),

                  //Biomasa herbácea
                  const SizedBox(height: 20.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              stateBiomassC.resultHerbaceousBiomassC > 0
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: stateBiomassC.isherbaceousCalculatedC
                            ? null
                            : () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HerbaceousBiomassC()),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 240,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<
                                        Color>(stateBiomassC
                                            .isleafLitterBiomassCCalculatedC
                                        ? Colors.grey
                                        : const Color.fromARGB(
                                            255, 51, 79, 31)),
                                  ),
                                  onPressed: stateBiomassC
                                          .isleafLitterBiomassCCalculatedC
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LeafLitterBiomassC()),
                                          );
                                        },
                                  child: const Text(
                                    'Biomasa hojarasca',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              if (stateBiomassC.isleafLitterBiomassCCalculatedC)
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LeafLitterBiomassC()));
                                    },
                                    icon: const Icon(Icons.edit))
                            ],
                          ),
                        ]),
                  ),

                  //Calcular
                  const SizedBox(height: 20.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () async {
                          if (stateBiomassC.areAllCalculationsCompletedC) {
                            _calculateBiomassResultC(stateBiomassC);
                            //Guardar los datos en Firestore después de calcular
                            try {
                              //Obtener la ubicación antes de guardar
                              await stateBiomassC.getCurrentLocation();
                              //Guardamos en Firestore después de calcular y obtener la ubicación
                              await stateBiomassC.saveToFirestore();
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
                                      content:
                                          Text('Error al guardar datos: $e')));
                            }
                          } else {
                            _showMissingCalculationsDialog(
                                context, stateBiomassC);
                          }
                        },
                        child: const Text(
                          'Calcular',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70.0),
                ],
              ),
            ),
          ),
          //logos parte inferior
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/fizab_blanco.png',
                  height: 60,
                ),
                const SizedBox(
                  width: 40,
                ),
                Image.asset(
                  'assets/img/igbi_blanco_u.png',
                  height: 60,
                ),
                const SizedBox(
                  width: 40,
                ),
                Image.asset(
                  'assets/img/agrolab_blanco.png',
                  height: 60,
                )
              ],
            ),
          ),
          //Botón informativo
          Positioned(
            top: 20,
            right: 10,
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
      )),
    );
  }
}
