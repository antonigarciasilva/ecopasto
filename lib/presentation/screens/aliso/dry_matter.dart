import 'package:flutter/material.dart';

import 'package:version/presentation/screens/aliso/aliso_screen.dart';

class DryMatterScreen extends StatefulWidget {
  const DryMatterScreen({super.key});
  @override
  MyGreenMatterScreen createState() => MyGreenMatterScreen();
}

class MyGreenMatterScreen extends State<DryMatterScreen> {
  //String? selectedValue;

  //Para hacer las validaciones tenemos que tner nuestro:
  // Globalkey para ver el estado del formulario  y los controladores para poder acceder a la i del texto
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerDryWeight = TextEditingController();
  final TextEditingController _controllerWetWeight = TextEditingController();

  //Validamos el peso de seco
  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el peso';
    }

    //Validación de regex
    final dryWeight = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    if (!dryWeight.hasMatch(value)) {
      return 'Solo acepta valores numéricos';
    }
    return null;
  }

  //validamos el boton calcular
  void _submitFormD() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlisoScreen()),
      );
    }
  }

  //Función de botón informativo

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        //Solo para salir con los botones y no cuando le das click a cualquier lado
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                '¿Cómo sacar el peso de la muestra seca (PSM)',
                textAlign: TextAlign.justify,
              ),
              content: const Text(
                'Se emplea una sub muestra de la materia verde de 500g dependiendo de la cantidad de pastura, luego, se coloca en una estufa a 60 °C, hasta obtener un peso constante y con la ayuda de una balanza de 1 Kg se optine el PSM',
                textAlign: TextAlign.justify,
              ),
              actions: [
                FilledButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DryMatterScreen()));
                    },
                    child: const Text('Aceptar'))
              ],
            ));
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
                  Stack(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/img/aliso/drymatter/dry_alder.jpg',
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
                    'Calculando la materia seca con Aliso',
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
                              const Color.fromARGB(255, 191, 192, 191)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'MS/m2 (Kg) = PMS/PMH x 100',
                          style: TextStyle(fontSize: 16, color: Colors.black),
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
                          '*m2: metro cuadrado',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),

                  //Día de evaluación
                  const SizedBox(height: 15.0),
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

                  //Peso de la materia verde
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
                      controller: _controllerDryWeight,
                      validator: _validateWeight,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Ingresa el peso en Kg',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Peso de la materia húmeda
                  const SizedBox(height: 25),

                  const Text(
                    'Peso de la materia húmeda(PMH): ',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerWetWeight,
                      validator: _validateWeight,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Ingresa el peso en Kg',
                        labelStyle: const TextStyle(fontSize: 15),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //Guardar
                  const SizedBox(height: 35.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 51, 79, 31)),
                        ),
                        onPressed: _submitFormD,
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
