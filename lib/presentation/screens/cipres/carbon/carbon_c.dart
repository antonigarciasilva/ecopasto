import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/biomass_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/conversion_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/soil_carbon_c.dart';

class CarbonScreenC extends StatefulWidget {
  const CarbonScreenC({super.key});

  @override
  State<CarbonScreenC> createState() => _CarbonScreenCState();
}

class _CarbonScreenCState extends State<CarbonScreenC> {
  //Vamos a llamar al provider
  StateBiomassC? stateBiomassC;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassC = Provider.of<StateBiomassC>(context);
  }

  //Dialogo informativo para carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,

        //para no poder salir del dialogo al hacer caulquier click
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
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar'))
                ]));
  }

  //Dialogo para mostrar al usuario que le faltan llenar algunos datos
  void _showMissingCalculationsDialog(
      BuildContext context, StateBiomassC stateBiomassC) {
    List<String> missingCalculations = [];

    if (!stateBiomassC.isGreenCipresCalculated) {
      missingCalculations.add('materia verde');
    }
    if (!stateBiomassC.isDryMatterCipresCalculated) {
      missingCalculations.add('materia seca');
    }
    if (!stateBiomassC.isDryBiomassCalculatedC) {
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
    final stateBiomass = Provider.of<StateBiomassC>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          //imagen de fondo
          Positioned.fill(
              child: Image.asset(
            'assets/img/cipres/carbon/carbon_ci.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          )),

          //Contenido principal
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Logo de la app
                  Image.asset(
                    'assets/img/only_logo.png',
                    height: 150,
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando carbono en la biomasa con Ciprés',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),

                  //Carbono en biomasa
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
                        onPressed: () {
                          if (stateBiomassC!.areBaseCalculatedC) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BiomassCarbonC()),
                            );
                          } else {
                            _showMissingCalculationsDialog(
                                context, stateBiomass);
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SoilCarbonC()),
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
                        onPressed: () {
                          if (stateBiomass.areBaseCalculatedC) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConversionCarbonC()),
                            );
                          } else {
                            _showMissingCalculationsDialog(
                                context, stateBiomass);
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

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*C: Carbono \n'
                        '*CO₂: Dióxido de carbono \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
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
