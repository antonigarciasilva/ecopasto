import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pona/biomass/dry_biomass_pona.dart';
import 'package:version/presentation/screens/pona/biomass/herbaceous_biomass_pona.dart';
import 'package:version/presentation/screens/pona/biomass/leaf_litter_biomass_pona.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';
import 'package:version/presentation/screens/pona/carbon/carbon_pona.dart';

class BiomassPona extends StatefulWidget {
  //'?' significa que la variable puede ser nula o tomar el valo dado
  //final double? resultdbo;

  const BiomassPona({
    super.key,
  });

  @override
  State<BiomassPona> createState() => _BiomassPonaState();
}

class _BiomassPonaState extends State<BiomassPona> {
  StateBiomassO? stateBiomassO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassO = Provider.of<StateBiomassO>(context);
  }

  //calculando la biomasa
  void _calculateBiomassResultO(StateBiomassO stateBiomassO) {
    final double totalBiomassO = stateBiomassO.totalBiomassO;

    final String formattedBiomassO = totalBiomassO.toStringAsFixed(2);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(
                'La biomasa total es: $formattedBiomassO T/ha',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonPonaScreen()));
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

  //Dialogo para mensajes de lo que falta
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomassO stateBiomassO) {
    List<String> missingCalculations = [];

    if (!stateBiomassO.isDryBiomassCalculatedO) {
      missingCalculations.add('biomasa seca');
    }
    if (!stateBiomassO.isHerbaceousBiomassCalculatedO) {
      missingCalculations.add('biomasa herbácea');
    }
    if (!stateBiomassO.isLeafLitterBiomassCalculatedO) {
      missingCalculations.add('biomasa hojarasca');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener la biomasa total';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Calculos incompletos',
                textAlign: TextAlign.center,
              ),
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
    final stateBiomassO = Provider.of<StateBiomassO>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //imagen de fondo
          Positioned.fill(
              child: Image.asset(
            'assets/img/pona/biomass/pona_b.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          )),

          //Contenido central
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Logo de la app
                  Image.asset(
                    'assets/img/only_logo.png',
                    height: 120,
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la biomasa con Pona',
                    style: TextStyle(
                        fontSize: 18,
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
                          '*BVT: Biomasa vegetal total (Tm/ha)',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //Biomasa seca
                  const SizedBox(height: 20.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Stack(children: [
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                stateBiomassO.isDryBiomassCalculatedO
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed: stateBiomassO.isDryBiomassCalculatedO
                              ? null
                              : () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DryBiomassPona()),
                                  );
                                },
                          child: const Text(
                            'Biomasa seca',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      if (stateBiomassO.isDryBiomassCalculatedO)
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DryBiomassPona()));
                            },
                            icon: const Icon(Icons.edit))
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
                              stateBiomassO.resultHerbaceousBiomassO > 0
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: stateBiomassO.isHerbaceousBiomassCalculatedO
                            ? null
                            : () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HerbaceousBiomassPona()),
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
                    child: Stack(children: [
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                stateBiomassO.isLeafLitterBiomassCalculatedO
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed:
                              stateBiomassO.isLeafLitterBiomassCalculatedO
                                  ? null
                                  : () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LeafLitterBiomassPona()),
                                      );
                                    },
                          child: const Text(
                            'Biomasa hojarasca',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      if (stateBiomassO.isLeafLitterBiomassCalculatedO)
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LeafLitterBiomassPona()));
                            },
                            icon: const Icon(Icons.edit))
                    ]),
                  ),

                  //Guardar
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
                          if (stateBiomassO.areAllCalculationsCompletedO) {
                            _calculateBiomassResultO(stateBiomassO);
                            //Guardar los datos en Firestore después de calcular
                            try {
                              //Obtener la ubicación antes de guardar
                              await stateBiomassO.getCurrentLocation();
                              //Guardamos en Firestore después de calcular y obtener la ubicación
                              await stateBiomassO.saveToFirestore();
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
                                context, stateBiomassO);
                          }
                        },
                        child: const Text(
                          'Calcular',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
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
