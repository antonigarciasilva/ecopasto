import 'package:flutter/material.dart';
import 'package:version/presentation/screens/pino/carbon/carbon.dart';

class SoilCarbonPino extends StatefulWidget {
  const SoilCarbonPino({super.key});

  @override
  State<SoilCarbonPino> createState() => _SoilCarbonPinoState();
}

class _SoilCarbonPinoState extends State<SoilCarbonPino> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightA = TextEditingController();
  final TextEditingController _controllerWeightP = TextEditingController();
  final TextEditingController _controllerWeightDA = TextEditingController();

  //Validación de los pesos
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa el peso';
    }
    //Validación con regex
    final soilRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!soilRegExp.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  //Validamos el boton
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CarbonPinoScreen()));
    }
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/pino/carbon/carbon_p.png',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Ws (t/ha) = a * p * da',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  //NOTA

                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '*Ws: Peso del suelo (t/ha) \n'
                        '*a: Área (ha) \n'
                        '*p: Profundidad (m) \n'
                        '*da: Densidad aparente del suelo \n',
                        style: TextStyle(fontSize: 10),
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

                  //Área
                  const SizedBox(height: 25),

                  const Text(
                    'a: ',
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
                        labelText: 'cm',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Profundidad
                  const SizedBox(height: 25),

                  const Text(
                    'p: ',
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
                        labelText: 'cm',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //PST
                  const SizedBox(height: 25),

                  const Text(
                    'da: ',
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
                        labelText: 'cm',
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: _submitForm,
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
