import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:version/presentation/screens/pona/pona_screen.dart';

class GreenMatterPona extends StatefulWidget {
  const GreenMatterPona({super.key});

  @override
  State<GreenMatterPona> createState() => _GreenMatterPonaState();
}

class _GreenMatterPonaState extends State<GreenMatterPona> {
  String? selectedValue;
  //Vamos a validar nuestro formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightP = TextEditingController();

  //Creamos nuestras validaciones
  String? _validateEvaluationP(String? value) {
    if (value == null || value.isEmpty) {
      return ' Por favor, ingrese el día de evaluación';
    }
    return null;
  }

  //Validar form de peso
  String? _validateWeightP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }

    final wieghtRegExpP = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!wieghtRegExpP.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

//Validación del boton

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PonaScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/pona/greenmatter/green_o.png',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la materia verde con Pona',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Día de evaluación
                  const SizedBox(height: 25.0),

                  const Text('Seleccione días evaluación:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DropdownButtonFormField<String>(
                      validator: _validateEvaluationP,
                      value: selectedValue,
                      hint: const Text('Elija el día'),
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      items: <String>['Día 30', 'Día 45', 'Día 60', 'Día 75']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  //Peso de la materia verde
                  const SizedBox(height: 25.0),

                  const Text('Peso de materia verde por m2:',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  const SizedBox(height: 20),

                  //Ingresa el peso de materia verde

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWeightP,
                      validator: _validateWeightP,
                      decoration: InputDecoration(
                        //prefixIcon: const Icon(Icons.person_4),

                        labelText: 'Ingresa el peso en KG/m2',
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
                            fontSize: 15,
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
                          backgroundColor: MaterialStateProperty.all<Color>(
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
