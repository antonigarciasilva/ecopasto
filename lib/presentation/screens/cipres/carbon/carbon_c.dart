import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/biomass_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/conversion_carbon_c.dart';
import 'package:version/presentation/screens/cipres/carbon/soil_carbon_c.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14),
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
              backgroundColor: Colors.white,
              title: const Text(
                'Cálculos imcompletos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                message,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
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
    final stateBiomass = Provider.of<StateBiomassC>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Calculando carbono \n'
          'con Ciprés ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      drawer: const SideMenu(),
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
                    'assets/img/untrm_white_png.png',
                    color: Colors.white.withOpacity(0.7),
                    height: size.height * 0.2,
                  ),

                  //Carbono en biomasa
                  SizedBox(height: size.height * 0.03),
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
                  SizedBox(height: size.height * 0.03),
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
                  SizedBox(height: size.height * 0.03),
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
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.18,
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
          )
        ],
      )),
    );
  }
}
