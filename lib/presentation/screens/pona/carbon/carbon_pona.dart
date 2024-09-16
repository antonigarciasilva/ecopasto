import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

import 'package:version/presentation/screens/pona/carbon/biomass_carbon_pona.dart';
import 'package:version/presentation/screens/pona/carbon/conversion_carbon_pona.dart';

import 'package:version/presentation/screens/pona/carbon/soil_carbon_pona_n.dart';

class CarbonPonaScreen extends StatefulWidget {
  const CarbonPonaScreen({super.key});

  @override
  State<CarbonPonaScreen> createState() => _CarbonPonaScreenState();
}

class _CarbonPonaScreenState extends State<CarbonPonaScreen> {
  //Vamos a llamar al provider
  StateBiomassO? stateBiomassO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassO = Provider.of<StateBiomassO>(context);
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica. ',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
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

  //Dialogo para mostrar al usuario que le faltan llenar algunos datos
  void _showMissingCalculationsDialogP(
      BuildContext context, StateBiomassO stateBiomassO) {
    List<String> missingCalculations = [];

    if (!stateBiomassO.isGreenPonaCalculated) {
      missingCalculations.add('materia verde');
    }
    if (!stateBiomassO.isDryMatterPonaCalculated) {
      missingCalculations.add('materia seca');
    }
    if (!stateBiomassO.isDryBiomassCalculatedO) {
      missingCalculations.add('biomasa total');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener resultados con carbono';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                'Cálculos imcompletos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //Imagen de fondo
          Positioned.fill(
              child: Image.asset(
            'assets/img/pona/carbon/carbon_op.jpg',
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
                    height: size.height * 0.2,
                  ),

                  //Título
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando carbono en la biomasa con Pona',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BiomassCarbonPona()),
                          );
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
                                builder: (context) =>
                                    const SoilCarbonPonaNew()),
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
                          if (stateBiomassO!.areCalculatedCarbonoO) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConversionCarbonPona()),
                            );
                          } else {
                            _showMissingCalculationsDialogP(
                                context, stateBiomassO!);
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*C: Carbono \n'
                        '*CO₂: Dióxido de carbono \n',
                        style: TextStyle(fontSize: 10, color: Colors.white),
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
          ),
        ],
      )),
    );
  }
}
