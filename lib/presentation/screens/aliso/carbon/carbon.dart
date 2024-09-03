import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/aliso/carbon/biomass_carbon.dart';
import 'package:version/presentation/screens/aliso/carbon/conversion_carbon.dart';
import 'package:version/presentation/screens/aliso/carbon/soil_carbon.dart';

class CarbonScreen extends StatefulWidget {
  const CarbonScreen({super.key});

  @override
  State<CarbonScreen> createState() => _CarbonScreenState();
}

class _CarbonScreenState extends State<CarbonScreen> {
  //Para usar el stateBiomas con provider
  StateBiomass? stateBiomass;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
  }

  //Dialogo informativo sobre el carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Qué es el carbono?',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica. ',
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

  //Dialogo para mostrar al usuario que le faltan llenar algunos datos
  void _showMissingCalculationsDialogA(
      BuildContext context, StateBiomass stateBiomass) {
    List<String> missingCalculations = [];

    if (!stateBiomass.isGreenSCalculated) {
      missingCalculations.add('materia verde');
    }
    if (!stateBiomass.isDryMatterSCalculated) {
      missingCalculations.add('materia seca');
    }
    if (!stateBiomass.isDryBiomassCalculated) {
      missingCalculations.add('biomasa total');
    }

    String message =
        'Falta calcular: ${missingCalculations.join(', ')} para obtener un resultado con carbono';

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
    final stateBiomass = Provider.of<StateBiomass>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            //Imagen de fondo
            Positioned.fill(
                child: Image.asset(
              'assets/img/aliso/carbon/hoja_seca_a.jpg',
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
                    const Stack(children: [
                      //Título
                      SizedBox(height: 25.0),
                      Text(
                        'Calculando carbono en la biomasa con Aliso',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),

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
                            if (stateBiomass.areAllBaseCalculateCompleted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BiomassCarbonScreen()),
                              );
                            } else {
                              _showMissingCalculationsDialogA(
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
                                  builder: (context) =>
                                      const SoilCarbonScreen()),
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
                            if (stateBiomass.areAllBaseCalculateCompleted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConversionCarbonScreen()),
                              );
                            } else {
                              _showMissingCalculationsDialogA(
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
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
                    width: 20,
                  ),
                  Image.asset(
                    'assets/img/igbi_blanco_u.png',
                    height: 60,
                  ),
                  const SizedBox(
                    width: 20,
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
                top: 45,
                right: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Logo de la app
                    Image.asset(
                      'assets/img/amas_white.png',
                      height: 90,
                    ),
                  ],
                )),

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
        ),
      ),
    );
  }
}
