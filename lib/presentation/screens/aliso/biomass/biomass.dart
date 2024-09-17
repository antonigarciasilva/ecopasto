import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/aliso/biomass/herbaceous_biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/leaf_litter_biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/newdry_biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';

class BiomassAlderScreen extends StatefulWidget {
  const BiomassAlderScreen({
    super.key,
  });

  @override
  State<BiomassAlderScreen> createState() => _BiomassAlderScreenState();
}

class _BiomassAlderScreenState extends State<BiomassAlderScreen> {
  StateBiomass? stateBiomass;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
  }

  //Dialogo informativo sobre la biomasa
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'En los sistemas silvopastoriles, la biomasa se refiere a la materia orgánica generada por la combinación de árboles, arbustos, pastos y ganado, optimizando el uso del suelo mediante la integración de la producción forestal y ganadera. Estos sistemas mejoran la fertilidad del suelo, facilitan un ciclo cerrado de nutrientes, capturan carbono, diversifican los ingresos y mejoran el microclima.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Calculando la biomasa
  void _calculateBiomassResult(StateBiomass stateBiomass) {
    final double totalBiomass = stateBiomass.totalBiomass;

    final String formattedBiomass = totalBiomass.toStringAsFixed(2);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Resultado de cálculo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'La biomasa total es: $formattedBiomass T/ha',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarbonScreen()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  //Dialogo para mostrar al usuario que le faltan llenar algunos datos
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomass stateBiomass) {
    List<String> missingCalculations = [];

    if (!stateBiomass.isDryBiomassCalculated) {
      missingCalculations.add('biomasa seca');
    }
    if (!stateBiomass.isHerbaceousBiomassCalculated) {
      missingCalculations.add('biomasa herbácea');
    }
    if (!stateBiomass.isLeafLitterBiomassCalculated) {
      missingCalculations.add('biomasa hojarasca');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener la biomasa total';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Cálculos imcompletos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14),
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
    final stateBiomass = Provider.of<StateBiomass>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child:
          //Responsive
          LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            //imagen de fondo
            Positioned.fill(
                child: Image.asset(
              'assets/img/aliso/biomass/arbol_aliso.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            )),

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
                      'Calculando la biomasa con Aliso',
                      style: TextStyle(
                          fontSize: 16,
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
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.12,
                        ),
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
                      child: Stack(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    stateBiomass.isDryBiomassCalculated
                                        ? Colors.grey
                                        : const Color.fromARGB(
                                            255, 51, 79, 31)),
                              ),
                              onPressed: stateBiomass.isDryBiomassCalculated
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NewDryBiomassScreen()),
                                      );
                                    },
                              child: const Text(
                                'Biomasa seca',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          if (stateBiomass.isDryBiomassCalculated)
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewDryBiomassScreen()));
                                },
                                icon: const Icon(Icons.edit))
                        ],
                      ),
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
                                  stateBiomass.resultBiomassHerbaceous > 0
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 51, 79, 31)),
                            ),
                            onPressed:
                                stateBiomass.isHerbaceousBiomassCalculated
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HerbaceousBiomassScreen()),
                                        );
                                      },
                            child: const Text(
                              'Biomasa herbácea',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                    ),

                    //Biomasa hojarasca
                    SizedBox(height: size.height * 0.03),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    stateBiomass.isLeafLitterBiomassCalculated
                                        ? Colors.grey
                                        : const Color.fromARGB(
                                            255, 51, 79, 31)),
                              ),
                              onPressed:
                                  stateBiomass.isLeafLitterBiomassCalculated
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LeafLitterBiomassScreen()),
                                          );
                                        },
                              child: const Text(
                                'Biomasa hojarasca',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          if (stateBiomass.isLeafLitterBiomassCalculated)
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LeafLitterBiomassScreen()));
                                },
                                icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),

                    //Calcular la biomass total
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
                            if (stateBiomass.areAllCalculationsCompleted) {
                              _calculateBiomassResult(stateBiomass);

                              //Guardar los datos en Firestore después de calcular
                              try {
                                //Obtener la ubicación antes de guardar
                                await stateBiomass.getCurrentLocation();
                                //Guardamos en firestore después de calcuular y obtener la ubicación
                                await stateBiomass.saveToFirestore();

                                //Para verificar si le widget aún esta montando
                                if (!mounted) return;
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Datos guardados satisfactoriamente!')));
                              } catch (e) {
                                if (!mounted)
                                  // ignore: curly_braces_in_flow_control_structures
                                  return; //Verificar si el widget está montado
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Error al guardar data: $e')));
                              }
                            } else {
                              _showMissingCalculationsDialog(
                                  context, stateBiomass);
                            }
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

            //Botón informativo

            Positioned(
              top: size.height * 0.05,
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
        );
      })),
    );
  }
}
