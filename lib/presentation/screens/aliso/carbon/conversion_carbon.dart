import 'package:flutter/material.dart';
import 'package:version/presentation/screens/select_system/new_select_silvo_screen.dart';

class ConversionCarbonScreen extends StatefulWidget {
  const ConversionCarbonScreen({super.key});

  @override
  State<ConversionCarbonScreen> createState() => _ConversionCarbonScreenState();
}

class _ConversionCarbonScreenState extends State<ConversionCarbonScreen> {
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

  //Validar el buttum
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NewSelectSilvoScreen()));
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
                      'assets/img/aliso/biomass/biomas_alder.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

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
