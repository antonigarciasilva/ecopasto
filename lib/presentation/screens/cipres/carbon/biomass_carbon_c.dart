import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';

import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/carbon/result_carbon_biomass_c.dart';
import 'package:version/presentation/screens/no_tree/state_s.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';

class BiomassCarbonC extends StatefulWidget {
  const BiomassCarbonC({super.key});

  @override
  State<BiomassCarbonC> createState() => _BiomassCarbonCState();
}

class _BiomassCarbonCState extends State<BiomassCarbonC> {
  StateBiomass? stateBiomass;
  StateBiomassC? stateBiomassC;
  StateBiomassP? stateBiomassP;
  StateBiomassO? stateBiomassO;
  StateST? stateST;
  String? errorMessage;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
    stateBiomassC = Provider.of<StateBiomassC>(context);
    stateBiomassP = Provider.of<StateBiomassP>(context);
    stateBiomassO = Provider.of<StateBiomassO>(context);
    stateST = Provider.of<StateST>(context);
  }

  void _seeResultCarbonBiomassC() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultCarbonBiomassC(
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

  //Calculamos el carbon con la biomasa
  void _calculateBiomassCarbonResult() {
    if (stateBiomassC?.totalBiomassC == 0.00) {
      setState(() {
        errorMessage =
            'Por favor, completa el modulo de biomasa para calcular el carbono';
      });
    } else {
      setState(() {
        errorMessage = null;
      });
      _seeResultCarbonBiomassC();
    }
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
                '¿Qué es el carbono en la biomasa?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Es la cantidad de carbono en componentes vivos de un ecosistema. Incluye árboles, arbustos, pastos y raíces. Las plantas capturan CO2 de la atmósfera y lo almacenan en sus tejidos. Actúa como un sumidero de carbono, ayudando a mitigar el cambio climático.',
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

  @override
  Widget build(BuildContext context) {
    //responsive
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      'assets/img/cipres/carbon/carbon_c.png',
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
                  'Calculando carbono en la biomasa con Ciprés',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                //Formula
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
                      onPressed: () {},
                      child: const Text(
                        'CBV(T/ha): BVT * 0.5000',
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
                      horizontal: size.width * 0.12,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*CBV: Carbono en biomasa vegetal(T/ha) \n'
                        '*0.5000: Fracción de carbono de Ciprés \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),

                //Formula con variable completa
                SizedBox(height: size.height * 0.03),
                Column(
                  children: <Widget>[
                    Text(
                      'Reemplazando valores:\n'
                      'CBV(T/ha): ${stateBiomassC!.totalBiomassC.toStringAsFixed(2)} * 0.5000 \n ',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                //Mensaje de error
                if (errorMessage != null) ...[
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],

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
    );
  }
}
