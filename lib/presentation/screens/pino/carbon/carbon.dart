import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/carbon/biomass_carbon_p.dart';
import 'package:version/presentation/screens/pino/carbon/conversion_carbon_p.dart';
import 'package:version/presentation/screens/pino/carbon/soil_carbon_p.dart';

class CarbonPinoScreen extends StatefulWidget {
  const CarbonPinoScreen({super.key});

  @override
  State<CarbonPinoScreen> createState() => _CarbonPinoScreenState();
}

class _CarbonPinoScreenState extends State<CarbonPinoScreen> {
  //Vamos a llamar al provider
  StateBiomassP? stateBiomassP;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassP = Provider.of<StateBiomassP>(context);
  }

  //Dialogo informativo sobre el carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el carbono?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica. ',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
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

  //Dialogo para mostrar al usuario que le faltan llenar algunos datos
  void _showMissingCalculationsDialogP(
      BuildContext context, StateBiomassP stateBiomassP) {
    List<String> missingCalculations = [];

    if (!stateBiomassP.isGreenPinoCalculated) {
      missingCalculations.add('materia verde');
    }
    if (!stateBiomassP.isDryMatterPinoCalculated) {
      missingCalculations.add('materia seca');
    }
    if (!stateBiomassP.isDryBiomassCalculatedP) {
      missingCalculations.add('biomasa total');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener resultados con carbono';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Cálculos imcompletos',
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
    //responsive
    final size = MediaQuery.of(context).size;
    //Provider
    final stateBiomassP = Provider.of<StateBiomassP>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //Imagen de fondo
          Positioned.fill(
              child: Image.asset(
            'assets/img/pino/carbon/carbon_pino.jpg',
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
                    'assets/img/only_logo.png',
                    height: size.height * 0.2,
                  ),

                  //Título
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando carbono en la biomasa con Pino',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),

                  //Carbono en biomasa
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
                        onPressed: () {
                          if (stateBiomassP.areCalculationsCompletedP) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BiomassCarbonPino()),
                            );
                          } else {
                            _showMissingCalculationsDialogP(
                                context, stateBiomassP);
                          }
                        },
                        child: const Text(
                          'Carbono en biomasa',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //Carbono en el suelo
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SoilCarbonPino()),
                          );
                        },
                        child: const Text(
                          'Carbono en el suelo',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //Conversión de carbono a dióxido de carbono
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
                        onPressed: () {
                          if (stateBiomassP.areCalculationsCompletedP) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConversionCarbonPino()),
                            );
                          } else {
                            _showMissingCalculationsDialogP(
                                context, stateBiomassP);
                          }
                        },
                        child: const Text(
                          'Conversión de C a CO₂',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.12),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*C: Carbono \n'
                        '*CO₂: Dióxido de carbono \n',
                        style: TextStyle(fontSize: 10, color: Colors.white),
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
              top: size.height * 0.05,
              right: size.width * 0.01,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
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
                ],
              )),
        ],
      )),
    );
  }
}
