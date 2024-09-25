import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version/presentation/screens/cipres/biomass/state_biomass_c.dart';
import 'package:version/presentation/screens/cipres/cipres_screen.dart';
import 'package:intl/intl.dart';

class GreenMatterC extends StatefulWidget {
  const GreenMatterC({super.key});

  @override
  State<GreenMatterC> createState() => _GreenMatterCState();
}

class _GreenMatterCState extends State<GreenMatterC> {
  //variable que puede ser null o de tipo String
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightC = TextEditingController();
  double? greenCipres;

  //Validar el peso
  String? _validateWeightC(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor, ingresa el peso";
    }
    final wieghtRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!wieghtRegExp.hasMatch(value)) {
      return 'Solo se acepta valores numéricos';
    }
    return null;
  }

  //Validación del boton
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final double greenMatterC = double.parse(_controllerWeightC.text);
      final double greenCipres = greenMatterC;

      Provider.of<StateBiomassC>(context, listen: false)
          .setGreenCipres(greenCipres);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CipresScreen()));
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Se procede al corte y pesado del material vegetativo del SSP, en un área de 1 m2, con 3 repeticiones, con el apoyo de un cuadrante de madera o fierro y una hoz se va a realizar el corte a una altura de 05 cm del suelo, para luego pesar las muestras en una balanza de 5kg, expresando el resultado en kg de materia verde/m2 (kg mv.m2). \n'
                '(Vásquez, 2023)',
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
                        'assets/img/cipres/greenmatter/green_matter_c.jpg',
                        fit: BoxFit.fitWidth,
                        height: size.height * 0.55,
                      ),
                    ),

                    //Position of the buttom
                    Positioned(
                      top: size.height * 0.05,
                      right: size.width * 0.01,
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
                  SizedBox(height: size.height * 0.03),
                  const Text(
                    'Calculando la materia verde con Ciprés',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Peso de la materia verde
                  SizedBox(height: size.height * 0.03),

                  const Text('Peso de materia verde por m²:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  SizedBox(height: size.height * 0.01),

                  //Ingresa el peso de materia verde
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightC,
                      validator: _validateWeightC,
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
                  SizedBox(height: size.height * 0.03),
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
