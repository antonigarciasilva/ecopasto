import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/aliso/carbon/biomass_carbon.dart';
import 'package:version/presentation/screens/aliso/carbon/conversion_carbon.dart';
import 'package:version/presentation/screens/aliso/carbon/soil_carbon.dart';
import 'package:version/presentation/screens/widgets/side_menu.dart';

class CarbonScreen extends StatefulWidget {
  const CarbonScreen({super.key});

  @override
  State<CarbonScreen> createState() => _CarbonScreenState();
}

class _CarbonScreenState extends State<CarbonScreen>
    with WidgetsBindingObserver {
  //Para usar el stateBiomas con provider
  StateBiomass? stateBiomass;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: avoid_print
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'El carbono en los sistemas silvopastoriles se almacena en la biomasa de árboles y pastos, en el suelo y en los residuos animales, desempeñando un papel crucial en la captura de CO₂ y la mitigación del cambio climático. Estos sistemas integrados mejoran la fertilidad del suelo, aumentan su capacidad de retención de agua y nutrientes, y promueven la resiliencia ecológica.\n'
                '(Vásquez, 2023)',
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
    final stateBiomass = Provider.of<StateBiomass>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Calculando carbono \n'
          'con Aliso ',
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
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
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
                          width: size.width * 0.8,
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                                        const SoilCarbonScreen()),
                              );
                            },
                            child: const Text(
                              'Carbono en el suelo',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                            style: TextStyle(fontSize: 12, color: Colors.white),
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
        }),
      ),
    );
  }
}
