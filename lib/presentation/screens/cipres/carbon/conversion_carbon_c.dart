import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class ConversionCarbonC extends StatefulWidget {
  const ConversionCarbonC({super.key});

  @override
  State<ConversionCarbonC> createState() => _ConversionCarbonCState();
}

class _ConversionCarbonCState extends State<ConversionCarbonC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerCO = TextEditingController();

  //Validar el peso
  String? _validateWeightCO(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el peso';
    }
    //validar con ReGEXP
    final coRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!coRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  //Calculo de la conversión de carbono a C02

  void _calculateCarbonToCO2Result() {
    if (_formKey.currentState!.validate()) {
      final double co = double.parse(_controllerCO.text);

      final double resultCtoCO2c = co * 3.666;
      final String formattedResult = resultCtoCO2c.toStringAsFixed(2);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  title: const Text(
                    'Resultado del cálculo',
                  ),
                  content: Text(
                    'la cantidad de CO₂ es: $formattedResult Tn/ha',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CarbonScreenC()));
                        },
                        child: const Text('Aceptar'))
                  ]));
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
                '¿Qué es la conversión del carbono a CO2?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'La conversión del carbono en dióxido de carbono (CO₂) es un proceso natural y humano en el que el carbono se oxida para formar CO₂. Esto ocurre en la respiración celular, la descomposición y la quema de combustibles fósiles. El aumento de CO₂ en la atmósfera es una causa principal del cambio climático. Para reducir estas emisiones, se emplean estrategias como la reforestación y el uso de energías renovables.',
                textAlign: TextAlign.justify,
              ),
              actions: [
                //con el goRouter podemos acceder al context.pop

                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConversionCarbonC()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'CO₂ (Tm/ha) = CO * 3.666',
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

                  //Día de evaluación
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Día de evaluación: ',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(width: 20),
                    ],
                  ),

                  //BVT
                  const SizedBox(height: 25),

                  const Text(
                    'Carbono orgánico (CO): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerCO,
                      validator: _validateWeightCO,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese el valor de (CO)',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Calcular
                  const SizedBox(height: 20.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
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
