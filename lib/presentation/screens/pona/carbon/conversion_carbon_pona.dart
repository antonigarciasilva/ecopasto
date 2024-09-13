import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pona/biomass/state_biomass_o.dart';
import 'package:version/presentation/screens/pona/carbon/carbon_pona.dart';

class ConversionCarbonPona extends StatefulWidget {
  const ConversionCarbonPona({super.key});

  @override
  State<ConversionCarbonPona> createState() => _ConversionCarbonPonaState();
}

class _ConversionCarbonPonaState extends State<ConversionCarbonPona> {
  StateBiomassO? stateBiomassO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassO = Provider.of<StateBiomassO>(context);
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
                  style: TextStyle(fontSize: 18),
                ),
                content: Text(
                  'la cantidad de CO₂ es: ${stateBiomassO!.resultConversionCarbonO.toStringAsFixed(2)} T/ha',
                  textAlign: TextAlign.justify,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CarbonPonaScreen()));
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
                '¿Qué es la conversión del carbono a CO2?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'La conversión del carbono en dióxido de carbono (CO₂) es un proceso natural y humano en el que el carbono se oxida para formar CO₂. Esto ocurre en la respiración celular, la descomposición y la quema de combustibles fósiles. El aumento de CO₂ en la atmósfera es una causa principal del cambio climático. Para reducir estas emisiones, se emplean estrategias como la reforestación y el uso de energías renovables.',
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
                        'assets/img/pona/carbon/carbon_o.png',
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
                  const SizedBox(height: 25.0),
                  const Text(
                    'Conversión de carbono orgánico a dióxido de carbono',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Formula
                  const SizedBox(height: 25.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
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
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*CO₂: Dioxido carbono \n'
                        '*3.666: Factor de conversión \n',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),

                  //Formula con variable completa
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reemplazando valores:\n'
                        'CO₂ (T/ha) = ${stateBiomassO!.resultCarbonBiomassO.toStringAsFixed(2)} * 3.666',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),

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
                        onPressed: _calculateCarbonToCO2Result,
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
