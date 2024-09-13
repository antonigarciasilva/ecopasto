import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';

import 'package:version/presentation/screens/pino/pino_screen.dart';

class DryMatterP extends StatefulWidget {
  const DryMatterP({super.key});

  @override
  State<DryMatterP> createState() => _DryMatterPState();
}

class _DryMatterPState extends State<DryMatterP> {
  //Vamos a validar nuestro formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightDry = TextEditingController();
  //Creamos la variable
  StateBiomassP? stateBiomassP;
  //invocamos al provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stateBiomassP = Provider.of<StateBiomassP>(context);
  }

  double? dryMatterPino;

  //Validar form de peso
  String? _validateWeightP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }

    final wieghtRegExpP = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!wieghtRegExpP.hasMatch(value)) {
      return 'Solo se acepta valores numéricos';
    }
    return null;
  }
// Cálculo de la materia seca

  void _calculateDryMatterResult() {
    if (_formKey.currentState!.validate()) {
      final double pms = double.parse(_controllerWeightDry.text);

      final double dryMatterPino = pms / (stateBiomassP!.greenPino ?? 0) * 100;
      final String formattedResult = dryMatterPino.toStringAsFixed(2);

      Provider.of<StateBiomassP>(context, listen: false)
          .setDryMatterPino(dryMatterPino);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Resultado del cáculo',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: Text(
                    'El peso de la materia seca es: $formattedResult % MS',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PinoScreen()));
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

  //Función de botón informativo

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //Solo para salir con los botones y no cuando le das click a cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Cómo sacar el peso de la muestra seca (PSM)',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'Se emplea una sub muestra de la materia verde de 500g dependiendo de la cantidad de pastura, luego, se coloca en una estufa a 60 °C, hasta obtener un peso constante y con la ayuda de una balanza de 1 Kg se obtiene el PSM',
                textAlign: TextAlign.justify,
              ),
              actions: [
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
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/img/pino/drymatter/dry_matter.jpg',
                        fit: BoxFit.fitWidth,
                        height: 259,
                      ),
                    ),

                    //Possition of the botton
                    Positioned(
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
                    'Calculando la materia seca con Pino',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'MS/m² (Kg) = PMS/PMH * 100',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  //NOTA

                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*MS: materia seca \n'
                          '*m²: metro cuadrado',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Peso de la materia seca
                  const SizedBox(height: 25),

                  const Text(
                    'Peso de la materia seca (PMS): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightDry,
                      validator: _validateWeightP,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa el peso en Kg',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Calcular
                  const SizedBox(height: 35.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: _calculateDryMatterResult,
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
