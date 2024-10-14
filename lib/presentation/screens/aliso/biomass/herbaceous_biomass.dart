import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

class HerbaceousBiomassScreen extends StatefulWidget {
  const HerbaceousBiomassScreen({super.key});

  @override
  State<HerbaceousBiomassScreen> createState() =>
      _HerbaceousBiomassScreenState();
}

class _HerbaceousBiomassScreenState extends State<HerbaceousBiomassScreen>
    with WidgetsBindingObserver {
  StateBiomass? stateS;
  String? errorMessage;

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

  //Para usar el provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateS = Provider.of<StateBiomass>(context);
  }

  // Calculo de la biomasa herbacea

  void _calculateHerbaceousBiomassResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                'Resultado del cálculo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'La biomasa herbácea es: ${stateS!.resultBiomassHerbaceous.toStringAsFixed(2)} T/ha',
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
                              builder: (context) =>
                                  const BiomassAlderScreen()));
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
                '¿Qué es la biomasa herbácea?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La biomasa herbácea se refiere a la materia orgánica de las plantas herbáceas, que son plantas no leñosas como pastos, flores silvestres y otras plantas de bajo crecimiento. Estas plantas suelen ser de ciclo de vida corto y juegan un papel importante en los ecosistemas, proporcionando alimento para herbívoros, contribuyendo a la estabilidad del suelo y participando en los ciclos de nutrientes.',
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

  @override
  Widget build(BuildContext context) {
    //responsive
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/img/aliso/biomass/herbaceous_a.jpg',
                        fit: BoxFit.fitHeight,
                        height: size.height * 0.55,
                      ),
                    ),
                    //Possition of the botton
                    Positioned(
                      top: size.height * 0.05,
                      right: size.width * 0.01,
                      child: FilledButton.tonal(
                          onPressed: () => openDialog(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          )),
                    )
                  ]),

                  //Título
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando la biomasa herbácea con Aliso',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BH(T/ha) = ((PSM/PFM) * PFT) * 0.01',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NOTA
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa herbácea(T/ha) \n'
                          '*0.01: Factor de conversión para biomasa herbácea \n',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Formula con variable completa
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reemplazando valores:\n'
                        'BH(T/ha): (${stateS!.dryMatterAliso!.toStringAsFixed(2)} / ${stateS!.greenAliso!.toStringAsFixed(2)} * ${stateS!.greenAliso!.toStringAsFixed(2)} )\n '
                        ' * 0.01  ',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 20),
                    ],
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
                        onPressed: _calculateHerbaceousBiomassResult,
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
        ),
      ),
    );
  }
}
