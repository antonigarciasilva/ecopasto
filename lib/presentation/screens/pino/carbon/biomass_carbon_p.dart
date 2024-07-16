import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/no_tree/state_s.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';

import 'package:version/presentation/screens/pino/carbon/result_carbon_biomass_p.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

class BiomassCarbonPino extends StatefulWidget {
  const BiomassCarbonPino({super.key});

  @override
  State<BiomassCarbonPino> createState() => _BiomassCarbonPinoState();
}

class _BiomassCarbonPinoState extends State<BiomassCarbonPino> {
  StateBiomass? stateBiomass;
  StateBiomassC? stateBiomassC;
  StateBiomassP? stateBiomassP;
  StateBiomassO? stateBiomassO;
  StateST? stateST;
  String? errorMessage;

  //Para usar el provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
    stateBiomassC = Provider.of<StateBiomassC>(context);
    stateBiomassP = Provider.of<StateBiomassP>(context);
    stateBiomassO = Provider.of<StateBiomassO>(context);
    stateST = Provider.of<StateST>(context);
  }

  //Creamos función para ver la respuesta
  void _seeResultCarbonBiomassP() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultCarbonBiomassP(
                  //Aliso
                  resultCarbonBiomass: stateBiomass!.resultCarbonBiomass,
                  totalBiomass: stateBiomass!.totalBiomass,
                  resultConversionCarbon: stateBiomass!.resultConversionCarbon,
                  sumaTotal: stateBiomass!.sumaTotal,
                  //Ciprés
                  resultCarbonBiomassC: stateBiomassC!.resultCarbonBiomassC,
                  totalBiomassC: stateBiomassC!.totalBiomassC,
                  resultConversionCarbonC:
                      stateBiomassC!.resultConversionCarbonC,
                  sumaTotalC: stateBiomassC!.sumaTotalC,
                  //Pona
                  resultCarbonBiomassO: stateBiomassO!.resultCarbonBiomassO,
                  totalBiomassO: stateBiomassO!.totalBiomassO,
                  resultConversionCarbonO:
                      stateBiomassO!.resultConversionCarbonO,
                  sumaTotalO: stateBiomassO!.sumaTotalO,
                  //SSA
                  resultCarbonBiomassST: stateST!.resultCarbonBiomassST,
                  resultHerbaceousBiomassST: stateST!.resultHerbaceousBiomassST,
                  resultConversionCarbonST: stateST!.resultConversionCarbonST,
                  sumaTotalST: stateST!.sumaTotalST,
                  //Pino
                  resultCarbonBiomassP: stateBiomassP!.resultCarbonBiomassP,
                  totalBiomassP: stateBiomassP!.totalBiomassP,
                  resultConversionCarbonP:
                      stateBiomassP!.resultConversionCarbonP,
                  sumaTotalP: stateBiomassP!.sumaTotalP,
                )));
  }

  //Mostramos el mensaje de error
  void _calculateBiomassCarbonResult() {
    if (stateBiomassP?.totalBiomassP == 0.00) {
      setState(() {
        errorMessage =
            'Por favor, completa el modulo de biomasa para calcular el carbono';
      });
    } else {
      setState(() {
        errorMessage = null;
      });
      _seeResultCarbonBiomassP();
    }
  }

  //Dialogo informativo sobre el carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el carbono en la biomasa?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'Es la cantidad de carbono en componentes vivos de un ecosistema. Incluye árboles, arbustos, pastos y raíces. Las plantas capturan CO2 de la atmósfera y lo almacenan en sus tejidos. Actúa como un sumidero de carbono, ayudando a mitigar el cambio climático.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BiomassCarbonPino()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
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
                        'assets/img/pino/carbon/carbon_p.png',
                        fit: BoxFit.fitWidth,
                        height: 259,
                      ),
                    ),

                    //Possition of the botton
                    Positioned(
                      right: 5,
                      top: 50,
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
                  const SizedBox(height: 10.0),
                  const Text(
                    'Calculando carbono en la biomasa con Pino',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Formula
                  const SizedBox(height: 15.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'CBV(T/ha): BVT * 0.4270',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //NOTA
                  const SizedBox(height: 1),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*CBV: Carbono en biomasa vegetal(T/ha) \n'
                          '*0.4270: Fracción de carbono de Pino \n',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Formula con variable completa
                  const SizedBox(
                    height: 10,
                  ),

                  Column(
                    children: <Widget>[
                      Text(
                        'Reemplazando valares: \n'
                        'CBV(T/ha): ${stateBiomassP!.totalBiomassP.toStringAsFixed(2)} * 0.4270',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  //Mostrar el mensaje de error
                  if (errorMessage != null) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(fontSize: 15, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],

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
                        onPressed: _calculateBiomassCarbonResult,
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
