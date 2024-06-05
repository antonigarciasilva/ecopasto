import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/biomass/biomass.dart';

class NewDryBiomassScreen extends StatefulWidget {
  const NewDryBiomassScreen({super.key});

  @override
  State<NewDryBiomassScreen> createState() => _NewDryBiomassScreenState();
}

class _NewDryBiomassScreenState extends State<NewDryBiomassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDap = TextEditingController();
  double? resultdba;

  //Validación del DAP
  String? _validateDap(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el DAP';
    }
    // Validación de regex solo números
    final dapRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!dapRegExp.hasMatch(value)) {
      return 'Solo se aceptan valores numéricos';
    }
    return null;
  }

  //Función para calcular la biomasa seca
  void _calculateDryBiomass() {
    if (_formKey.currentState!.validate()) {
      double dap = double.parse(_controllerDap.text);

      resultdba = -22.695 + 1.5085 * (dap);
      final String formattedResult = resultdba!.toStringAsFixed(2);

      setState(() {});

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  title: const Text('Resultado del cáculo'),
                  content: Text(
                    'La biomasa seca es: $formattedResult ',
                    textAlign: TextAlign.justify,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BiomassAlderScreen(resultdba: resultdba),
                          ),
                        );
                      },
                      child: const Text('Aceptar'),
                    )
                  ]));
    }
  }

  //Dialogo de información sobre la biomasa seca
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuando le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es la biomasa seca?',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'La biomasa seca es la materia orgánica total de un árbol, medida en peso seco. Se calcula usando el diámetro a la altura del pecho (DAP) y fórmulas alométricas específicas para cada especie.',
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
                      'assets/img/aliso/biomass/biomas_alder.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),
                  //Posición del botón
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
                  'Calculando la biomasa seca',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                //Formula
                const SizedBox(height: 25.0),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 191, 192, 191)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'C = -22.695 + 1.5085 * DAP',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                //Día de evaluación
                const SizedBox(height: 20.0),
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

                //Formulario del DAP
                const SizedBox(height: 25.0),
                const Text(
                  'Diámetro a la altura del pecho (DAP): ',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerDap,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Ingrese el DAP (cm)',
                            labelStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          validator: _validateDap,
                        ),

                        //Calcular
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 51, 79, 31)),
                          ),
                          onPressed: _calculateDryBiomass,
                          child: const Text(
                            'Calcular',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (resultdba != null)
                          Visibility(
                            visible: false,
                            child: Text(
                              ' ${resultdba?.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                      ],
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
