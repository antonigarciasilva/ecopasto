import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/pino/biomass/state_biomass_p.dart';
import 'package:version/presentation/screens/pino/pino_screen.dart';

class GreenMatterP extends StatefulWidget {
  const GreenMatterP({super.key});

  @override
  State<GreenMatterP> createState() => _GreenMatterPState();
}

class _GreenMatterPState extends State<GreenMatterP> {
  //Vamos a validar nuestro formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightP = TextEditingController();
  double? greenPino;

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

//Validación del boton

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final double greenMatterP = double.parse(_controllerWeightP.text);

      final double greenPino = greenMatterP;

      Provider.of<StateBiomassP>(context, listen: false)
          .setGreenPino(greenPino);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const PinoScreen()));
    }
  }

  //Funcion de boton informativo
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //solo para salir con los botones y no cuadno le das click en cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text(
                '¿Cómo sacar la materia verde?',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              content: const Text(
                'Se procede al corte y pesado del material vegetativo del SSP, en un área de 1 m2, con 3 repeticiones, con el apoyo de un cuadrante de madera o fierro y una hoz se va a realizar el corte a una altura de 05 cm del suelo, para luego pesar las muestras en una balanza de 5kg, expresando el resultado en kg de materia verde/m2 (kg mv.m2). ',
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
                        'assets/img/aliso/greenmatter/green_alder.jpg',
                        fit: BoxFit.fitWidth,
                        height: 259,
                      ),
                    ),

                    //Position of the buttom
                    Positioned(
                      right: 5,
                      top: 50,
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
                    ),
                  ]),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la materia verde con Pino',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Peso de la materia verde

                  const SizedBox(height: 25.0),

                  const Text('Peso de materia verde por m²:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(height: 5),

                  //Ingresa el peso de materia verde

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightP,
                      validator: _validateWeightP,
                      decoration: InputDecoration(
                        //prefixIcon: const Icon(Icons.person_4),

                        labelText: 'Ingresa el peso en Kg/m²',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  //Fecha actual
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Fecha de evaluación:   ${getFormattedDate()}',
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),

                  //Guardar
                  const SizedBox(height: 15.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: _submitForm,
                        child: const Text(
                          'Guardar',
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

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }
}
