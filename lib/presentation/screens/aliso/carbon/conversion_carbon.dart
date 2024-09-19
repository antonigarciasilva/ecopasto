import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/aliso/biomass/state_biomass.dart';
import 'package:version/presentation/screens/aliso/carbon/carbon.dart';

class ConversionCarbonScreen extends StatefulWidget {
  const ConversionCarbonScreen({super.key});

  @override
  State<ConversionCarbonScreen> createState() => _ConversionCarbonScreenState();
}

class _ConversionCarbonScreenState extends State<ConversionCarbonScreen> {
  StateBiomass? stateBiomass;
  String? errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomass = Provider.of<StateBiomass>(context);
  }
//Mostrar mensaje de error

  void _seeError() {
    if (stateBiomass?.resultCarbonBiomass == 0.00) {
      setState(() {
        errorMessage =
            'Por favor, completa el modulo de carbono para hacer la conversión';
      });
    } else {
      setState(() {
        errorMessage = null;
      });
      _calculateCarbonToCO2Result();
    }
  }
  //Calculo de la conversión de carbono a C02

  void _calculateCarbonToCO2Result() {
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
                  'la cantidad de CO₂ es: ${stateBiomass!.resultConversionCarbon.toStringAsFixed(2)} T/ha',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CarbonScreen()));
                      },
                      child: const Text('Aceptar'))
                ]));
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
                '¿Qué es la conversión del carbono a CO₂?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'La conversión del carbono en dióxido de carbono (CO₂) es un proceso natural y humano en el que el carbono se oxida para formar CO₂. Esto ocurre en la respiración celular, la descomposición y la quema de combustibles fósiles. El aumento de CO₂ en la atmósfera es una causa principal del cambio climático. Para reducir estas emisiones, se emplean estrategias como la reforestación y el uso de energías renovables.',
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
    final stateBiomass = Provider.of<StateBiomass>(context);
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
                        'assets/img/aliso/carbon/conversion_a.jpg',
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
                    'Conversión de carbono orgánico a dióxido de carbono',
                    style: TextStyle(
                      fontSize: 20,
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
                          'CO₂ (T/ha) = CO * 3.666',
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
                        '*CO₂: Dioxido carbono \n'
                        '*3.666: Factor de conversión \n',
                        style: TextStyle(fontSize: 10),
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
                        'CO₂ (T/ha) = ${stateBiomass.resultCarbonBiomass.toStringAsFixed(2)} * 3.666',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                        onPressed: () {
                          if (stateBiomass.isConversionCarbon) {
                            _calculateCarbonToCO2Result();
                          } else {
                            _seeError();
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
        ),
      ),
    );
  }
}
