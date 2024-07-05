import 'package:flutter/material.dart';
import 'package:version/presentation/screens/cipres/carbon/carbon_c.dart';

class SoilCarbonC extends StatefulWidget {
  const SoilCarbonC({super.key});

  @override
  State<SoilCarbonC> createState() => _SoilCarbonCState();
}

class _SoilCarbonCState extends State<SoilCarbonC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightA = TextEditingController();
  final TextEditingController _controllerWeightP = TextEditingController();
  final TextEditingController _controllerWeightDA = TextEditingController();

  //Validación de los pesos
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un valor';
    }
    //Validación con regex
    final soilRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!soilRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  //Calculamos el carbono en el suelo

  void _calculateAndShowResult() {
    if (_formKey.currentState!.validate()) {
      final double area = double.parse(_controllerWeightA.text);
      final double depth = double.parse(_controllerWeightP.text);
      final double density = double.parse(_controllerWeightDA.text);

      final double result = area * depth * density;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  title: const Text(
                    'Resultado del cálculo',
                    style: TextStyle(fontSize: 18),
                  ),
                  content: Text(
                    'El peso del suelo (Ws) es: $result T/ha',
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

/*
  //Validamos el boton
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CarbonScreenC()));
    }
  }
*/

  //Dialogo informativo sobre el carbono
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Qué es el carbono en el suelo?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'El carbono en el suelo es la cantidad de carbono en la materia orgánica del suelo. Incluye restos de plantas y animales, y microorganismos. Este carbono entra al suelo por la descomposición de materiales orgánicos. El suelo actúa como un sumidero de carbono a largo plazo, mejorando la fertilidad y estructura del suelo.',
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
                    'Calculando carbono en el suelo',
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
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Ws (T/ha) = a * p * da',
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
                        '*Ws: Peso del suelo (T/ha) ',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),

                  //Área
                  const SizedBox(height: 25),

                  const Text(
                    'Área (a): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: _controllerWeightA,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese el (a) en hectáreas',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Profundidad
                  const SizedBox(height: 25),

                  const Text(
                    'Profundidad (p): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: _controllerWeightP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa la (p) en metros',
                        labelStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Densidad aparente del suelo
                  const SizedBox(height: 25),

                  const Text(
                    'Densidad aparente del suelo (da): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      validator: _validateWeight,
                      controller: _controllerWeightDA,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingrese la (da) en Kg/m³',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Guardar
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
                        onPressed: _calculateAndShowResult,
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
