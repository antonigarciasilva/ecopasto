import 'package:flutter/material.dart';
import 'package:version/presentation/screens/aliso/biomass/biomass.dart';

class HerbaceousBiomassScreen extends StatefulWidget {
  const HerbaceousBiomassScreen({super.key});

  @override
  State<HerbaceousBiomassScreen> createState() =>
      _HerbaceousBiomassScreenState();
}

class _HerbaceousBiomassScreenState extends State<HerbaceousBiomassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeightPSM = TextEditingController();
  final TextEditingController _controllerWeightPFM = TextEditingController();
  final TextEditingController _controllerWeightPST = TextEditingController();

  //Validación del peso
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }
    //Validación de peso
    final weightRegExp = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!weightRegExp.hasMatch(value)) {
      return 'Solo acepta valores númericos';
    }
    return null;
  }

  //Validación el bottom guardar
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BiomassAlderScreen()));
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
                      'assets/img/biomas_alder.jpg',
                      fit: BoxFit.fitWidth,
                      height: 259,
                    ),
                  ),

                  //Título
                  const SizedBox(height: 25.0),
                  const Text(
                    'Calculando la biomasa herbácea con Aliso',
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
                      width: 320,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'BH(t/ha) = ((PSM/PFM) * PFT) * 0.01',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //NOTA
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*BH: Biomasa herbácea(t/ha) \n'
                          '*PSM: Peso seco de la materia recolectada (g)\n'
                          '*PFM: Peso fresco de la muestra colectada (g) \n'
                          '*PFT: Peso fresco total por metro cuadrado (g/m2) \n'
                          '*0.01: Factor de conversión para biomasa herbácea \n',
                          style: TextStyle(fontSize: 10),
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

                  //PSM
                  const SizedBox(height: 25),

                  const Text(
                    'PSM: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerWeightPSM,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'g',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //PFM
                  const SizedBox(height: 25),

                  const Text(
                    'PFM: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerWeightPFM,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'g',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //PST
                  const SizedBox(height: 25),

                  const Text(
                    'PST: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: _controllerWeightPST,
                      validator: _validateWeight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'g',
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
}
